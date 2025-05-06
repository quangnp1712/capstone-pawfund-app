import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiEndpoints {
  static String domainUrl = "${dotenv.env["DOMAIN"]}";

  //! Verification Code API !//
  final String AccountSendVerificationUrl =
      "$domainUrl/v1/public/verification-code/account-verification/send";

  final String AccountSendVerificationNewEmailUrl =
      "$domainUrl/v1/api/verification-code/email-verification/send";

  //! Account API !//
  // register
  final String AccountAdopterDonorUrl = "$domainUrl/v2/public/account";

  final String AccountVerificationCodeUrl =
      "$domainUrl/v1/public/account/verify";

  final String AccountSelfDetailUrl = "$domainUrl/v1/api/account/self-detail";

  final String AccountUpdateProfileUrl = "$domainUrl/v1/api/account";

  final String AccountSelfChangePasswordUrl =
      "$domainUrl/v1/api/account/self-change-password";

  final String AccountChangeEmailUrl = "$domainUrl/v1/api/account/email-verify";

  //! Session API !//
  // Login
  final String SessionLoginUrl = "$domainUrl/v1/public/session/login";

  // Logout
  final String SessionLogoutUrl = "$domainUrl/v1/api/session/logout";

  //! Shelter API !//
  // Shelter List
  final String ShelterListUrl = "$domainUrl/v2/public/shelter";

  // Shelter Detail
  final String ShelterDetailUrl = "$domainUrl/v1/public/shelter";
}
