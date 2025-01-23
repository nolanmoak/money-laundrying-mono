int getHoursBetweenPeaks(int peak1, int peak2) {
  if (peak2 > peak1) {
    return peak2 - peak1;
  }
  return 24 - peak1 + peak2;
}

int getHoursUntilNextPeak(int currentHour, int nextPeakHour) {
  return getHoursBetweenPeaks(currentHour, nextPeakHour) - 1;
}

bool isBetween(int a, int b, int value) {
  return value >= a && value < b;
}

String get24HourDisplay(int hour) {
  var displayHour = hour;
  var period = 'AM';
  if (hour == 0) {
    displayHour = 12;
  } else if (hour == 12) {
    period = 'PM';
  } else if (hour > 12 && hour < 24) {
    displayHour = hour - 12;
    period = 'PM';
  } else if (hour == 24) {
    displayHour = 12;
    period = 'PM';
  }
  return '$displayHour $period';
}

typedef DeltaTime = ({int hours, int minutes, int seconds});

DeltaTime getDeltaTimeUntilNextPeak(DateTime dateTime, int nextPeakStartHour) {
  final hoursBetweenPeaks =
      getHoursBetweenPeaks(dateTime.hour, nextPeakStartHour);
  final hours = (hoursBetweenPeaks.toDouble() -
          dateTime.minute.toDouble() / 60 -
          dateTime.second.toDouble() / 60 / 60)
      .floor();

  var minutes =
      ((60 - dateTime.minute).toDouble() - dateTime.second.toDouble() / 60)
          .floor();
  if (minutes == 60) {
    minutes = 0;
  }

  final seconds = dateTime.second == 0 ? 0 : 60 - dateTime.second;

  return (
    hours: hours,
    minutes: minutes,
    seconds: seconds,
  );
}

double getDatetimeFraction(DateTime dateTime) {
  return dateTime.hour.toDouble() / 24 +
      dateTime.minute.toDouble() / 60 / 24 +
      dateTime.second.toDouble() / 60 / 60 / 24;
}

String formatDeltaTime(DeltaTime? deltaTime) {
  return deltaTime != null
      ? '${deltaTime.hours.toString().padLeft(2, '0')}:${deltaTime.minutes.toString().padLeft(2, '0')}:${deltaTime.seconds.toString().padLeft(2, '0')}'
      : '--:--:--';
}

int getNextWeekday(int weekday) {
  if (weekday >= 7) {
    return 1;
  }
  return weekday + 1;
}
