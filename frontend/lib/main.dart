import 'dart:async';
import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:frontend/generated/spec.swagger.dart';
import 'package:frontend/lib.dart';
import 'package:frontend/location.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:html' as html;

late final String apiUrl;

void main() async {
  if (kIsWeb && kReleaseMode) {
    apiUrl = Uri.base.toString();
  } else {
    await dotenv.load();
    apiUrl = dotenv.env['API_URL'] ?? '';
  }

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

typedef MyHomePageData = ({
  DataModel peakData,
});

class _MyHomePageState extends State<MyHomePage> {
  late Future<MyHomePageData> pageData;
  final dataSpec = Spec.create(baseUrl: Uri.parse(apiUrl));

  @override
  void initState() {
    super.initState();
    pageData = getHomePageData();
  }

  Future<MyHomePageData> getHomePageData() async {
    final position = await determinePosition();
    final data = await getData(position);
    return (peakData: data);
  }

  Future<DataModel> getData(Position? position) async {
    final response = await dataSpec.apiDataGet(
      latitude: position?.latitude,
      longitude: position?.longitude,
    );
    final responseBody = response.body;
    if (responseBody == null) {
      throw Exception('Unable to load data');
    }
    return responseBody;
  }

  void reloadData() {
    setState(() {
      pageData = getHomePageData();
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
          future: pageData,
          builder: (context, snapshot) {
            Widget child;
            DataModel? data = snapshot.data?.peakData;
            if (snapshot.hasData && data != null) {
              child = Dial(
                data: data,
              );
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
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Text(
                          'Error: Unable to load data. Please try again later.\n${snapshot.error}'),
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
  late String currentTimeText;
  late DeltaTime timeUntilNextPeak;

  void _onPeriodicUpdate() {
    setState(() {
      final dateTime = DateTime.now();
      currentTimeText = DateFormat('EEEE, MMM. dd, h:mm:ss a').format(dateTime);
      if (lastWeekday != dateTime.weekday) {
        final peakDataEntries =
            getPeakDataEntriesForWeekday(data, dateTime, dateTime.weekday);
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
          data,
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
      currentTimeFraction = getDatetimeFraction(dateTime);
    });
  }

  Future<void> _openUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (kIsWeb) {
      html.window.open(url, '_blank');
    } else if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      return Future.error('Could not launch $url');
    }
  }

  @override
  void initState() {
    super.initState();
    data = widget.data;
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(currentTimeText, style: const TextStyle(fontSize: 40)),
            Row(
              spacing: 8,
              children: [
                Row(
                  spacing: 2,
                  children: [
                    const Icon(Icons.location_on, size: 40),
                    Text(
                      '${data.city}, ${data.stateCode}, ${data.countryCode}',
                      style: const TextStyle(fontSize: 40),
                    ),
                  ],
                ),
                TextButton(
                  onPressed: () => _openUrl(data.electricityCompany.url),
                  child: Row(
                    spacing: 2,
                    children: [
                      const Icon(Icons.open_in_new, size: 40),
                      Text(
                        data.electricityCompany.name,
                        style: const TextStyle(
                          fontSize: 40,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
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
