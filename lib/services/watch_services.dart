import 'package:dio/dio.dart';
import 'package:html/parser.dart' show parse;
import 'package:manga/request/dio_manage.dart';

import '../entity/watch_entity.dart';

class WatchServices {
  static Future getData(htmlUrl) async {
    print("htmlUrl:$htmlUrl");
    Response? response = await DioManage.get("https://www.webmota.com$htmlUrl");

    var document = parse(response?.data);

    var comicElement =
        document.querySelector(".comic-contain")?.querySelectorAll("amp-img");

    var lastChapter =
        document.querySelector("#prev-chapter")?.attributes["href"];

    var nextChapter =
        document.querySelector("#next-chapter")?.attributes["href"];

    List comicList = [];
    for (var comic in comicElement!) {
      comicList.add({
        "imgUrl": comic.attributes["src"],
        "imgWidth": comic.attributes["width"],
        "imgHeight": comic.attributes["height"],
      });
    }

    var watchData = {
      "chapter": comicList,
      "lastChapter": lastChapter,
      "nextChapter": nextChapter,
    };

    return WatchEntity.fromJson(watchData);
  }
}
