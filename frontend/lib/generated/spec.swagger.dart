// ignore_for_file: type=lint

import 'package:json_annotation/json_annotation.dart';
import 'package:collection/collection.dart';
import 'dart:convert';

import 'package:chopper/chopper.dart';

import 'client_mapping.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:chopper/chopper.dart' as chopper;
import 'spec.enums.swagger.dart' as enums;
export 'spec.enums.swagger.dart';

part 'spec.swagger.chopper.dart';
part 'spec.swagger.g.dart';

// **************************************************************************
// SwaggerChopperGenerator
// **************************************************************************

@ChopperApi()
abstract class Spec extends ChopperService {
  static Spec create({
    ChopperClient? client,
    http.Client? httpClient,
    Authenticator? authenticator,
    ErrorConverter? errorConverter,
    Converter? converter,
    Uri? baseUrl,
    List<Interceptor>? interceptors,
  }) {
    if (client != null) {
      return _$Spec(client);
    }

    final newClient = ChopperClient(
        services: [_$Spec()],
        converter: converter ?? $JsonSerializableConverter(),
        interceptors: interceptors ?? [],
        client: httpClient,
        authenticator: authenticator,
        errorConverter: errorConverter,
        baseUrl: baseUrl ?? Uri.parse('http://'));
    return _$Spec(newClient);
  }

  ///
  ///@param companyId
  Future<chopper.Response<DataModel>> apiDataGet({String? companyId}) {
    generatedMapping.putIfAbsent(DataModel, () => DataModel.fromJsonFactory);

    return _apiDataGet(companyId: companyId);
  }

  ///
  ///@param companyId
  @Get(path: '/api/Data')
  Future<chopper.Response<DataModel>> _apiDataGet(
      {@Query('companyId') String? companyId});

  ///
  Future<chopper.Response<LocationAndCompanyModel>>
      apiLocationCompaniesFlatGet() {
    generatedMapping.putIfAbsent(
        LocationAndCompanyModel, () => LocationAndCompanyModel.fromJsonFactory);

    return _apiLocationCompaniesFlatGet();
  }

  ///
  @Get(path: '/api/Location/companies/flat')
  Future<chopper.Response<LocationAndCompanyModel>>
      _apiLocationCompaniesFlatGet();

  ///
  ///@param latitude
  ///@param longitude
  Future<chopper.Response<Location>> apiLocationCurrentGet({
    num? latitude,
    num? longitude,
  }) {
    generatedMapping.putIfAbsent(Location, () => Location.fromJsonFactory);

    return _apiLocationCurrentGet(latitude: latitude, longitude: longitude);
  }

  ///
  ///@param latitude
  ///@param longitude
  @Get(path: '/api/Location/current')
  Future<chopper.Response<Location>> _apiLocationCurrentGet({
    @Query('latitude') num? latitude,
    @Query('longitude') num? longitude,
  });
}

@JsonSerializable(explicitToJson: true)
class DataModel {
  const DataModel({
    required this.days,
  });

  factory DataModel.fromJson(Map<String, dynamic> json) =>
      _$DataModelFromJson(json);

  static const toJsonFactory = _$DataModelToJson;
  Map<String, dynamic> toJson() => _$DataModelToJson(this);

  @JsonKey(name: 'days', includeIfNull: true, defaultValue: <PeakDataDay>[])
  final List<PeakDataDay> days;
  static const fromJsonFactory = _$DataModelFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is DataModel &&
            (identical(other.days, days) ||
                const DeepCollectionEquality().equals(other.days, days)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(days) ^ runtimeType.hashCode;
}

extension $DataModelExtension on DataModel {
  DataModel copyWith({List<PeakDataDay>? days}) {
    return DataModel(days: days ?? this.days);
  }

  DataModel copyWithWrapped({Wrapped<List<PeakDataDay>>? days}) {
    return DataModel(days: (days != null ? days.value : this.days));
  }
}

@JsonSerializable(explicitToJson: true)
class Location {
  const Location({
    required this.id,
    required this.city,
    required this.state,
    required this.stateCode,
    required this.country,
    required this.countryCode,
  });

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);

  static const toJsonFactory = _$LocationToJson;
  Map<String, dynamic> toJson() => _$LocationToJson(this);

