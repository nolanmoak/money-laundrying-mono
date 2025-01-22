// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spec.swagger.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataModel _$DataModelFromJson(Map<String, dynamic> json) => DataModel(
      data: (json['data'] as List<dynamic>?)
              ?.map((e) => PeakDataDay.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$DataModelToJson(DataModel instance) => <String, dynamic>{
      'data': instance.data.map((e) => e.toJson()).toList(),
    };

PeakDataDay _$PeakDataDayFromJson(Map<String, dynamic> json) => PeakDataDay(
      dayOfWeek: (json['dayOfWeek'] as num).toInt(),
      entries: (json['entries'] as List<dynamic>?)
              ?.map((e) => PeakDataEntry.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$PeakDataDayToJson(PeakDataDay instance) =>
    <String, dynamic>{
      'dayOfWeek': instance.dayOfWeek,
      'entries': instance.entries.map((e) => e.toJson()).toList(),
    };

PeakDataEntry _$PeakDataEntryFromJson(Map<String, dynamic> json) =>
    PeakDataEntry(
      type: peakDataTypeFromJson(json['type']),
      ranges: (json['ranges'] as List<dynamic>?)
              ?.map(
                  (e) => PeakDataHourRange.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$PeakDataEntryToJson(PeakDataEntry instance) =>
    <String, dynamic>{
      'type': peakDataTypeToJson(instance.type),
      'ranges': instance.ranges.map((e) => e.toJson()).toList(),
    };

PeakDataHourRange _$PeakDataHourRangeFromJson(Map<String, dynamic> json) =>
    PeakDataHourRange(
      start: (json['start'] as num).toInt(),
      end: (json['end'] as num).toInt(),
    );

Map<String, dynamic> _$PeakDataHourRangeToJson(PeakDataHourRange instance) =>
    <String, dynamic>{
      'start': instance.start,
      'end': instance.end,
    };
