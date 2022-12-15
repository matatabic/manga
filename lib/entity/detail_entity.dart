import 'dart:convert';

import 'package:manga/generated/json/base/json_field.dart';
import 'package:manga/generated/json/detail_entity.g.dart';

@JsonSerializable()
class DetailEntity {
  late DetailInfo info;
  late List<DetailNewChapter> newChapter;
  late List<DetailChapter> chapter;

  DetailEntity();

  factory DetailEntity.fromJson(Map<String, dynamic> json) =>
      $DetailEntityFromJson(json);

  Map<String, dynamic> toJson() => $DetailEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class DetailInfo {
  late String title;
  late String imgUrl;
  late String author;
  late List<String> tagList;
  late String supporting;
  late String desc;

  DetailInfo();

  factory DetailInfo.fromJson(Map<String, dynamic> json) =>
      $DetailInfoFromJson(json);

  Map<String, dynamic> toJson() => $DetailInfoToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class DetailNewChapter {
  late String title;
  late String htmlUrl;

  DetailNewChapter();

  factory DetailNewChapter.fromJson(Map<String, dynamic> json) =>
      $DetailNewChapterFromJson(json);

  Map<String, dynamic> toJson() => $DetailNewChapterToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class DetailChapter {
  late String title;
  late String htmlUrl;

  DetailChapter();

  factory DetailChapter.fromJson(Map<String, dynamic> json) =>
      $DetailChapterFromJson(json);

  Map<String, dynamic> toJson() => $DetailChapterToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
