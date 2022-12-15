import 'dart:convert';

import 'package:manga/generated/json/base/json_field.dart';
import 'package:manga/generated/json/home_entity.g.dart';

@JsonSerializable()
class HomeEntity {
  late List<HomeSwiper> swiper;
  late List<HomeCatalog> catalog;

  HomeEntity();

  factory HomeEntity.fromJson(Map<String, dynamic> json) =>
      $HomeEntityFromJson(json);

  Map<String, dynamic> toJson() => $HomeEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class HomeSwiper {
  late String title;
  late String imgUrl;
  late String htmlUrl;

  HomeSwiper();

  factory HomeSwiper.fromJson(Map<String, dynamic> json) =>
      $HomeSwiperFromJson(json);

  Map<String, dynamic> toJson() => $HomeSwiperToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class HomeCatalog {
  late String label;
  late List<HomeCatalogComics> comics;

  HomeCatalog();

  factory HomeCatalog.fromJson(Map<String, dynamic> json) =>
      $HomeCatalogFromJson(json);

  Map<String, dynamic> toJson() => $HomeCatalogToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class HomeCatalogComics {
  late String title;
  late String htmlUrl;
  late String imgUrl;
  late String tag;
  late String cls;

  HomeCatalogComics();

  factory HomeCatalogComics.fromJson(Map<String, dynamic> json) =>
      $HomeCatalogComicsFromJson(json);

  Map<String, dynamic> toJson() => $HomeCatalogComicsToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
