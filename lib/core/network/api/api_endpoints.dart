import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiEndpoints {
  static String domainUrl = "${dotenv.env["DOMAIN"]}";

  //$ Verification Code API $//
  final String AccountVerificationUrl =
      "$domainUrl/v1/public/verification-code/account-verification/send";

  //$ Account API $//
  final String AccountAdopterDonorUrl =
      "$domainUrl/v2/public/account/adopter-donor";
  final String AccountVerificationCodeUrl =
      "$domainUrl/v1/public/account/verify";
}
