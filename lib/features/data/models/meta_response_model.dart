// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class MetaResponseModel {
  int? current;
  int? pageSize;
  int? total;
  MetaResponseModel({this.current, this.pageSize, this.total});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'current': current,
      'pageSize': pageSize,
      'total': total,
    };
  }

  factory MetaResponseModel.fromMap(Map<String, dynamic> map) {
    return MetaResponseModel(
      current: map['current'] != null ? map['current'] as int : null,
      pageSize: map['pageSize'] != null ? map['pageSize'] as int : null,
      total: map['total'] != null ? map['total'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory MetaResponseModel.fromJson(Map<String, dynamic> source) =>
      MetaResponseModel.fromMap(source);
}
