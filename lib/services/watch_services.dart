import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:html/parser.dart' show parse;
import 'package:manga/request/dio_manage.dart';
import 'package:manga/utils/logUtil.dart';

class WatchServices {
  static Future getData(htmlUrl) async {
    print("htmlUrl:$htmlUrl");
    Response? response = await DioManage.get(
        "https://www.webmota.com/comic/chapter/wuliandianfeng-pikapi_7ajf1a/0_2871.html");

    var document = parse(response?.data);

    var comicElement =
        document.querySelector(".comic-contain")?.querySelectorAll("amp-img");

    var lastChapter =
        document.querySelector("#prev-chapter")?.attributes["href"];

    var nextChapter =
        document.querySelector("#next-chapter")?.attributes["href"];

    List comicList = [];
    for (var comic in comicElement!) {
      comicList.add(comic.attributes["src"]);
    }

    var watchData = {
      "chapter": comicList,
      "lastChapter": lastChapter,
      "nextChapter": nextChapter,
    };
    LogUtil.d(json.encode(watchData));

    return watchData;
  }
}
