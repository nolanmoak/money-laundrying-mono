import 'package:flutter/material.dart';
import 'package:frontend/data.dart';

int getNextWeekday(int weekday) {
  if (weekday >= 7) {
    return 1;
  }
  return weekday + 1;
}

const winterMonths = [11, 12, 1, 2, 3, 4];

PeakDataEntry? getPeakDataEntryForWeekday(DateTime dateTime, int weekday) {
  var peakData = peakDataSummer;
  if (winterMonths.contains(dateTime.month)) {
    peakData = peakDataWinter;
  }
  return peakData[weekday];
}

typedef ParsedPeakData = ({
  PeakDataHourRange time,
  String title,
  String dialLabel,
  Color color
});

List<ParsedPeakData> parsePeakData(PeakDataEntry peakDataEntry) {
  final offPeakTimes = peakDataEntry[PeakDataType.off];
  final midPeakTimes = peakDataEntry[PeakDataType.mid];
  final onPeakTimes = peakDataEntry[PeakDataType.on];
  if (offPeakTimes == null || midPeakTimes == null || onPeakTimes == null) {
    throw Exception('Unable to parse peak time data for entry');
  }
  return parsePeakDataLists(offPeakTimes, midPeakTimes, onPeakTimes);
}

List<ParsedPeakData> parsePeakDataLists(PeakDataList offPeakTimes,
    PeakDataList midPeakTimes, PeakDataList onPeakTimes) {
  return [
    ...offPeakTimes.map((time) {
      return (
        time: time,
        title: 'Off',
        dialLabel: '\$',
        color: Colors.greenAccent
      );
    }),
    ...midPeakTimes.map((time) {
      return (
        time: time,
        title: 'Mid',
        dialLabel: '\$\$',
        color: Colors.amberAccent
      );
    }),
    ...onPeakTimes.map((time) {
      return (
        time: time,
        title: 'On',
        dialLabel: '\$\$\$',
        color: Colors.redAccent
      );
    })
  ]..sort((a, b) {
      return a.time.start - b.time.start;
    });
}

int getHoursBetweenPeaks(int peak1, int peak2) {
  if (peak2 > peak1) {
    return peak2 - peak1;
  }
  return 24 - peak1 + peak2;
}

int getHoursUntilNextPeak(int currentHour, int nextPeakHour) {
  return getHoursBetweenPeaks(currentHour, nextPeakHour) - 1;
}

String get24HourDisplay(int hour) {
  var displayHour = hour;
  var period = 'AM';
  if (hour == 0) {
    displayHour = 12;
  } else if (hour == 12) {
    period = 'PM';
  } else if (hour > 12 && hour < 24) {
    displayHour = hour - 12;
    period = 'PM';
  } else if (hour == 24) {
    displayHour = 12;
    period = 'PM';
  }
  return '$displayHour $period';
}
