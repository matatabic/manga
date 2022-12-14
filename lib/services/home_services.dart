import 'package:dio/dio.dart';
import 'package:html/parser.dart' show parse;
import 'package:manga/request/dio_manage.dart';
import 'package:manga/utils/logUtil.dart';

class HomeServices {
  static Future getData() async {
    Response? response = await DioManage.get("https://tw.webmota.com");
    var document = parse(response?.data);

    List swiper = [
      {
        "title": "一人之下",
        "imgUrl":
            "https://manhua.qpic.cn/operation/0/14_10_04_96c16a9f2c491350e7cb09a62996b8b5_1555207448452.jpg/0",
        "htmlUrl": "/comic/yirenzhixia-dongmantang_d",
      },
      {
        "title": "排球少年！！",
        "imgUrl":
            "https://manhua.acimg.cn/operation/0/18_15_10_e59c79be2f8ac77250c77e6a367e68ad_1624000259373.jpg/0",
        "htmlUrl": "/comic/paiqiushaonian-guguanchunyi",
      },
      {
        "title": "传武",
        "imgUrl":
            "https://cdn.jsdelivr.net/gh/kochokochokaeru/kochokochokaeru-h@latest/asset/thumbnail/jl8TZR2h.jpg",
        "htmlUrl": "/comic/chuanwu-gkgongfang",
      },
    ];

    List contentList = [];
    var contentElement = document.querySelectorAll(".index-recommend-items");

    for (var itemElement in contentElement) {
      String title = itemElement.querySelector(".catalog-title")!.text.trim();

      List itemList = [];
      var comicsCardElement = itemElement.querySelectorAll(".comics-card");
      for (var comicCard in comicsCardElement) {
        itemList.add({
          "title": comicCard.querySelector(".comics-card__title")?.text.trim(),
          "html": comicCard.querySelector("a")?.attributes["href"],
          "cover": comicCard.querySelector("amp-img")?.attributes["src"],
          "tag": comicCard.querySelector(".tags")?.text.trim(),
          "cls": comicCard.querySelector(".cls")?.text.trim(),
        });
      }
      contentList.add({
        "title": title,
        "itemList": itemList,
      });
    }

    var homeData = {"swiper": swiper, "content": contentList};

    LogUtil.v(homeData);
  }
}
