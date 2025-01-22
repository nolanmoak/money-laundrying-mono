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
  Future<Response<DataModel>> _apiDataGet() {
    final Uri $url = Uri.parse('/api/Data');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<DataModel, DataModel>($request);
  }

  @override
  Future<Response<dynamic>> _apiTestHelloGet() {
    final Uri $url = Uri.parse('/api/Test/hello');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }
}
