import 'dart:async';
import 'dart:math';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:frontend/components/empty.dart';
import 'package:frontend/generated/spec.swagger.dart';
import 'package:frontend/utils/data_utils.dart';
import 'package:frontend/utils/date_utils.dart';
import 'package:google_fonts/google_fonts.dart';

class Dial extends StatefulWidget {
  const Dial({super.key, required this.data});

  final Future<DataModel?>? data;

  @override
  State<Dial> createState() => _DialState();
}

class _DialState extends State<Dial> {
  DataModel? data;
  int lastWeekday = -1;
  List<ParsedPeakData> allPeakTimes = [];
  double currentTimeFraction = 0;
  String? currentPeak;
  Color? currentPeakColor;
  String? nextPeak;
  Color? nextPeakColor;
  DeltaTime? timeUntilNextPeak;

  void _onPeriodicUpdate() {
    setState(() {
      final dateTime = DateTime.now();
      currentTimeFraction = getDatetimeFraction(dateTime);
      if (data == null) {
        return;
      }
      final currentData = data!;
      if (lastWeekday != dateTime.weekday) {
        final peakDataEntries = getPeakDataEntriesForWeekday(
            currentData, dateTime, dateTime.weekday);
        if (peakDataEntries == null) {
          throw Exception('Invalid peak data');
        }
        allPeakTimes = parsePeakData(peakDataEntries);
      }

      var currentPeakIndex = allPeakTimes.indexWhere(
        (item) => isBetween(item.time.start, item.time.end, dateTime.hour),
      );
      var nextPeakIndex = currentPeakIndex + 1;
      var nextPeakTimes = allPeakTimes;
      final isLast =
          currentPeakIndex < 0 || currentPeakIndex == allPeakTimes.length - 1;
      if (isLast) {
        currentPeakIndex = allPeakTimes.length - 1;
        final nextPeakData = getPeakDataEntriesForWeekday(
          currentData,
          dateTime,
          getNextWeekday(dateTime.weekday),
        );
        if (nextPeakData == null) {
          throw Exception('Invalid next peak data');
        }
        nextPeakTimes = parsePeakData(nextPeakData);
        nextPeakIndex = 0;
      }

      final currentPeakRecord = allPeakTimes[currentPeakIndex];
      currentPeak = currentPeakRecord.title;
      currentPeakColor = currentPeakRecord.color;
      final nextPeakRecord = nextPeakTimes[nextPeakIndex];
      nextPeak = nextPeakRecord.title;
      nextPeakColor = nextPeakRecord.color;

      timeUntilNextPeak =
          getDeltaTimeUntilNextPeak(dateTime, nextPeakRecord.time.start);

      lastWeekday = dateTime.weekday;
    });
  }

  void resolveData() async {
    final resolvedData = await widget.data;
    setState(() {
      data = resolvedData;
    });
  }

  @override
  void didUpdateWidget(covariant Dial oldWidget) {
    super.didUpdateWidget(oldWidget);
    resolveData();
  }

  @override
  void initState() {
    super.initState();
    resolveData();
    _onPeriodicUpdate();
    Timer.periodic(
      const Duration(
        milliseconds: 100,
      ),
      (_) => _onPeriodicUpdate(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(40.0),
            child: LayoutBuilder(builder: (context, constraints) {
              final size = min(constraints.maxWidth, constraints.maxHeight)
                  .clamp(0.0, 2000.0);
              return SizedBox(
                width: size,
                height: size,
                child: Stack(children: [
                  Center(
                    child: FutureBuilder(
                        future: widget.data,
                        builder: (context, snapshot) {
                          return snapshot.hasData
                              ? const Empty()
                              : snapshot.hasError
                                  ? const Empty()
                                  : const SizedBox(
                                      width: 150,
                                      height: 150,
                                      child:
                                          CircularProgressIndicator.adaptive(),
                                    );
                        }),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(80.0),
                      child: PieChart(
                        PieChartData(
                          sectionsSpace: 1,
                          startDegreeOffset: -90.0 +
                              ((allPeakTimes.isNotEmpty
                                          ? allPeakTimes[0].time.start
                                          : 0) /
                                      24) *
                                  360,
                          sections: [
                            for (var item in allPeakTimes)
                              PieChartSectionData(
                                value: getHoursBetweenPeaks(
                                  item.time.start,
                                  item.time.end,
                                ).toDouble(),
                                color: item.color,
                                radius: size / 2,
                                title: item.dialLabel,
                                titlePositionPercentageOffset: 0.8,
                                titleStyle: GoogleFonts.jetBrainsMono(
                                  fontSize: 60,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: PieChart(
                      PieChartData(
                        startDegreeOffset: -90 - (0.5 / 24) * 360,
                        sectionsSpace: 0,
                        sections: [
                          for (var hour in Iterable.generate(24, (i) => i))
                            PieChartSectionData(
                              value: 1,
                              title: get24HourDisplay(hour),
                              titlePositionPercentageOffset: 0,
                              titleStyle:
                                  GoogleFonts.jetBrainsMono(fontSize: 20),
                              color: Colors.transparent,
                            ),
                        ],
                      ),
                    ),
                  ),
                  Center(
                    child: PieChart(
                      PieChartData(
                        sections: [
                          PieChartSectionData(
                            value: 1,
                            color: Colors.transparent,
                            radius: size,
                            borderSide: BorderSide(
                              color: Theme.of(context).dividerColor,
                              width: 2,
                            ),
                            title: '',
                          ),
                        ],
                      ),
                    ),
                  ),
                  Center(
                    child: CustomPaint(
                      painter: DialHandPainter(
                        currentTimeFraction: currentTimeFraction,
                      ),
                      size: Size(size, size),
                    ),
                  ),
                ]),
              );
            }),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Current Status: ', style: TextStyle(fontSize: 40)),
            Text(
              currentPeak != null ? '$currentPeak Peak' : 'Unknown',
              style: TextStyle(color: currentPeakColor, fontSize: 40),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Next Status: ', style: TextStyle(fontSize: 40)),
            Text(
              nextPeak != null ? '$nextPeak Peak ' : 'Unknown',
              style: TextStyle(color: nextPeakColor, fontSize: 40),
            ),
            if (nextPeak != null)
              const Text('in ', style: TextStyle(fontSize: 40)),
            if (timeUntilNextPeak != null)
              Text(
                formatDeltaTime(timeUntilNextPeak),
                style: GoogleFonts.jetBrainsMono(fontSize: 40),
              ),
          ],
        ),
      ],
    );
  }
}

class DialHandPainter extends CustomPainter {
  const DialHandPainter({
    super.repaint,
    required this.currentTimeFraction,
    this.strokeWidth = 6,
  });

  final double strokeWidth;
  final double currentTimeFraction;

  @override
  void paint(Canvas canvas, Size size) {
    final radians = (-90 + currentTimeFraction * 360) * pi / 180;
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = strokeWidth;
    final p1 = Offset(size.width / 2 - (strokeWidth / 2), size.height / 2);
    final p2 = Offset(p1.dx + size.width / 2 * cos(radians) + (strokeWidth / 2),
        p1.dy + size.height / 2 * sin(radians));
    canvas.drawLine(p1, p2, paint);
  }

  @override
  bool shouldRepaint(DialHandPainter oldDelegate) {
    return oldDelegate.currentTimeFraction != currentTimeFraction;
  }
}
