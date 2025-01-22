import 'dart:async';
import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:frontend/generated/spec.swagger.dart';
import 'package:frontend/lib.dart';
import 'package:google_fonts/google_fonts.dart';

late final String apiUrl;

void main() async {
  await dotenv.load();
  apiUrl = dotenv.env['API_URL'] ?? '';
  if (apiUrl.isEmpty) {
    throw Exception('Unable to load API URL');
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Full-Stack Test',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Money Laundrying'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<DataModel> peakData;
  final dataSpec = Spec.create(baseUrl: Uri.parse(apiUrl));

  @override
  void initState() {
    super.initState();
    peakData = getData();
  }

  Future<DataModel> getData() async {
    final response = await dataSpec.apiDataGet();
    final responseBody = response.body;
    if (responseBody == null) {
      throw Exception('Unable to load data');
    }
    return responseBody;
  }

  void reloadData() {
    setState(() {
      peakData = getData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        toolbarHeight: 54.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder(
          future: peakData,
          builder: (context, snapshot) {
            Widget child;
            DataModel? data = snapshot.data;
            if (snapshot.hasData && data != null) {
              child = Dial(data: data);
            } else if (snapshot.hasError) {
              child = Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      color: Colors.red,
                      size: 60,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 16),
                      child: Text(
                          'Error: Unable to load data. Please try again later.'),
                    ),
                    ElevatedButton(
                      onPressed: reloadData,
                      child: const Text('Reload'),
                    ),
                  ],
                ),
              );
            } else {
              child = const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 60,
                      height: 60,
                      child: CircularProgressIndicator(),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 16),
                      child: Text('Awaiting result...'),
                    ),
                  ],
                ),
              );
            }
            return child;
          },
        ),
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  const MyPainter({
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
  bool shouldRepaint(MyPainter oldDelegate) {
    return oldDelegate.currentTimeFraction != currentTimeFraction;
  }
}

class Dial extends StatefulWidget {
  const Dial({super.key, required this.data});

  final DataModel data;

  @override
  State<Dial> createState() => _DialState();
}

class _DialState extends State<Dial> {
  late DataModel data;
  int lastWeekday = -1;
  late double currentTimeFraction;
  late List<ParsedPeakData> allPeakTimes;
  late String currentPeak;
  late Color currentPeakColor;
  late String nextPeak;
  late Color nextPeakColor;
  late DeltaTime timeUntilNextPeak;

  void _onPeriodicUpdate() {
    setState(() {
      final dateTime = DateTime.now();
      if (lastWeekday != dateTime.weekday) {
        final peakDataEntry =
            getPeakDataEntriesForWeekday(data, dateTime, dateTime.weekday);
        allPeakTimes = parsePeakData(peakDataEntry);
      }

      var currentPeakIndex = allPeakTimes.indexWhere(
        (item) => isBetween(item.time.start, item.time.end, dateTime.hour),
      );
      var nextPeakIndex = currentPeakIndex + 1;
      var nextPeakTimes = allPeakTimes;
      if (currentPeakIndex < 0) {
        currentPeakIndex = allPeakTimes.length - 1;
        final nextPeakData = getPeakDataEntriesForWeekday(
          data,
          dateTime,
          getNextWeekday(dateTime.weekday),
        );
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
      currentTimeFraction = getDatetimeFraction(dateTime);
    });
  }

  @override
  void initState() {
    super.initState();
    data = widget.data;
    _onPeriodicUpdate();
    Timer.periodic(const Duration(seconds: 1), (_) => _onPeriodicUpdate());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (allPeakTimes.isNotEmpty)
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
                      child: Padding(
                        padding: const EdgeInsets.all(80.0),
                        child: PieChart(
                          PieChartData(
                            sectionsSpace: 1,
                            startDegreeOffset:
                                -90.0 + (allPeakTimes[0].time.start / 24) * 360,
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
                        painter: MyPainter(
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
              '$currentPeak Peak',
              style: TextStyle(color: currentPeakColor, fontSize: 40),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Next Status: ', style: TextStyle(fontSize: 40)),
            Text(
              '$nextPeak Peak ',
              style: TextStyle(color: nextPeakColor, fontSize: 40),
            ),
            const Text('in ', style: TextStyle(fontSize: 40)),
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
