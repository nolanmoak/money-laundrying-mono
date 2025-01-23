// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spec.swagger.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataModel _$DataModelFromJson(Map<String, dynamic> json) => DataModel(
      city: json['city'] as String,
      state: json['state'] as String,
      stateCode: json['stateCode'] as String,
      country: json['country'] as String,
      countryCode: json['countryCode'] as String,
      electricityCompanies: (json['electricityCompanies'] as List<dynamic>?)
              ?.map((e) => PeakDataElectricityCompany.fromJson(
                  e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$DataModelToJson(DataModel instance) => <String, dynamic>{
      'city': instance.city,
      'state': instance.state,
      'stateCode': instance.stateCode,
      'country': instance.country,
      'countryCode': instance.countryCode,
      'electricityCompanies':
          instance.electricityCompanies.map((e) => e.toJson()).toList(),
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

PeakDataElectricityCompany _$PeakDataElectricityCompanyFromJson(
        Map<String, dynamic> json) =>
    PeakDataElectricityCompany(
      name: json['name'] as String,
      url: json['url'] as String,
      days: (json['days'] as List<dynamic>?)
              ?.map((e) => PeakDataDay.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$PeakDataElectricityCompanyToJson(
        PeakDataElectricityCompany instance) =>
    <String, dynamic>{
      'name': instance.name,
      'url': instance.url,
      'days': instance.days.map((e) => e.toJson()).toList(),
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
