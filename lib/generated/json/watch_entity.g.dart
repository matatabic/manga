import 'package:manga/entity/watch_entity.dart';
import 'package:manga/generated/json/base/json_convert_content.dart';

WatchEntity $WatchEntityFromJson(Map<String, dynamic> json) {
  final WatchEntity watchEntity = WatchEntity();
  final List<String>? chapter =
      jsonConvert.convertListNotNull<String>(json['chapter']);
  if (chapter != null) {
    watchEntity.chapter = chapter;
  }
  final String? lastChapter = jsonConvert.convert<String>(json['lastChapter']);
  if (lastChapter != null) {
    watchEntity.lastChapter = lastChapter;
  }
  final String? nextChapter = jsonConvert.convert<String>(json['nextChapter']);
  if (nextChapter != null) {
    watchEntity.nextChapter = nextChapter;
  }
  return watchEntity;
}

Map<String, dynamic> $WatchEntityToJson(WatchEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['chapter'] = entity.chapter;
  data['lastChapter'] = entity.lastChapter;
  data['nextChapter'] = entity.nextChapter;
  return data;
}
