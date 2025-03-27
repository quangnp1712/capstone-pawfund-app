import 'dart:convert';

import 'package:capstone_pawfund_app/features/data/models/base_response_model.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first

class SendVerificationModel {
  int? verificationCodeId;
  int? accountId;
  String? code;
  String? typeCode;
  String? typeName;
  bool? isUsed;
  String? expiredAt;

  SendVerificationModel({
    this.verificationCodeId,
    this.accountId,
    this.code,
    this.typeCode,
    this.typeName,
    this.isUsed,
    this.expiredAt,
  });

  @override
  String toString() {
    return 'DataAccountVerificationModel(verificationCodeId: $verificationCodeId, accountId: $accountId, code: $code, typeCode: $typeCode, typeName: $typeName, isUsed: $isUsed, expiredAt: $expiredAt)';
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'verificationCodeId': verificationCodeId,
      'accountId': accountId,
      'code': code,
      'typeCode': typeCode,
      'typeName': typeName,
      'isUsed': isUsed,
      'expiredAt': expiredAt,
    };
  }

  factory SendVerificationModel.fromMap(Map<String, dynamic> map) {
    return SendVerificationModel(
      verificationCodeId: map['verificationCodeId'] != null
          ? map['verificationCodeId'] as int
          : null,
      accountId: map['accountId'] != null ? map['accountId'] as int : null,
      code: map['code'] != null ? map['code'] as String : null,
      typeCode: map['typeCode'] != null ? map['typeCode'] as String : null,
      typeName: map['typeName'] != null ? map['typeName'] as String : null,
      isUsed: map['isUsed'] != null ? map['isUsed'] as bool : null,
      expiredAt: map['expiredAt'] != null ? map['expiredAt'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory SendVerificationModel.fromJson(Map<String, dynamic> source) =>
      SendVerificationModel.fromMap(source);
}

class AccountVerificationCodeModel {
  String? email;
  String? verificationCode;
  AccountVerificationCodeModel({
    this.email,
    this.verificationCode,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'verificationCode': verificationCode,
    };
  }

  factory AccountVerificationCodeModel.fromMap(Map<String, dynamic> map) {
    return AccountVerificationCodeModel(
      email: map['email'] != null ? map['email'] as String : null,
      verificationCode: map['verificationCode'] != null
          ? map['verificationCode'] as String
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AccountVerificationCodeModel.fromJson(Map<String, dynamic> source) =>
      AccountVerificationCodeModel.fromMap(source);
}

class SendVerificationResponse extends BaseResponse {
  SendVerificationModel? data;
  SendVerificationResponse({
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

  factory SendVerificationResponse.fromMap(Map<String, dynamic> map) {
    return SendVerificationResponse(
      data: map['data'] != null
          ? SendVerificationModel.fromMap(map['data'] as Map<String, dynamic>)
          : null,
      status: map['status'] != null ? map['status'] as String : null,
      success: map['success'] != null ? map['success'] as bool : null,
      errorCode: map['errorCode'] != null ? map['errorCode'] as String : null,
      message: map['message'] != null ? map['message'] as String : null,
      apiVersion:
          map['apiVersion'] != null ? map['apiVersion'] as String : null,
    );
  }

  factory SendVerificationResponse.fromJson(Map<String, dynamic> source) =>
      SendVerificationResponse.fromMap(source);
}