  @JsonKey(name: 'id', includeIfNull: true)
  final String id;
  @JsonKey(name: 'city', includeIfNull: true)
  final String city;
  @JsonKey(name: 'state', includeIfNull: true)
  final String state;
  @JsonKey(name: 'stateCode', includeIfNull: true)
  final String stateCode;
  @JsonKey(name: 'country', includeIfNull: true)
  final String country;
  @JsonKey(name: 'countryCode', includeIfNull: true)
  final String countryCode;
  static const fromJsonFactory = _$LocationFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is Location &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.city, city) ||
                const DeepCollectionEquality().equals(other.city, city)) &&
            (identical(other.state, state) ||
                const DeepCollectionEquality().equals(other.state, state)) &&
            (identical(other.stateCode, stateCode) ||
                const DeepCollectionEquality()
                    .equals(other.stateCode, stateCode)) &&
            (identical(other.country, country) ||
                const DeepCollectionEquality()
                    .equals(other.country, country)) &&
            (identical(other.countryCode, countryCode) ||
                const DeepCollectionEquality()
                    .equals(other.countryCode, countryCode)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(city) ^
      const DeepCollectionEquality().hash(state) ^
      const DeepCollectionEquality().hash(stateCode) ^
      const DeepCollectionEquality().hash(country) ^
      const DeepCollectionEquality().hash(countryCode) ^
      runtimeType.hashCode;
}

extension $LocationExtension on Location {
  Location copyWith(
      {String? id,
      String? city,
      String? state,
      String? stateCode,
      String? country,
      String? countryCode}) {
    return Location(
        id: id ?? this.id,
        city: city ?? this.city,
        state: state ?? this.state,
        stateCode: stateCode ?? this.stateCode,
        country: country ?? this.country,
        countryCode: countryCode ?? this.countryCode);
  }

  Location copyWithWrapped(
      {Wrapped<String>? id,
      Wrapped<String>? city,
      Wrapped<String>? state,
      Wrapped<String>? stateCode,
      Wrapped<String>? country,
      Wrapped<String>? countryCode}) {
    return Location(
        id: (id != null ? id.value : this.id),
        city: (city != null ? city.value : this.city),
        state: (state != null ? state.value : this.state),
        stateCode: (stateCode != null ? stateCode.value : this.stateCode),
        country: (country != null ? country.value : this.country),
        countryCode:
            (countryCode != null ? countryCode.value : this.countryCode));
  }
}

@JsonSerializable(explicitToJson: true)
class LocationAndCompany {
  const LocationAndCompany({
    required this.location,
    required this.company,
  });

  factory LocationAndCompany.fromJson(Map<String, dynamic> json) =>
      _$LocationAndCompanyFromJson(json);

  static const toJsonFactory = _$LocationAndCompanyToJson;
  Map<String, dynamic> toJson() => _$LocationAndCompanyToJson(this);

  @JsonKey(name: 'location', includeIfNull: true)
  final Location location;
  @JsonKey(name: 'company', includeIfNull: true)
  final PeakDataElecitricityCompanyMinimal company;
  static const fromJsonFactory = _$LocationAndCompanyFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is LocationAndCompany &&
            (identical(other.location, location) ||
                const DeepCollectionEquality()
                    .equals(other.location, location)) &&
            (identical(other.company, company) ||
                const DeepCollectionEquality().equals(other.company, company)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(location) ^
      const DeepCollectionEquality().hash(company) ^
      runtimeType.hashCode;
}

extension $LocationAndCompanyExtension on LocationAndCompany {
  LocationAndCompany copyWith(
      {Location? location, PeakDataElecitricityCompanyMinimal? company}) {
    return LocationAndCompany(
        location: location ?? this.location, company: company ?? this.company);
  }

  LocationAndCompany copyWithWrapped(
      {Wrapped<Location>? location,
      Wrapped<PeakDataElecitricityCompanyMinimal>? company}) {
    return LocationAndCompany(
        location: (location != null ? location.value : this.location),
        company: (company != null ? company.value : this.company));
  }
}

@JsonSerializable(explicitToJson: true)
class LocationAndCompanyModel {
  const LocationAndCompanyModel({
    required this.locationsAndCompanies,
  });

  factory LocationAndCompanyModel.fromJson(Map<String, dynamic> json) =>
      _$LocationAndCompanyModelFromJson(json);

