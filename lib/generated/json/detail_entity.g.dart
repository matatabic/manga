import 'package:manga/entity/detail_entity.dart';
import 'package:manga/generated/json/base/json_convert_content.dart';

DetailEntity $DetailEntityFromJson(Map<String, dynamic> json) {
  final DetailEntity detailEntity = DetailEntity();
  final DetailInfo? info = jsonConvert.convert<DetailInfo>(json['info']);
  if (info != null) {
    detailEntity.info = info;
  }
  final List<DetailNewChapter>? newChapter =
      jsonConvert.convertListNotNull<DetailNewChapter>(json['newChapter']);
  if (newChapter != null) {
    detailEntity.newChapter = newChapter;
  }
  final List<DetailChapter>? chapter =
      jsonConvert.convertListNotNull<DetailChapter>(json['chapter']);
  if (chapter != null) {
    detailEntity.chapter = chapter;
  }
  return detailEntity;
}

Map<String, dynamic> $DetailEntityToJson(DetailEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['info'] = entity.info.toJson();
  data['newChapter'] = entity.newChapter.map((v) => v.toJson()).toList();
  data['chapter'] = entity.chapter.map((v) => v.toJson()).toList();
  return data;
}

DetailInfo $DetailInfoFromJson(Map<String, dynamic> json) {
  final DetailInfo detailInfo = DetailInfo();
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    detailInfo.title = title;
  }
  final String? imgUrl = jsonConvert.convert<String>(json['imgUrl']);
  if (imgUrl != null) {
    detailInfo.imgUrl = imgUrl;
  }
  final String? author = jsonConvert.convert<String>(json['author']);
  if (author != null) {
    detailInfo.author = author;
  }
  final List<String>? tagList =
      jsonConvert.convertListNotNull<String>(json['tagList']);
  if (tagList != null) {
    detailInfo.tagList = tagList;
  }
  final String? supporting = jsonConvert.convert<String>(json['supporting']);
  if (supporting != null) {
    detailInfo.supporting = supporting;
  }
  final String? desc = jsonConvert.convert<String>(json['desc']);
  if (desc != null) {
    detailInfo.desc = desc;
  }
  return detailInfo;
}

Map<String, dynamic> $DetailInfoToJson(DetailInfo entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['title'] = entity.title;
  data['imgUrl'] = entity.imgUrl;
  data['author'] = entity.author;
  data['tagList'] = entity.tagList;
  data['supporting'] = entity.supporting;
  data['desc'] = entity.desc;
  return data;
}

DetailNewChapter $DetailNewChapterFromJson(Map<String, dynamic> json) {
  final DetailNewChapter detailNewChapter = DetailNewChapter();
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    detailNewChapter.title = title;
  }
  final String? htmlUrl = jsonConvert.convert<String>(json['htmlUrl']);
  if (htmlUrl != null) {
    detailNewChapter.htmlUrl = htmlUrl;
  }
  return detailNewChapter;
}

Map<String, dynamic> $DetailNewChapterToJson(DetailNewChapter entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['title'] = entity.title;
  data['htmlUrl'] = entity.htmlUrl;
  return data;
}

DetailChapter $DetailChapterFromJson(Map<String, dynamic> json) {
  final DetailChapter detailChapter = DetailChapter();
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    detailChapter.title = title;
  }
  final String? htmlUrl = jsonConvert.convert<String>(json['htmlUrl']);
  if (htmlUrl != null) {
    detailChapter.htmlUrl = htmlUrl;
  }
  return detailChapter;
}

Map<String, dynamic> $DetailChapterToJson(DetailChapter entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['title'] = entity.title;
  data['htmlUrl'] = entity.htmlUrl;
  return data;
}
