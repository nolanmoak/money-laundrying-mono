import 'package:flutter/material.dart';
import 'package:frontend/generated/spec.swagger.dart';

List<PeakDataEntry>? getPeakDataEntriesForWeekday(
    DataModel data, DateTime dateTime, int weekday) {
  return data.days
      .where((peakDataDay) => peakDataDay.dayOfWeek == weekday)
      .firstOrNull
      ?.entries;
}

typedef ParsedPeakData = ({
  PeakDataHourRange time,
  String title,
  String dialLabel,
  Color color
});

List<ParsedPeakData> parsePeakData(List<PeakDataEntry> peakDataEntries) {
  final offPeakTimes = peakDataEntries
      .where((entry) => entry.type == PeakDataType.off)
      .firstOrNull
      ?.ranges;
  final midPeakTimes = peakDataEntries
      .where((entry) => entry.type == PeakDataType.mid)
      .firstOrNull
      ?.ranges;
  final onPeakTimes = peakDataEntries
      .where((entry) => entry.type == PeakDataType.on)
      .firstOrNull
      ?.ranges;
  if (offPeakTimes == null || midPeakTimes == null || onPeakTimes == null) {
    throw Exception('Unable to parse peak time data for entry');
  }
  return parsePeakDataLists(offPeakTimes, midPeakTimes, onPeakTimes);
}

List<ParsedPeakData> parsePeakDataLists(List<PeakDataHourRange> offPeakTimes,
    List<PeakDataHourRange> midPeakTimes, List<PeakDataHourRange> onPeakTimes) {
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