  static const toJsonFactory = _$LocationAndCompanyModelToJson;
  Map<String, dynamic> toJson() => _$LocationAndCompanyModelToJson(this);

  @JsonKey(
      name: 'locationsAndCompanies',
      includeIfNull: true,
      defaultValue: <LocationAndCompany>[])
  final List<LocationAndCompany> locationsAndCompanies;
  static const fromJsonFactory = _$LocationAndCompanyModelFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is LocationAndCompanyModel &&
            (identical(other.locationsAndCompanies, locationsAndCompanies) ||
                const DeepCollectionEquality().equals(
                    other.locationsAndCompanies, locationsAndCompanies)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(locationsAndCompanies) ^
      runtimeType.hashCode;
}

extension $LocationAndCompanyModelExtension on LocationAndCompanyModel {
  LocationAndCompanyModel copyWith(
      {List<LocationAndCompany>? locationsAndCompanies}) {
    return LocationAndCompanyModel(
        locationsAndCompanies:
            locationsAndCompanies ?? this.locationsAndCompanies);
  }

  LocationAndCompanyModel copyWithWrapped(
      {Wrapped<List<LocationAndCompany>>? locationsAndCompanies}) {
    return LocationAndCompanyModel(
        locationsAndCompanies: (locationsAndCompanies != null
            ? locationsAndCompanies.value
            : this.locationsAndCompanies));
  }
}

@JsonSerializable(explicitToJson: true)
class PeakDataDay {
  const PeakDataDay({
    required this.dayOfWeek,
    required this.entries,
  });

  factory PeakDataDay.fromJson(Map<String, dynamic> json) =>
      _$PeakDataDayFromJson(json);

  static const toJsonFactory = _$PeakDataDayToJson;
  Map<String, dynamic> toJson() => _$PeakDataDayToJson(this);

  @JsonKey(name: 'dayOfWeek', includeIfNull: true)
  final int dayOfWeek;
  @JsonKey(
      name: 'entries', includeIfNull: true, defaultValue: <PeakDataEntry>[])
  final List<PeakDataEntry> entries;
  static const fromJsonFactory = _$PeakDataDayFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is PeakDataDay &&
            (identical(other.dayOfWeek, dayOfWeek) ||
                const DeepCollectionEquality()
                    .equals(other.dayOfWeek, dayOfWeek)) &&
            (identical(other.entries, entries) ||
                const DeepCollectionEquality().equals(other.entries, entries)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(dayOfWeek) ^
      const DeepCollectionEquality().hash(entries) ^
      runtimeType.hashCode;
}

extension $PeakDataDayExtension on PeakDataDay {
  PeakDataDay copyWith({int? dayOfWeek, List<PeakDataEntry>? entries}) {
    return PeakDataDay(
        dayOfWeek: dayOfWeek ?? this.dayOfWeek,
        entries: entries ?? this.entries);
  }

  PeakDataDay copyWithWrapped(
      {Wrapped<int>? dayOfWeek, Wrapped<List<PeakDataEntry>>? entries}) {
    return PeakDataDay(
        dayOfWeek: (dayOfWeek != null ? dayOfWeek.value : this.dayOfWeek),
        entries: (entries != null ? entries.value : this.entries));
  }
}

@JsonSerializable(explicitToJson: true)
class PeakDataElecitricityCompanyMinimal {
  const PeakDataElecitricityCompanyMinimal({
    required this.id,
    required this.name,
    required this.url,
  });

  factory PeakDataElecitricityCompanyMinimal.fromJson(
          Map<String, dynamic> json) =>
      _$PeakDataElecitricityCompanyMinimalFromJson(json);

  static const toJsonFactory = _$PeakDataElecitricityCompanyMinimalToJson;
  Map<String, dynamic> toJson() =>
      _$PeakDataElecitricityCompanyMinimalToJson(this);

