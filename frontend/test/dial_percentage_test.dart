import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/utils/date_utils.dart';

void main() {
  test('Dial percentage is 50% at 12PM', () {
    final dateTime = DateTime(2025, 1, 12, 12, 0, 0, 0, 0);
    final percentage = getDatetimeFraction(dateTime);
    expect(percentage, equals(0.50));
  });

  test('Dial percentage is 75% at 6PM', () {
    final dateTime = DateTime(2025, 1, 12, 18, 0, 0, 0, 0);
    final percentage = getDatetimeFraction(dateTime);
    expect(percentage, equals(0.75));
  });

  test('Dial percentage is (1 / 60 / 24) at 00:01:00', () {
    final dateTime = DateTime(2025, 1, 12, 0, 1, 0, 0, 0);
    final percentage = getDatetimeFraction(dateTime);
    expect(percentage, equals(1.0 / 60.0 / 24.0));
  });

  test('Dial percentage is 50% + (1 / 60 / 60 / 24) at 12:00:01', () {
    final dateTime = DateTime(2025, 1, 12, 12, 0, 1, 0, 0);
    final percentage = getDatetimeFraction(dateTime);
    expect(percentage, equals(0.5 + 1.0 / 60.0 / 60.0 / 24.0));
  });
}
