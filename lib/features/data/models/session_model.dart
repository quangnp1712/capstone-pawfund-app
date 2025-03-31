// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:capstone_pawfund_app/features/data/models/account_model.dart';
import 'package:capstone_pawfund_app/features/data/models/base_response_model.dart';

class SessionModel {
  int? sessionId;
  String? accessToken;
  String? refreshToken;
  String? accessExpiredAt;
  String? refreshExpiredAt;
  AccountModel? account;
  SessionModel({
    this.sessionId,
    this.accessToken,
    this.refreshToken,
    this.accessExpiredAt,
    this.refreshExpiredAt,
    this.account,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'sessionId': sessionId,
      'accessToken': accessToken,
      'refreshToken': refreshToken,
      'accessExpiredAt': accessExpiredAt,
      'refreshExpiredAt': refreshExpiredAt,
      'account': account?.toMap(),
    };
  }

  factory SessionModel.fromMap(Map<String, dynamic> map) {
    return SessionModel(
      sessionId: map['sessionId'] != null ? map['sessionId'] as int : null,
      accessToken:
          map['accessToken'] != null ? map['accessToken'] as String : null,
      refreshToken:
          map['refreshToken'] != null ? map['refreshToken'] as String : null,
      accessExpiredAt: map['accessExpiredAt'] != null
          ? map['accessExpiredAt'] as String
          : null,
      refreshExpiredAt: map['refreshExpiredAt'] != null
          ? map['refreshExpiredAt'] as String
          : null,
      account: map['account'] != null
          ? AccountModel.fromMap(map['account'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory SessionModel.fromJson(Map<String, dynamic> source) =>
      SessionModel.fromMap(source);
}

class SessionResponse extends BaseResponse {
  SessionModel? data;

  SessionResponse({
    this.data,
    status,
    success,
    errorCode,
    message,
    apiVersion,
  }) : super(
          status: status,
          success: success,
          errorCode: errorCode,
          message: message,
          apiVersion: apiVersion,
        );

  factory SessionResponse.fromMap(Map<String, dynamic> map) {
    return SessionResponse(
      data: map['data'] != null
          ? SessionModel.fromMap(map['data'] as Map<String, dynamic>)
          : null,
      status: map['status'] != null ? map['status'] as String : null,
      success: map['success'] != null ? map['success'] as bool : null,
      errorCode: map['errorCode'] != null ? map['errorCode'] as String : null,
      message: map['message'] != null ? map['message'] as String : null,
      apiVersion:
          map['apiVersion'] != null ? map['apiVersion'] as String : null,
    );
  }

  factory SessionResponse.fromJson(Map<String, dynamic> source) =>
      SessionResponse.fromMap(source);
}