  @JsonKey(name: 'id', includeIfNull: true)
  final String id;
  @JsonKey(name: 'name', includeIfNull: true)
  final String name;
  @JsonKey(name: 'url', includeIfNull: true)
  final String url;
  static const fromJsonFactory = _$PeakDataElecitricityCompanyMinimalFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is PeakDataElecitricityCompanyMinimal &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.url, url) ||
                const DeepCollectionEquality().equals(other.url, url)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(url) ^
      runtimeType.hashCode;
}

extension $PeakDataElecitricityCompanyMinimalExtension
    on PeakDataElecitricityCompanyMinimal {
  PeakDataElecitricityCompanyMinimal copyWith(
      {String? id, String? name, String? url}) {
    return PeakDataElecitricityCompanyMinimal(
        id: id ?? this.id, name: name ?? this.name, url: url ?? this.url);
  }

  PeakDataElecitricityCompanyMinimal copyWithWrapped(
      {Wrapped<String>? id, Wrapped<String>? name, Wrapped<String>? url}) {
    return PeakDataElecitricityCompanyMinimal(
        id: (id != null ? id.value : this.id),
        name: (name != null ? name.value : this.name),
        url: (url != null ? url.value : this.url));
  }
}

@JsonSerializable(explicitToJson: true)
class PeakDataEntry {
  const PeakDataEntry({
    required this.type,
    required this.ranges,
  });

  factory PeakDataEntry.fromJson(Map<String, dynamic> json) =>
      _$PeakDataEntryFromJson(json);

  static const toJsonFactory = _$PeakDataEntryToJson;
  Map<String, dynamic> toJson() => _$PeakDataEntryToJson(this);

  @JsonKey(
    name: 'type',
    includeIfNull: true,
    toJson: peakDataTypeToJson,
    fromJson: peakDataTypeFromJson,
  )
  final enums.PeakDataType type;
  @JsonKey(
      name: 'ranges', includeIfNull: true, defaultValue: <PeakDataHourRange>[])
  final List<PeakDataHourRange> ranges;
  static const fromJsonFactory = _$PeakDataEntryFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is PeakDataEntry &&
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)) &&
            (identical(other.ranges, ranges) ||
                const DeepCollectionEquality().equals(other.ranges, ranges)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(type) ^
      const DeepCollectionEquality().hash(ranges) ^
      runtimeType.hashCode;
}

extension $PeakDataEntryExtension on PeakDataEntry {
  PeakDataEntry copyWith(
      {enums.PeakDataType? type, List<PeakDataHourRange>? ranges}) {
    return PeakDataEntry(
        type: type ?? this.type, ranges: ranges ?? this.ranges);
  }

  PeakDataEntry copyWithWrapped(
      {Wrapped<enums.PeakDataType>? type,
      Wrapped<List<PeakDataHourRange>>? ranges}) {
    return PeakDataEntry(
        type: (type != null ? type.value : this.type),
        ranges: (ranges != null ? ranges.value : this.ranges));
  }
}

@JsonSerializable(explicitToJson: true)
class PeakDataHourRange {
  const PeakDataHourRange({
    required this.start,
    required this.end,
  });

  factory PeakDataHourRange.fromJson(Map<String, dynamic> json) =>
      _$PeakDataHourRangeFromJson(json);

  static const toJsonFactory = _$PeakDataHourRangeToJson;
  Map<String, dynamic> toJson() => _$PeakDataHourRangeToJson(this);

  @JsonKey(name: 'start', includeIfNull: true)
  final int start;
  @JsonKey(name: 'end', includeIfNull: true)
  final int end;
  static const fromJsonFactory = _$PeakDataHourRangeFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is PeakDataHourRange &&
            (identical(other.start, start) ||
                const DeepCollectionEquality().equals(other.start, start)) &&
            (identical(other.end, end) ||
                const DeepCollectionEquality().equals(other.end, end)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(start) ^
      const DeepCollectionEquality().hash(end) ^
      runtimeType.hashCode;
}

extension $PeakDataHourRangeExtension on PeakDataHourRange {
  PeakDataHourRange copyWith({int? start, int? end}) {
    return PeakDataHourRange(start: start ?? this.start, end: end ?? this.end);
  }

