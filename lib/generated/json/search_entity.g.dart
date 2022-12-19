import 'package:manga/entity/search_entity.dart';
import 'package:manga/generated/json/base/json_convert_content.dart';

SearchEntity $SearchEntityFromJson(Map<String, dynamic> json) {
  final SearchEntity searchEntity = SearchEntity();
  final SearchRegion? region =
      jsonConvert.convert<SearchRegion>(json['region']);
  if (region != null) {
    searchEntity.region = region;
  }
  final SearchState? state = jsonConvert.convert<SearchState>(json['state']);
  if (state != null) {
    searchEntity.state = state;
  }
  final SearchType? type = jsonConvert.convert<SearchType>(json['type']);
  if (type != null) {
    searchEntity.type = type;
  }
  final SearchFilter? filter =
      jsonConvert.convert<SearchFilter>(json['filter']);
  if (filter != null) {
    searchEntity.filter = filter;
  }
  final List<SearchComics>? comics =
      jsonConvert.convertListNotNull<SearchComics>(json['comics']);
  if (comics != null) {
    searchEntity.comics = comics;
  }
  return searchEntity;
}

Map<String, dynamic> $SearchEntityToJson(SearchEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['region'] = entity.region.toJson();
  data['state'] = entity.state.toJson();
  data['type'] = entity.type.toJson();
  data['filter'] = entity.filter.toJson();
  data['comics'] = entity.comics.map((v) => v.toJson()).toList();
  return data;
}

SearchRegion $SearchRegionFromJson(Map<String, dynamic> json) {
  final SearchRegion searchRegion = SearchRegion();
  final String? label = jsonConvert.convert<String>(json['label']);
  if (label != null) {
    searchRegion.label = label;
  }
  final List<SearchRegionData>? data =
      jsonConvert.convertListNotNull<SearchRegionData>(json['data']);
  if (data != null) {
    searchRegion.data = data;
  }
  return searchRegion;
}

Map<String, dynamic> $SearchRegionToJson(SearchRegion entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['label'] = entity.label;
  data['data'] = entity.data.map((v) => v.toJson()).toList();
  return data;
}

SearchRegionData $SearchRegionDataFromJson(Map<String, dynamic> json) {
  final SearchRegionData searchRegionData = SearchRegionData();
  final String? enName = jsonConvert.convert<String>(json['enName']);
  if (enName != null) {
    searchRegionData.enName = enName;
  }
  final String? cnName = jsonConvert.convert<String>(json['cnName']);
  if (cnName != null) {
    searchRegionData.cnName = cnName;
  }
  return searchRegionData;
}

Map<String, dynamic> $SearchRegionDataToJson(SearchRegionData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['enName'] = entity.enName;
  data['cnName'] = entity.cnName;
  return data;
}

SearchState $SearchStateFromJson(Map<String, dynamic> json) {
  final SearchState searchState = SearchState();
  final String? label = jsonConvert.convert<String>(json['label']);
  if (label != null) {
    searchState.label = label;
  }
  final List<SearchStateData>? data =
      jsonConvert.convertListNotNull<SearchStateData>(json['data']);
  if (data != null) {
    searchState.data = data;
  }
  return searchState;
}

Map<String, dynamic> $SearchStateToJson(SearchState entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['label'] = entity.label;
  data['data'] = entity.data.map((v) => v.toJson()).toList();
  return data;
}

SearchStateData $SearchStateDataFromJson(Map<String, dynamic> json) {
  final SearchStateData searchStateData = SearchStateData();
  final String? enName = jsonConvert.convert<String>(json['enName']);
  if (enName != null) {
    searchStateData.enName = enName;
  }
  final String? cnName = jsonConvert.convert<String>(json['cnName']);
  if (cnName != null) {
    searchStateData.cnName = cnName;
  }
  return searchStateData;
}

Map<String, dynamic> $SearchStateDataToJson(SearchStateData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['enName'] = entity.enName;
  data['cnName'] = entity.cnName;
  return data;
}

SearchType $SearchTypeFromJson(Map<String, dynamic> json) {
  final SearchType searchType = SearchType();
  final String? label = jsonConvert.convert<String>(json['label']);
  if (label != null) {
    searchType.label = label;
  }
  final List<SearchTypeData>? data =
      jsonConvert.convertListNotNull<SearchTypeData>(json['data']);
  if (data != null) {
    searchType.data = data;
  }
  return searchType;
}

Map<String, dynamic> $SearchTypeToJson(SearchType entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['label'] = entity.label;
  data['data'] = entity.data.map((v) => v.toJson()).toList();
  return data;
}

SearchTypeData $SearchTypeDataFromJson(Map<String, dynamic> json) {
  final SearchTypeData searchTypeData = SearchTypeData();
  final String? enName = jsonConvert.convert<String>(json['enName']);
  if (enName != null) {
    searchTypeData.enName = enName;
  }
  final String? cnName = jsonConvert.convert<String>(json['cnName']);
  if (cnName != null) {
    searchTypeData.cnName = cnName;
  }
  return searchTypeData;
}

Map<String, dynamic> $SearchTypeDataToJson(SearchTypeData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['enName'] = entity.enName;
  data['cnName'] = entity.cnName;
  return data;
}

SearchFilter $SearchFilterFromJson(Map<String, dynamic> json) {
  final SearchFilter searchFilter = SearchFilter();
  final String? label = jsonConvert.convert<String>(json['label']);
  if (label != null) {
    searchFilter.label = label;
  }
  final List<String>? data =
      jsonConvert.convertListNotNull<String>(json['data']);
  if (data != null) {
    searchFilter.data = data;
  }
  return searchFilter;
}

Map<String, dynamic> $SearchFilterToJson(SearchFilter entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['label'] = entity.label;
  data['data'] = entity.data;
  return data;
}

SearchComics $SearchComicsFromJson(Map<String, dynamic> json) {
  final SearchComics searchComics = SearchComics();
  final String? title = jsonConvert.convert<String>(json['title']);
  if (title != null) {
    searchComics.title = title;
  }
  final String? htmlUrl = jsonConvert.convert<String>(json['htmlUrl']);
  if (htmlUrl != null) {
    searchComics.htmlUrl = htmlUrl;
  }
  final String? imgUrl = jsonConvert.convert<String>(json['imgUrl']);
  if (imgUrl != null) {
    searchComics.imgUrl = imgUrl;
  }
  final String? tag = jsonConvert.convert<String>(json['tag']);
  if (tag != null) {
    searchComics.tag = tag;
  }
  final String? cls = jsonConvert.convert<String>(json['cls']);
  if (cls != null) {
    searchComics.cls = cls;
  }
  return searchComics;
}

Map<String, dynamic> $SearchComicsToJson(SearchComics entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['title'] = entity.title;
  data['htmlUrl'] = entity.htmlUrl;
  data['imgUrl'] = entity.imgUrl;
  data['tag'] = entity.tag;
  data['cls'] = entity.cls;
  return data;
}
