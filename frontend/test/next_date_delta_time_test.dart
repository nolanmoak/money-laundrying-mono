import 'package:flutter_test/flutter_test.dart';
import 'package:money_laundrying_frontend/utils/date_utils.dart';

void main() {
  test('Delta time works', () {
    const nextPeakStartHour = 7;
    final dateTime = DateTime(2025, 1, 22, 5, 30, 0, 0, 0);
    final deltaTime = getDeltaTimeUntilNextPeak(dateTime, nextPeakStartHour);

    expect(deltaTime.hours, equals(1));
    expect(deltaTime.minutes, equals(30));
    expect(deltaTime.seconds, 0);
  });

  test('Delta time works at 0 minutes and 0 seconds', () {
    const nextPeakStartHour = 7;
    final dateTime = DateTime(2025, 1, 22, 5, 0, 0, 0, 0);
    final deltaTime = getDeltaTimeUntilNextPeak(dateTime, nextPeakStartHour);

    expect(deltaTime.hours, equals(2));
    expect(deltaTime.minutes, equals(0));
    expect(deltaTime.seconds, 0);
  });

  test('Delta time works at 0 minutes and 59 seconds', () {
    const nextPeakStartHour = 7;
    final dateTime = DateTime(2025, 1, 22, 5, 0, 59, 0, 0);
    final deltaTime = getDeltaTimeUntilNextPeak(dateTime, nextPeakStartHour);

    expect(deltaTime.hours, equals(1));
    expect(deltaTime.minutes, equals(59));
    expect(deltaTime.seconds, 1);
  });

  test('Delta time works at 59 minutes and 59 seconds', () {
    const nextPeakStartHour = 7;
    final dateTime = DateTime(2025, 1, 22, 5, 59, 59, 0, 0);
    final deltaTime = getDeltaTimeUntilNextPeak(dateTime, nextPeakStartHour);

    expect(deltaTime.hours, equals(1));
    expect(deltaTime.minutes, equals(0));
    expect(deltaTime.seconds, 1);
  });

  test('Delta time works at 59 minutes and 0 seconds', () {
    const nextPeakStartHour = 7;
    final dateTime = DateTime(2025, 1, 22, 5, 59, 0, 0, 0);
    final deltaTime = getDeltaTimeUntilNextPeak(dateTime, nextPeakStartHour);

    expect(deltaTime.hours, equals(1));
    expect(deltaTime.minutes, equals(1));
    expect(deltaTime.seconds, 0);
  });
}
