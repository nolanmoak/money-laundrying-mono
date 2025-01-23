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
  Future<Response<DataModel>> _apiDataGet({
    num? latitude,
    num? longitude,
  }) {
    final Uri $url = Uri.parse('/api/Data');
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
    return client.send<DataModel, DataModel>($request);
  }
}
