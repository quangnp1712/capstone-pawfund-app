import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiEndpoints {
  static String domainUrl = "${dotenv.env["DOMAIN"]}";

  //! Verification Code API !//
  final String AccountVerificationUrl =
      "$domainUrl/v1/public/verification-code/account-verification/send";

  //! Account API !//
  // register
  final String AccountAdopterDonorUrl =
      "$domainUrl/v2/public/account/adopter-donor";

  final String AccountVerificationCodeUrl =
      "$domainUrl/v1/public/account/verify";

  final String AccountSelfDetailUrl = "$domainUrl/v1/api/account/self-detail";

  //! Session API !//
  // Login
  final String SessionLoginUrl = "$domainUrl/v1/public/session/login";
}
