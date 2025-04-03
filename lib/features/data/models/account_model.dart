import 'dart:convert';

import 'package:capstone_pawfund_app/features/data/models/base_response_model.dart';
import 'package:capstone_pawfund_app/features/data/models/media_model.dart';
import 'package:capstone_pawfund_app/features/data/models/role_model.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class AccountModel {
  int? accountId;
  String? firstName;
  String? lastName;
  String? identification;
  String? email;
  String? password;
  String? phone;
  String? address;
  String? dateOfBirth;
  String? genderCode;
  String? genderName;
  List<RoleModel>? roles;
  String? statusCode;
  String? statusName;
  List<MediaModel>? medias;

  // bo sung feild
  String? name;
  String? avatarUrl;

  AccountModel({
    this.accountId,
    this.firstName,
    this.lastName,
    this.identification,
    this.email,
    this.password,
    this.phone,
    this.address,
    this.dateOfBirth,
    this.genderCode,
    this.genderName,
    this.roles,
    this.statusCode,
    this.statusName,
    this.medias,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'firstName': firstName,
      'lastName': lastName,
      'identification': identification,
      'email': email,
      'password': password,
      'phone': phone,
      'address': address,
      'dateOfBirth': dateOfBirth,
      'genderCode': genderCode,
      'genderName': genderName,
      'medias': medias?.map((x) => x.toMap()).toList(),
    };
  }

  factory AccountModel.fromMap(Map<String, dynamic> map) {
    return AccountModel(
      accountId: map['accountId'] != null ? map['accountId'] as int : null,
      firstName: map['firstName'] != null ? map['firstName'] as String : null,
      lastName: map['lastName'] != null ? map['lastName'] as String : null,
      identification: map['identification'] != null
          ? map['identification'] as String
          : null,
      email: map['email'] != null ? map['email'] as String : null,
      password: map['password'] != null ? map['password'] as String : null,
      phone: map['phone'] != null ? map['phone'] as String : null,
      address: map['address'] != null ? map['address'] as String : null,
      dateOfBirth:
          map['dateOfBirth'] != null ? map['dateOfBirth'] as String : null,
      genderCode:
          map['genderCode'] != null ? map['genderCode'] as String : null,
      genderName:
          map['genderName'] != null ? map['genderName'] as String : null,
      roles: map['roles'] != null
          ? List<RoleModel>.from(
              (map['roles'] as List).map(
                (x) => RoleModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      statusCode:
          map['statusCode'] != null ? map['statusCode'] as String : null,
      statusName:
          map['statusName'] != null ? map['statusName'] as String : null,
      medias: map['medias'] != null
          ? List<MediaModel>.from(
              (map['medias'] as List).map(
                (x) => MediaModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AccountModel.fromJson(Map<String, dynamic> source) =>
      AccountModel.fromMap(source);
}

class AccountResponse extends BaseResponse {
  AccountModel? data;
  AccountResponse({
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

  factory AccountResponse.fromMap(Map<String, dynamic> map) {
    return AccountResponse(
      data: map['data'] != null
          ? AccountModel.fromMap(map['data'] as Map<String, dynamic>)
          : null,
      status: map['status'] != null ? map['status'] as String : null,
      success: map['success'] != null ? map['success'] as bool : null,
      errorCode: map['errorCode'] != null ? map['errorCode'] as String : null,
      message: map['message'] != null ? map['message'] as String : null,
      apiVersion:
          map['apiVersion'] != null ? map['apiVersion'] as String : null,
    );
  }

  factory AccountResponse.fromJson(Map<String, dynamic> source) =>
      AccountResponse.fromMap(source);
}
