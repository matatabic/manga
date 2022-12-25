import 'package:manga/entity/watch_entity.dart';
import 'package:manga/generated/json/base/json_convert_content.dart';

WatchEntity $WatchEntityFromJson(Map<String, dynamic> json) {
  final WatchEntity watchEntity = WatchEntity();
  final List<WatchChapter>? chapter =
      jsonConvert.convertListNotNull<WatchChapter>(json['chapter']);
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
  data['chapter'] = entity.chapter.map((v) => v.toJson()).toList();
  data['lastChapter'] = entity.lastChapter;
  data['nextChapter'] = entity.nextChapter;
  return data;
}

WatchChapter $WatchChapterFromJson(Map<String, dynamic> json) {
  final WatchChapter watchChapter = WatchChapter();
  final String? imgUrl = jsonConvert.convert<String>(json['imgUrl']);
  if (imgUrl != null) {
    watchChapter.imgUrl = imgUrl;
  }
  final String? imgWidth = jsonConvert.convert<String>(json['imgWidth']);
  if (imgWidth != null) {
    watchChapter.imgWidth = imgWidth;
  }
  final String? imgHeight = jsonConvert.convert<String>(json['imgHeight']);
  if (imgHeight != null) {
    watchChapter.imgHeight = imgHeight;
  }
  return watchChapter;
}

Map<String, dynamic> $WatchChapterToJson(WatchChapter entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['imgUrl'] = entity.imgUrl;
  data['imgWidth'] = entity.imgWidth;
  data['imgHeight'] = entity.imgHeight;
  return data;
}
