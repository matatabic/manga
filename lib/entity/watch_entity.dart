import 'dart:convert';

import 'package:manga/generated/json/base/json_field.dart';
import 'package:manga/generated/json/watch_entity.g.dart';

@JsonSerializable()
class WatchEntity {
  @JSONField(name: "Chapter")
  late List<String> chapter;
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
