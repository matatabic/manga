import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:html/parser.dart' show parse;
import 'package:manga/entity/detail_entity.dart';
import 'package:manga/request/dio_manage.dart';

import '../utils/logUtil.dart';

class DetailServices {
  static Future getData(String htmlUrl) async {
    Response? response = await DioManage.get("https://tw.baozimh.com$htmlUrl");

    var document = parse(response?.data);

    var infoElement = document.querySelector(".comics-detail__info");
    var title = infoElement?.querySelector(".comics-detail__title")?.text;
    var author = infoElement?.querySelector(".comics-detail__author")?.text;
    var tagElement = infoElement?.querySelectorAll(".tag");
    var imgUrl = document
        .querySelector(".addthis-box")
        ?.querySelector("amp-addthis")
        ?.attributes["data-media"];

    List tagList = [];
    for (var tag in tagElement!) {
      String tagStr = tag.text.trim();
      if (tagStr.isNotEmpty && tagStr != " ") {
        tagList.add(tagStr);
      }
    }
    var supporting = infoElement
        ?.querySelector(".supporting-text")
        ?.querySelectorAll("div")[1]
        .text
        .replaceAll("\n", "")
        .replaceAll(" ", "");

    var desc = infoElement
        ?.querySelector(".comics-detail__desc")
        ?.text
        .replaceAll("\n", "");

    var info = {
      "title": title,
      "imgUrl": imgUrl,
      "author": author,
      "tagList": tagList,
      "supporting": supporting,
      "desc": desc,
    };

    //最新章節列表
    List newChapterList = [];
    var newChapterElement =
        document.querySelectorAll(".l-content")[4].querySelector(".pure-g");
    var newChapterElementList =
        newChapterElement?.querySelectorAll(".comics-chapters");

    for (var item in newChapterElementList!) {
      newChapterList.add({
        "title": item.querySelector("div")?.text,
        "htmlUrl": item.querySelector("a")?.attributes['href']
      });
    }
    List chapterList = [];
    var chapterElement = document
        .querySelector("#chapter-items")
        ?.querySelectorAll(".comics-chapters");
    for (var item in chapterElement!) {
      chapterList.add({
        "title": item.querySelector("div")?.text,
        "htmlUrl": item.querySelector("a")?.attributes['href']
      });
    }

    var chapterOtherElement = document
        .querySelector("#chapters_other_list")
        ?.querySelectorAll(".comics-chapters");
    for (var item in chapterOtherElement!) {
      chapterList.add({
        "title": item.querySelector("div")?.text,
        "htmlUrl": item.querySelector("a")?.attributes['href']
      });
    }

    var detailData = {
      "info": info,
      "newChapter": newChapterList,
      "chapter": chapterList,
    };
    // LogUtil.d(json.encode(detailData));
    return DetailEntity.fromJson(detailData);
  }
}
