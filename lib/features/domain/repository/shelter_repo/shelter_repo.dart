import 'package:capstone_pawfund_app/core/network/api/api_endpoints.dart';
import 'package:capstone_pawfund_app/core/network/exceptions/app_exceptions.dart';
import 'package:capstone_pawfund_app/core/network/exceptions/exception_handlers.dart';
import 'package:capstone_pawfund_app/features/data/shared_preferences/auth_pref.dart';
import 'package:http/http.dart' as http;

abstract class IShelterRepository {
  Future<Map<String, dynamic>> getShelterList();
  Future<Map<String, dynamic>> getShelterDetail(int shelterId);
}

class ShelterRepository extends ApiEndpoints implements IShelterRepository {
  @override
  Future<Map<String, dynamic>> getShelterList() async {
    try {
      final String jwtToken = AuthPref.getToken().toString();
      Uri uri =
          Uri.parse("$ShelterListUrl?sorter=updatedAt&current=0&pageSize=10");
      final client = http.Client();
      if (jwtToken.isNotEmpty || jwtToken != "") {
        final response = await client.get(
          uri,
          headers: {
            "Access-Control-Allow-Origin": "*",
            'Content-Type': 'application/json',
            'Accept': '*/*',
            'Authorization': 'Bearer $jwtToken',
          },
        ).timeout(const Duration(seconds: 180));
        return processResponse(response);
      } else {
        final response = await client.get(
          uri,
          headers: {
            "Access-Control-Allow-Origin": "*",
            'Content-Type': 'application/json',
            'Accept': '*/*',
          },
        ).timeout(const Duration(seconds: 180));
        return processResponse(response);
      }
    } catch (e) {
      return ExceptionHandlers().getExceptionString(e);
    }
  }

  @override
  Future<Map<String, dynamic>> getShelterDetail(int shelterId) async {
    try {
      final String jwtToken = AuthPref.getToken().toString();
      Uri uri = Uri.parse("$ShelterDetailUrl/$shelterId");
      final client = http.Client();
      if (jwtToken.isNotEmpty || jwtToken != "") {
        final response = await client.get(
          uri,
          headers: {
            "Access-Control-Allow-Origin": "*",
            'Content-Type': 'application/json',
            'Accept': '*/*',
            'Authorization': 'Bearer $jwtToken',
          },
        ).timeout(const Duration(seconds: 180));
        return processResponse(response);
      } else {
        final response = await client.get(
          uri,
          headers: {
            "Access-Control-Allow-Origin": "*",
            'Content-Type': 'application/json',
            'Accept': '*/*',
          },
        ).timeout(const Duration(seconds: 180));
        return processResponse(response);
      }
    } catch (e) {
      return ExceptionHandlers().getExceptionString(e);
    }
  }
}
