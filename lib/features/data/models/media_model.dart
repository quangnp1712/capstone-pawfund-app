import 'dart:convert';

class MediaModel {
  String? url;
  bool? isThumbnail;
  MediaModel({
    this.url,
    this.isThumbnail,
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
      isThumbnail:
          map['isThumbnail'] != null ? map['isThumbnail'] as bool : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory MediaModel.fromJson(Map<String, dynamic> source) =>
      MediaModel.fromMap(source);
}
