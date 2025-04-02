import 'dart:convert';

class MediaModel {
  String? url;
  String? mediaTypeCode;
  String? mediaTypeName;
  bool? isThumbnail;
  MediaModel({
    this.url,
    this.isThumbnail,
    this.mediaTypeCode,
    this.mediaTypeName,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'url': url,
      'isThumbnail': isThumbnail,
    };
  }

  factory MediaModel.fromMap(Map<String, dynamic> map) {
    return MediaModel(
      url: map['url'] != null ? map['url'] as String : null,
      mediaTypeCode:
          map['mediaTypeCode'] != null ? map['mediaTypeCode'] as String : null,
      mediaTypeName:
          map['mediaTypeName'] != null ? map['mediaTypeName'] as String : null,
      isThumbnail:
          map['isThumbnail'] != null ? map['isThumbnail'] as bool : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory MediaModel.fromJson(Map<String, dynamic> source) =>
      MediaModel.fromMap(source);
}
