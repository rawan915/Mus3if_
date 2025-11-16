import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';

class LocationService {
  static Future<Position?> getCurrentLocation() async {
    try {
      bool serviceEnabled;
      LocationPermission permission;

      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        debugPrint('Location services are disabled.');
        return null;
      }

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          debugPrint('Location permissions are denied');
          return null;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        debugPrint('Location permissions are permanently denied');
        return null;
      }

      return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
        timeLimit: Duration(seconds: 15),
      );
    } catch (e) {
      debugPrint('Error getting location: $e');
      return null;
    }
  }

  static double calculateDistance(
    double lat1,
    double lon1,
    double lat2,
    double lon2,
  ) {
    return Geolocator.distanceBetween(lat1, lon1, lat2, lon2) / 1000;
  }

  static String getDistanceDescription(double distance) {
    if (distance < 1) {
      return '${(distance * 1000).toStringAsFixed(0)} meters away';
    } else if (distance < 10) {
      return '${distance.toStringAsFixed(1)} km away';
    } else {
      return '${distance.toStringAsFixed(0)} km away';
    }
  }
}
