import 'package:json_annotation/json_annotation.dart';

enum PeakDataType {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Off')
  off('Off'),
  @JsonValue('Mid')
  mid('Mid'),
  @JsonValue('On')
  on('On');

  final String? value;

  const PeakDataType(this.value);
}
