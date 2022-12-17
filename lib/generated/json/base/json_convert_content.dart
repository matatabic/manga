// ignore_for_file: non_constant_identifier_names
// ignore_for_file: camel_case_types
// ignore_for_file: prefer_single_quotes

// This file is automatically generated. DO NOT EDIT, all your changes would be lost.
import 'package:flutter/material.dart' show debugPrint;
import 'package:manga/entity/detail_entity.dart';
import 'package:manga/entity/home_entity.dart';
import 'package:manga/entity/watch_entity.dart';

JsonConvert jsonConvert = JsonConvert();
typedef JsonConvertFunction<T> = T Function(Map<String, dynamic> json);

class JsonConvert {
  static final Map<String, JsonConvertFunction> _convertFuncMap = {
    (DetailEntity).toString(): DetailEntity.fromJson,
    (DetailInfo).toString(): DetailInfo.fromJson,
    (DetailNewChapter).toString(): DetailNewChapter.fromJson,
    (DetailChapter).toString(): DetailChapter.fromJson,
    (HomeEntity).toString(): HomeEntity.fromJson,
    (HomeSwiper).toString(): HomeSwiper.fromJson,
    (HomeCatalog).toString(): HomeCatalog.fromJson,
    (HomeCatalogComics).toString(): HomeCatalogComics.fromJson,
    (WatchEntity).toString(): WatchEntity.fromJson,
  };

  T? convert<T>(dynamic value) {
    if (value == null) {
      return null;
    }
    return asT<T>(value);
  }

  List<T?>? convertList<T>(List<dynamic>? value) {
    if (value == null) {
      return null;
    }
    try {
      return value.map((dynamic e) => asT<T>(e)).toList();
    } catch (e, stackTrace) {
      debugPrint('asT<$T> $e $stackTrace');
      return <T>[];
    }
  }

  List<T>? convertListNotNull<T>(dynamic value) {
    if (value == null) {
      return null;
    }
    try {
      return (value as List<dynamic>).map((dynamic e) => asT<T>(e)!).toList();
    } catch (e, stackTrace) {
      debugPrint('asT<$T> $e $stackTrace');
      return <T>[];
    }
  }

  T? asT<T extends Object?>(dynamic value) {
    if (value == null) {
      return null;
    }
    if (value is T) {
      return value;
    }
    final String type = T.toString();
    try {
      final String valueS = value.toString();
      if (type == "String") {
        return valueS as T;
      } else if (type == "int") {
        final int? intValue = int.tryParse(valueS);
        if (intValue == null) {
          return double.tryParse(valueS)?.toInt() as T?;
        } else {
          return intValue as T;
        }
      } else if (type == "double") {
        return double.parse(valueS) as T;
      } else if (type == "DateTime") {
        return DateTime.parse(valueS) as T;
      } else if (type == "bool") {
        if (valueS == '0' || valueS == '1') {
          return (valueS == '1') as T;
        }
        return (valueS == 'true') as T;
      } else if (type == "Map" || type.startsWith("Map<")) {
        return value as T;
      } else {
        if (_convertFuncMap.containsKey(type)) {
          return _convertFuncMap[type]!(value) as T;
        } else {
          throw UnimplementedError('$type unimplemented');
        }
      }
    } catch (e, stackTrace) {
      debugPrint('asT<$T> $e $stackTrace');
      return null;
    }
  }

  //list is returned by type
  static M? _getListChildType<M>(List<Map<String, dynamic>> data) {
    if (<DetailEntity>[] is M) {
      return data
          .map<DetailEntity>(
              (Map<String, dynamic> e) => DetailEntity.fromJson(e))
          .toList() as M;
    }
    if (<DetailInfo>[] is M) {
      return data
          .map<DetailInfo>((Map<String, dynamic> e) => DetailInfo.fromJson(e))
          .toList() as M;
    }
    if (<DetailNewChapter>[] is M) {
      return data
          .map<DetailNewChapter>(
              (Map<String, dynamic> e) => DetailNewChapter.fromJson(e))
          .toList() as M;
    }
    if (<DetailChapter>[] is M) {
      return data
          .map<DetailChapter>(
              (Map<String, dynamic> e) => DetailChapter.fromJson(e))
          .toList() as M;
    }
    if (<HomeEntity>[] is M) {
      return data
          .map<HomeEntity>((Map<String, dynamic> e) => HomeEntity.fromJson(e))
          .toList() as M;
    }
    if (<HomeSwiper>[] is M) {
      return data
          .map<HomeSwiper>((Map<String, dynamic> e) => HomeSwiper.fromJson(e))
          .toList() as M;
    }
    if (<HomeCatalog>[] is M) {
      return data
          .map<HomeCatalog>((Map<String, dynamic> e) => HomeCatalog.fromJson(e))
          .toList() as M;
    }
    if (<HomeCatalogComics>[] is M) {
      return data
          .map<HomeCatalogComics>(
              (Map<String, dynamic> e) => HomeCatalogComics.fromJson(e))
          .toList() as M;
    }
    if (<WatchEntity>[] is M) {
      return data
          .map<WatchEntity>((Map<String, dynamic> e) => WatchEntity.fromJson(e))
          .toList() as M;
    }

    debugPrint("${M.toString()} not found");

    return null;
  }

  static M? fromJsonAsT<M>(dynamic json) {
    if (json is List) {
      return _getListChildType<M>(
          json.map((e) => e as Map<String, dynamic>).toList());
    } else {
      return jsonConvert.asT<M>(json);
    }
  }
}
