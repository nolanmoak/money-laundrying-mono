import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';

LocationSettings getLocationSettings() {
  late LocationSettings locationSettings;

  if (kIsWeb) {
    locationSettings = WebSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 100,
      maximumAge: const Duration(minutes: 5),
    );
  } else if (Platform.isAndroid) {
    locationSettings = AndroidSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 100,
        forceLocationManager: true,
        intervalDuration: const Duration(seconds: 10),
        //(Optional) Set foreground notification config to keep the app alive
        //when going to the background
        foregroundNotificationConfig: const ForegroundNotificationConfig(
          notificationText:
              "Money Laundrying will continue to receive your location even when you aren't using it",
          notificationTitle: 'Running in Background',
          enableWakeLock: true,
        ));
  } else if (Platform.isIOS || Platform.isMacOS) {
    locationSettings = AppleSettings(
      accuracy: LocationAccuracy.high,
      activityType: ActivityType.fitness,
      distanceFilter: 100,
      pauseLocationUpdatesAutomatically: true,
      // Only set to true if our app will be started up in the background.
      showBackgroundLocationIndicator: false,
    );
  } else {
    locationSettings = const LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 100,
    );
  }
  return locationSettings;
}

Future<Position?> determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await GeolocatorPlatform.instance.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return null;
  }

  permission = await GeolocatorPlatform.instance.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await GeolocatorPlatform.instance.requestPermission();
    if (permission == LocationPermission.denied) {
      return null;
    }
  }

  if (permission == LocationPermission.deniedForever) {
    return null;
  }

  return await GeolocatorPlatform.instance.getCurrentPosition(
    locationSettings: getLocationSettings(),
  );
}
