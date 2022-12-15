import 'package:manga/entity/home_entity.dart';
import 'package:manga/generated/json/base/json_convert_content.dart';

HomeEntity $HomeEntityFromJson(Map<String, dynamic> json) {
  final HomeEntity homeEntity = HomeEntity();
  final List<HomeSwiper>? swiper =
      jsonConvert.convertListNotNull<HomeSwiper>(json['swiper']);
  if (swiper != null) {
    homeEntity.swiper = swiper;
  }
  final List<HomeCatalog>? catalog =
      jsonConvert.convertListNotNull<HomeCatalog>(json['catalog']);
  if (catalog != null) {
    homeEntity.catalog = catalog;
  }
  return homeEntity;
}

Map<String, dynamic> $HomeEntityToJson(HomeEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['swiper'] = entity.swiper.map((v) => v.toJson()).toList();
  data['catalog'] = entity.catalog.map((v) => v.toJson()).toList();
  return data;
}

HomeSwiper $HomeSwiperFromJson(Map<String, dynamic> json) {
  final HomeSwiper homeSwiper = HomeSwiper();
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    homeSwiper.title = title;
  }
  final String? imgUrl = jsonConvert.convert<String>(json['imgUrl']);
  if (imgUrl != null) {
    homeSwiper.imgUrl = imgUrl;
  }
  final String? htmlUrl = jsonConvert.convert<String>(json['htmlUrl']);
  if (htmlUrl != null) {
    homeSwiper.htmlUrl = htmlUrl;
  }
  return homeSwiper;
}

Map<String, dynamic> $HomeSwiperToJson(HomeSwiper entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['title'] = entity.title;
  data['imgUrl'] = entity.imgUrl;
  data['htmlUrl'] = entity.htmlUrl;
  return data;
}

HomeCatalog $HomeCatalogFromJson(Map<String, dynamic> json) {
  final HomeCatalog homeCatalog = HomeCatalog();
  final String? label = jsonConvert.convert<String>(json['label']);
  if (label != null) {
    homeCatalog.label = label;
  }
  final List<HomeCatalogComics>? comics =
      jsonConvert.convertListNotNull<HomeCatalogComics>(json['comics']);
  if (comics != null) {
    homeCatalog.comics = comics;
  }
  return homeCatalog;
}

Map<String, dynamic> $HomeCatalogToJson(HomeCatalog entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['label'] = entity.label;
  data['comics'] = entity.comics.map((v) => v.toJson()).toList();
  return data;
}

HomeCatalogComics $HomeCatalogComicsFromJson(Map<String, dynamic> json) {
  final HomeCatalogComics homeCatalogComics = HomeCatalogComics();
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    homeCatalogComics.title = title;
  }
  final String? htmlUrl = jsonConvert.convert<String>(json['htmlUrl']);
  if (htmlUrl != null) {
    homeCatalogComics.htmlUrl = htmlUrl;
  }
  final String? imgUrl = jsonConvert.convert<String>(json['imgUrl']);
  if (imgUrl != null) {
    homeCatalogComics.imgUrl = imgUrl;
  }
  final String? tag = jsonConvert.convert<String>(json['tag']);
  if (tag != null) {
    homeCatalogComics.tag = tag;
  }
  final String? cls = jsonConvert.convert<String>(json['cls']);
  if (cls != null) {
    homeCatalogComics.cls = cls;
  }
  return homeCatalogComics;
}

Map<String, dynamic> $HomeCatalogComicsToJson(HomeCatalogComics entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['title'] = entity.title;
  data['htmlUrl'] = entity.htmlUrl;
  data['imgUrl'] = entity.imgUrl;
  data['tag'] = entity.tag;
  data['cls'] = entity.cls;
  return data;
}
