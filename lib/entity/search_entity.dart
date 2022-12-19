import 'dart:convert';

import 'package:manga/generated/json/base/json_field.dart';
import 'package:manga/generated/json/search_entity.g.dart';

@JsonSerializable()
class SearchEntity {
  late SearchRegion region;
  late SearchState state;
  late SearchType type;
  late SearchFilter filter;
  late List<SearchComics> comics;

  SearchEntity();

  factory SearchEntity.fromJson(Map<String, dynamic> json) =>
      $SearchEntityFromJson(json);

  Map<String, dynamic> toJson() => $SearchEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class SearchRegion {
  late String label;
  late List<SearchRegionData> data;

  SearchRegion();

  factory SearchRegion.fromJson(Map<String, dynamic> json) =>
      $SearchRegionFromJson(json);

  Map<String, dynamic> toJson() => $SearchRegionToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class SearchRegionData {
  late String enName;
  late String cnName;

  SearchRegionData();

  factory SearchRegionData.fromJson(Map<String, dynamic> json) =>
      $SearchRegionDataFromJson(json);

  Map<String, dynamic> toJson() => $SearchRegionDataToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class SearchState {
  late String label;
  late List<SearchStateData> data;

  SearchState();

  factory SearchState.fromJson(Map<String, dynamic> json) =>
      $SearchStateFromJson(json);

  Map<String, dynamic> toJson() => $SearchStateToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class SearchStateData {
  late String enName;
  late String cnName;

  SearchStateData();

  factory SearchStateData.fromJson(Map<String, dynamic> json) =>
      $SearchStateDataFromJson(json);

  Map<String, dynamic> toJson() => $SearchStateDataToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class SearchType {
  late String label;
  late List<SearchTypeData> data;

  SearchType();

  factory SearchType.fromJson(Map<String, dynamic> json) =>
      $SearchTypeFromJson(json);

  Map<String, dynamic> toJson() => $SearchTypeToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class SearchTypeData {
  late String enName;
  late String cnName;

  SearchTypeData();

  factory SearchTypeData.fromJson(Map<String, dynamic> json) =>
      $SearchTypeDataFromJson(json);

  Map<String, dynamic> toJson() => $SearchTypeDataToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class SearchFilter {
  late String label;
  late List<String> data;

  SearchFilter();

  factory SearchFilter.fromJson(Map<String, dynamic> json) =>
      $SearchFilterFromJson(json);

  Map<String, dynamic> toJson() => $SearchFilterToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class SearchComics {
  late String title;
  late String htmlUrl;
  late String imgUrl;
  late String tag;
  late String cls;

  SearchComics();

  factory SearchComics.fromJson(Map<String, dynamic> json) =>
      $SearchComicsFromJson(json);

  Map<String, dynamic> toJson() => $SearchComicsToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
