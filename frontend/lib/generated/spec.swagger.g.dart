// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spec.swagger.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataModel _$DataModelFromJson(Map<String, dynamic> json) => DataModel(
      days: (json['days'] as List<dynamic>?)
              ?.map((e) => PeakDataDay.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$DataModelToJson(DataModel instance) => <String, dynamic>{
      'days': instance.days.map((e) => e.toJson()).toList(),
    };

Location _$LocationFromJson(Map<String, dynamic> json) => Location(
      id: json['id'] as String,
      city: json['city'] as String,
      state: json['state'] as String,
      stateCode: json['stateCode'] as String,
      country: json['country'] as String,
      countryCode: json['countryCode'] as String,
    );

Map<String, dynamic> _$LocationToJson(Location instance) => <String, dynamic>{
      'id': instance.id,
      'city': instance.city,
      'state': instance.state,
      'stateCode': instance.stateCode,
      'country': instance.country,
      'countryCode': instance.countryCode,
    };

LocationAndCompany _$LocationAndCompanyFromJson(Map<String, dynamic> json) =>
    LocationAndCompany(
      location: Location.fromJson(json['location'] as Map<String, dynamic>),
      company: PeakDataElecitricityCompanyMinimal.fromJson(
          json['company'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LocationAndCompanyToJson(LocationAndCompany instance) =>
    <String, dynamic>{
      'location': instance.location.toJson(),
      'company': instance.company.toJson(),
    };

LocationAndCompanyModel _$LocationAndCompanyModelFromJson(
        Map<String, dynamic> json) =>
    LocationAndCompanyModel(
      locationsAndCompanies: (json['locationsAndCompanies'] as List<dynamic>?)
              ?.map(
                  (e) => LocationAndCompany.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$LocationAndCompanyModelToJson(
        LocationAndCompanyModel instance) =>
    <String, dynamic>{
      'locationsAndCompanies':
          instance.locationsAndCompanies.map((e) => e.toJson()).toList(),
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

PeakDataElecitricityCompanyMinimal _$PeakDataElecitricityCompanyMinimalFromJson(
        Map<String, dynamic> json) =>
    PeakDataElecitricityCompanyMinimal(
      id: json['id'] as String,
      name: json['name'] as String,
      url: json['url'] as String,
    );

Map<String, dynamic> _$PeakDataElecitricityCompanyMinimalToJson(
        PeakDataElecitricityCompanyMinimal instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'url': instance.url,
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
