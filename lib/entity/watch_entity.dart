import 'dart:convert';

import 'package:manga/generated/json/base/json_field.dart';
import 'package:manga/generated/json/watch_entity.g.dart';

@JsonSerializable()
class WatchEntity {
  late List<WatchChapter> chapter;
  late String lastChapter;
  late String nextChapter;

  WatchEntity();

  factory WatchEntity.fromJson(Map<String, dynamic> json) =>
      $WatchEntityFromJson(json);

  Map<String, dynamic> toJson() => $WatchEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class WatchChapter {
  late String imgUrl;
  late String imgWidth;
  late String imgHeight;

  WatchChapter();

  factory WatchChapter.fromJson(Map<String, dynamic> json) =>
      $WatchChapterFromJson(json);

  Map<String, dynamic> toJson() => $WatchChapterToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
