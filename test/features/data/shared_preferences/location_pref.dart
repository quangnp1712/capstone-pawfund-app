import 'package:jwt_decoder/jwt_decoder.dart';

import 'package:capstone_pawfund_app/features/data/shared_preferences/auth_pref.dart';
import 'package:capstone_pawfund_app/features/data/shared_preferences/shared_preferences_helper.dart';

import '../services/location_service_test.dart';

class LocationPref {
  static ILocationService locationService = LocationService();

  static Future<bool> getLocationPermission() async {
    try {
      bool? result =
          SharedPreferencesHelper.preferences.getBool("locationPermission");
      if (result != null) {
        return result;
      } else {
        return false;
      }
      // ignore: unused_catch_clause
    } on Exception catch (e) {
      return false;
    }
  }

  static Future<Map<String, dynamic>> getLongLat() async {
    try {
      double? lng;
      double? lat;
      int attempts = 0; // Biến đếm số lần thử
      do {
        lng = SharedPreferencesHelper.preferences.getDouble("longitude");
        lat = SharedPreferencesHelper.preferences.getDouble("latitude");
        if (lng != null && lat != null) {
          Map<String, dynamic> result = {"lng": lng, "lat": lat};
          return result;
        }
        await locationService.getUserCurrentLocation();
        attempts++;
      } while (lng == null && lat == null && attempts < 2);
      Map<String, dynamic> result = {"lng": 0, "lat": 0};
      return result;
    } catch (e) {
      Map<String, dynamic> result = {"lng": 0, "lat": 0};
      return result;
    }
  }

  static bool checkJwtExpired() {
    try {
      String jwt = AuthPref.getToken();
      final decoded = JwtDecoder.decode(jwt);
      final expiry = decoded['exp'];
      DateTime expiration = DateTime.fromMillisecondsSinceEpoch(expiry * 1000);
      final dateNow = DateTime.now();
      return expiration.isBefore(dateNow);
    } catch (e) {
      return false;
    }
  }
}
