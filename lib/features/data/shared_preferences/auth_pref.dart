import 'package:capstone_pawfund_app/features/data/services/location_service.dart';
import 'package:capstone_pawfund_app/features/data/shared_preferences/shared_preferences_helper.dart';
import 'package:capstone_pawfund_app/features/presentation/widgets/landing_navigation_bottom/landing_navigation_bottom.dart';
import 'package:get/get.dart';

class AuthPref {
  static ILocationService locationService = LocationService();

  static Future<void> setPhone(String phone) async {
    await SharedPreferencesHelper.preferences.setString("phone", phone);
  }

  static String getPhone() {
    return SharedPreferencesHelper.preferences.getString("phone") ?? "";
  }

  static Future<void> setEmail(String email) async {
    await SharedPreferencesHelper.preferences.setString("email", email);
  }

  static String getEmail() {
    return SharedPreferencesHelper.preferences.getString("email") ?? "";
  }

  static Future<void> setAvatar(String avatarUrl) async {
    await SharedPreferencesHelper.preferences.setString("avatar", avatarUrl);
  }

  static String getAvatar() {
    return SharedPreferencesHelper.preferences.getString("avatar") ?? "";
  }

  static Future<void> setAccountId(String accountId) async {
    await SharedPreferencesHelper.preferences.setString("accountId", accountId);
  }

  static String getAccountId() {
    return SharedPreferencesHelper.preferences.getString("accountId") ?? "";
  }

  static Future<void> setToken(String token) async {
    await SharedPreferencesHelper.preferences.setString("token", token);
  }

  static String getToken() {
    return SharedPreferencesHelper.preferences.getString("token") ?? "";
  }

  static Future<void> logout() async {
    await SharedPreferencesHelper.preferences.clear();
    Get.offAllNamed(LandingNavBottomWidget.LandingNavBottomWidgetRoute);
  }

  static Future<void> setName(String nameCus) async {
    await SharedPreferencesHelper.preferences.setString("nameCus", nameCus);
  }

  static String getName() {
    return SharedPreferencesHelper.preferences.getString("nameCus") ?? "";
  }

  static Future<void> setRole(String role) async {
    await SharedPreferencesHelper.preferences.setString("role", role);
  }

  static String getRole() {
    return SharedPreferencesHelper.preferences.getString("role") ?? "";
  }

  static Future<void> setCusId(int cusId) async {
    await SharedPreferencesHelper.preferences.setInt("cusId", cusId);
  }

  static int getCusId() {
    return SharedPreferencesHelper.preferences.getInt("cusId") ?? 0;
  }
}
