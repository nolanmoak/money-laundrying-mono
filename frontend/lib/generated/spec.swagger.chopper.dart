// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spec.swagger.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
final class _$Spec extends Spec {
  _$Spec([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final Type definitionType = Spec;

  @override
  Future<Response<DataModel>> _apiDataGet({String? companyId}) {
    final Uri $url = Uri.parse('/api/Data');
    final Map<String, dynamic> $params = <String, dynamic>{
      'companyId': companyId
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<DataModel, DataModel>($request);
  }

  @override
  Future<Response<LocationAndCompanyModel>> _apiLocationCompaniesFlatGet() {
    final Uri $url = Uri.parse('/api/Location/companies/flat');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client
        .send<LocationAndCompanyModel, LocationAndCompanyModel>($request);
  }

  @override
  Future<Response<Location>> _apiLocationCurrentGet({
    num? latitude,
    num? longitude,
  }) {
    final Uri $url = Uri.parse('/api/Location/current');
    final Map<String, dynamic> $params = <String, dynamic>{
      'latitude': latitude,
      'longitude': longitude,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<Location, Location>($request);
  }
}
