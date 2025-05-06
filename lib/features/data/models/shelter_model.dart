import 'dart:convert';

import 'package:capstone_pawfund_app/features/data/models/base_response_model.dart';
import 'package:capstone_pawfund_app/features/data/models/meta_response_model.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ShelterModel {
  int? shelterId;
  int? accountRoleId;
  String? shelterCode;
  String? shelterName;
  String? description;
  String? dateOfPub;
  String? email;
  String? hotline;
  String? address;
  String? ward;
  String? district;
  String? province;
  int? latitude;
  int? longitude;
  String? statusCode;
  String? statusName;
  ShelterRegistration? shelterRegistration;
  ShelterModel({
    this.shelterId,
    this.accountRoleId,
    this.shelterCode,
    this.shelterName,
    this.description,
    this.dateOfPub,
    this.email,
    this.hotline,
    this.address,
    this.ward,
    this.district,
    this.province,
    this.latitude,
    this.longitude,
    this.statusCode,
    this.statusName,
    this.shelterRegistration,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'shelterId': shelterId,
      'accountRoleId': accountRoleId,
      'shelterCode': shelterCode,
      'shelterName': shelterName,
      'description': description,
      'dateOfPub': dateOfPub,
      'email': email,
      'hotline': hotline,
      'address': address,
      'ward': ward,
      'district': district,
      'province': province,
      'latitude': latitude,
      'longitude': longitude,
      'statusCode': statusCode,
      'statusName': statusName,
      'shelterRegistration': shelterRegistration?.toMap(),
    };
  }

  factory ShelterModel.fromMap(Map<String, dynamic> map) {
    return ShelterModel(
      shelterId: map['shelterId'] != null ? map['shelterId'] as int : null,
      accountRoleId:
          map['accountRoleId'] != null ? map['accountRoleId'] as int : null,
      shelterCode:
          map['shelterCode'] != null ? map['shelterCode'] as String : null,
      shelterName:
          map['shelterName'] != null ? map['shelterName'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      dateOfPub: map['dateOfPub'] != null ? map['dateOfPub'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      hotline: map['hotline'] != null ? map['hotline'] as String : null,
      address: map['address'] != null ? map['address'] as String : null,
      ward: map['ward'] != null ? map['ward'] as String : null,
      district: map['district'] != null ? map['district'] as String : null,
      province: map['province'] != null ? map['province'] as String : null,
      latitude: map['latitude'] != null ? map['latitude'] as int : null,
      longitude: map['longitude'] != null ? map['longitude'] as int : null,
      statusCode:
          map['statusCode'] != null ? map['statusCode'] as String : null,
      statusName:
          map['statusName'] != null ? map['statusName'] as String : null,
      shelterRegistration: map['shelterRegistration'] != null
          ? ShelterRegistration.fromMap(
              map['shelterRegistration'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ShelterModel.fromJson(Map<String, dynamic> source) =>
      ShelterModel.fromMap(source);
}

class ShelterRegistration {
  int? shelterRegistrationId;
  int? shelterId;
  int? accountId;
  int? processById;
  int? formResponseId;
  String? reason;
  String? approvedAt;
  String? rejectedAt;
  String? requestAt;
  String? statusCode;
  String? statusName;
  ShelterRegistration({
    this.shelterRegistrationId,
    this.shelterId,
    this.accountId,
    this.processById,
    this.formResponseId,
    this.reason,
    this.approvedAt,
    this.rejectedAt,
    this.requestAt,
    this.statusCode,
    this.statusName,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'shelterRegistrationId': shelterRegistrationId,
      'shelterId': shelterId,
      'accountId': accountId,
      'processById': processById,
      'formResponseId': formResponseId,
      'reason': reason,
      'approvedAt': approvedAt,
      'rejectedAt': rejectedAt,
      'requestAt': requestAt,
      'statusCode': statusCode,
      'statusName': statusName,
    };
  }

  factory ShelterRegistration.fromMap(Map<String, dynamic> map) {
    return ShelterRegistration(
      shelterRegistrationId: map['shelterRegistrationId'] != null
          ? map['shelterRegistrationId'] as int
          : null,
      shelterId: map['shelterId'] != null ? map['shelterId'] as int : null,
      accountId: map['accountId'] != null ? map['accountId'] as int : null,
      processById:
          map['processById'] != null ? map['processById'] as int : null,
      formResponseId:
          map['formResponseId'] != null ? map['formResponseId'] as int : null,
      reason: map['reason'] != null ? map['reason'] as String : null,
      approvedAt:
          map['approvedAt'] != null ? map['approvedAt'] as String : null,
      rejectedAt:
          map['rejectedAt'] != null ? map['rejectedAt'] as String : null,
      requestAt: map['requestAt'] != null ? map['requestAt'] as String : null,
      statusCode:
          map['statusCode'] != null ? map['statusCode'] as String : null,
      statusName:
          map['statusName'] != null ? map['statusName'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ShelterRegistration.fromJson(Map<String, dynamic> source) =>
      ShelterRegistration.fromMap(source);
}

class ShelterListResponse extends BaseResponse {
  List<ShelterModel>? data;
  MetaResponseModel? meta;
  ShelterListResponse({
    this.data,
    this.meta,
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

  factory ShelterListResponse.fromMap(Map<String, dynamic> map) {
    return ShelterListResponse(
      data: map['data'] != null
          ? List<ShelterModel>.from(
              (map['data'] as List).map(
                (x) => ShelterModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      meta: map['meta'] != null
          ? MetaResponseModel.fromMap(map['meta'] as Map<String, dynamic>)
          : null,
    );
  }

  factory ShelterListResponse.fromJson(Map<String, dynamic> source) =>
      ShelterListResponse.fromMap(source);
}

class ShelterDetailResponse extends BaseResponse {
  ShelterModel? data;
  ShelterDetailResponse({
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

  factory ShelterDetailResponse.fromMap(Map<String, dynamic> map) {
    return ShelterDetailResponse(
      data: map['data'] != null
          ? ShelterModel.fromMap(map['data'] as Map<String, dynamic>)
          : null,
    );
  }

  factory ShelterDetailResponse.fromJson(Map<String, dynamic> source) =>
      ShelterDetailResponse.fromMap(source);
}
