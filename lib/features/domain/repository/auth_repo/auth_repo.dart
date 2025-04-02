import 'package:capstone_pawfund_app/core/network/api/api_endpoints.dart';
import 'package:capstone_pawfund_app/core/network/exceptions/app_exceptions.dart';
import 'package:capstone_pawfund_app/core/network/exceptions/exception_handlers.dart';
import 'package:capstone_pawfund_app/features/data/models/account_model.dart';
import 'package:capstone_pawfund_app/features/data/models/account_verification_model.dart';
import 'package:capstone_pawfund_app/features/data/shared_preferences/auth_pref.dart';

import 'package:http/http.dart' as http;

abstract class IAuthenticationRepository {
  Future<Map<String, dynamic>> verificationAccount(String email);

  Future<Map<String, dynamic>> verificationAccountCode(
      AccountVerificationCodeModel accountVerificationCodeModel);

  Future<Map<String, dynamic>> login(AccountModel accountLogin);

  Future<Map<String, dynamic>> register(AccountModel accountModel);

  Future<Map<String, dynamic>> selfDetail();
}

class AuthenticationRepository extends ApiEndpoints
    implements IAuthenticationRepository {
  @override
  Future<Map<String, dynamic>> login(AccountModel accountLogin) async {
    try {
      Uri uri = Uri.parse("$SessionLoginUrl");
      final client = http.Client();
      final response = await client
          .post(
            uri,
            headers: {
              "Access-Control-Allow-Origin": "*",
              'Content-Type': 'application/json',
              'Accept': '*/*',
            },
            body: accountLogin.toJson(),
          )
          .timeout(const Duration(seconds: 180));
      return processResponse(response);
    } catch (e) {
      return ExceptionHandlers().getExceptionString(e);
    }
  }

  @override
  Future<Map<String, dynamic>> verificationAccount(String email) async {
    try {
      Uri uri =
          Uri.parse("$AccountVerificationUrl?verificationCodeRequest=$email");
      final client = http.Client();
      final response = await client.post(
        uri,
        headers: {
          "Access-Control-Allow-Origin": "*",
          'Content-Type': 'application/json',
          'Accept': '*/*',
        },
      ).timeout(const Duration(seconds: 180));
      return processResponse(response);
    } catch (e) {
      return ExceptionHandlers().getExceptionString(e);
    }
  }

  @override
  Future<Map<String, dynamic>> verificationAccountCode(
      AccountVerificationCodeModel accountVerificationCodeModel) async {
    try {
      Uri uri = Uri.parse("$AccountVerificationCodeUrl");
      final client = http.Client();
      final response = await client
          .patch(
            uri,
            headers: {
              "Access-Control-Allow-Origin": "*",
              'Content-Type': 'application/json',
              'Accept': '*/*',
            },
            body: accountVerificationCodeModel.toJson(),
          )
          .timeout(const Duration(seconds: 180));
      return processResponse(response);
    } catch (e) {
      return ExceptionHandlers().getExceptionString(e);
    }
  }

  @override
  Future<Map<String, dynamic>> register(AccountModel accountModel) async {
    try {
      Uri uri = Uri.parse("$AccountAdopterDonorUrl");
      final client = http.Client();
      final response = await client
          .post(
            uri,
            headers: {
              "Access-Control-Allow-Origin": "*",
              'Content-Type': 'application/json',
              'Accept': '*/*',
            },
            body: accountModel.toJson(),
          )
          .timeout(const Duration(seconds: 180));
      return processResponse(response);
    } catch (e) {
      return ExceptionHandlers().getExceptionString(e);
    }
  }

  @override
  Future<Map<String, dynamic>> selfDetail() async {
    try {
      final String jwtToken = AuthPref.getToken().toString();
      Uri uri = Uri.parse("$AccountSelfDetailUrl");
      final client = http.Client();
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
    } catch (e) {
      return ExceptionHandlers().getExceptionString(e);
    }
  }
}