  PeakDataHourRange copyWithWrapped({Wrapped<int>? start, Wrapped<int>? end}) {
    return PeakDataHourRange(
        start: (start != null ? start.value : this.start),
        end: (end != null ? end.value : this.end));
  }
}

String? peakDataTypeNullableToJson(enums.PeakDataType? peakDataType) {
  return peakDataType?.value;
}

String? peakDataTypeToJson(enums.PeakDataType peakDataType) {
  return peakDataType.value;
}

enums.PeakDataType peakDataTypeFromJson(
  Object? peakDataType, [
  enums.PeakDataType? defaultValue,
]) {
  return enums.PeakDataType.values
          .firstWhereOrNull((e) => e.value == peakDataType) ??
      defaultValue ??
      enums.PeakDataType.swaggerGeneratedUnknown;
}

enums.PeakDataType? peakDataTypeNullableFromJson(
  Object? peakDataType, [
  enums.PeakDataType? defaultValue,
]) {
  if (peakDataType == null) {
    return null;
  }
  return enums.PeakDataType.values
          .firstWhereOrNull((e) => e.value == peakDataType) ??
      defaultValue;
}

String peakDataTypeExplodedListToJson(List<enums.PeakDataType>? peakDataType) {
  return peakDataType?.map((e) => e.value!).join(',') ?? '';
}

List<String> peakDataTypeListToJson(List<enums.PeakDataType>? peakDataType) {
  if (peakDataType == null) {
    return [];
  }

  return peakDataType.map((e) => e.value!).toList();
}

List<enums.PeakDataType> peakDataTypeListFromJson(
  List? peakDataType, [
  List<enums.PeakDataType>? defaultValue,
]) {
  if (peakDataType == null) {
    return defaultValue ?? [];
  }

  return peakDataType.map((e) => peakDataTypeFromJson(e.toString())).toList();
}

List<enums.PeakDataType>? peakDataTypeNullableListFromJson(
  List? peakDataType, [
  List<enums.PeakDataType>? defaultValue,
]) {
  if (peakDataType == null) {
    return defaultValue;
  }

  return peakDataType.map((e) => peakDataTypeFromJson(e.toString())).toList();
}

typedef $JsonFactory<T> = T Function(Map<String, dynamic> json);

class $CustomJsonDecoder {
  $CustomJsonDecoder(this.factories);

  final Map<Type, $JsonFactory> factories;

  dynamic decode<T>(dynamic entity) {
    if (entity is Iterable) {
      return _decodeList<T>(entity);
    }

    if (entity is T) {
      return entity;
    }

    if (isTypeOf<T, Map>()) {
      return entity;
    }

    if (isTypeOf<T, Iterable>()) {
      return entity;
    }

    if (entity is Map<String, dynamic>) {
      return _decodeMap<T>(entity);
    }

    return entity;
  }

  T _decodeMap<T>(Map<String, dynamic> values) {
    final jsonFactory = factories[T];
    if (jsonFactory == null || jsonFactory is! $JsonFactory<T>) {
      return throw "Could not find factory for type $T. Is '$T: $T.fromJsonFactory' included in the CustomJsonDecoder instance creation in bootstrapper.dart?";
    }

    return jsonFactory(values);
  }

  List<T> _decodeList<T>(Iterable values) =>
      values.where((v) => v != null).map<T>((v) => decode<T>(v) as T).toList();
}

class $JsonSerializableConverter extends chopper.JsonConverter {
  @override
  FutureOr<chopper.Response<ResultType>> convertResponse<ResultType, Item>(
      chopper.Response response) async {
    if (response.bodyString.isEmpty) {
      // In rare cases, when let's say 204 (no content) is returned -
      // we cannot decode the missing json with the result type specified
      return chopper.Response(response.base, null, error: response.error);
    }

    if (ResultType == String) {
      return response.copyWith();
    }

    if (ResultType == DateTime) {
      return response.copyWith(
          body: DateTime.parse((response.body as String).replaceAll('"', ''))
              as ResultType);
    }

    final jsonRes = await super.convertResponse(response);
    return jsonRes.copyWith<ResultType>(
        body: $jsonDecoder.decode<Item>(jsonRes.body) as ResultType);
  }
}

final $jsonDecoder = $CustomJsonDecoder(generatedMapping);

// ignore: unused_element
String? _dateToJson(DateTime? date) {
  if (date == null) {
    return null;
  }

  final year = date.year.toString();
  final month = date.month < 10 ? '0${date.month}' : date.month.toString();
  final day = date.day < 10 ? '0${date.day}' : date.day.toString();

  return '$year-$month-$day';
}

class Wrapped<T> {
  final T value;
  const Wrapped.value(this.value);
}
