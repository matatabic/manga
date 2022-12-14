import 'package:dio/dio.dart';
import 'package:html/parser.dart' show parse;
import 'package:manga/request/dio_manage.dart';
import 'package:manga/utils/logUtil.dart';

class DetailServices {
  static Future getData() async {
    Response? response = await DioManage.get(
        "https://tw.baozimh.com/comic/doupocangqiong-zhiyindongman_j");

    var document = parse(response?.data);

    var infoElement = document.querySelector(".comics-detail__info");

    var title = infoElement?.querySelector(".comics-detail__title")?.text;
    var author = infoElement?.querySelector(".comics-detail__author")?.text;
    var tagElement = infoElement?.querySelectorAll(".tag");
    List tagList = [];
    for (var tag in tagElement!) {
      String tagStr = tag.text.trim();
      if (tagStr.length > 0 && tagStr != " ") {
        tagList.add(tagStr);
      }
    }
    var supporting = infoElement
        ?.querySelector(".supporting-text")
        ?.querySelectorAll("div")[1]
        .text
        .replaceAll("\n", "")
        .replaceAll(" ", "");

    var desc = infoElement?.querySelector(".comics-detail__desc")?.text;

    // LogUtil.d("title: $title");
    // LogUtil.d("author: $author");
    // LogUtil.d("tagList: $tagList");
    // LogUtil.d("supporting: $supporting");
    // LogUtil.d("desc: $desc");

    //最新章節列表
    var newChapterElement =
        document.querySelectorAll(".l-content")[4].querySelector(".pure-g");
    var newChapterList =
        newChapterElement?.querySelectorAll(".comics-chapters");

    for (var item in newChapterList!) {
      // LogUtil.d(item.querySelector("div")?.text);
      // LogUtil.d(item.querySelector("a")?.attributes['href']);
    }

    var chapterElement = document
        .querySelector("#chapter-items")
        ?.querySelectorAll(".comics-chapters");
    for (var item in chapterElement!) {
      // LogUtil.d(item.querySelector("div")?.text);
      // LogUtil.d(item.querySelector("a")?.attributes['href']);
    }

    var chapterOtherElement = document
        .querySelector("#chapters_other_list")
        ?.querySelectorAll(".comics-chapters");
    for (var item in chapterOtherElement!) {
      LogUtil.d(item.querySelector("div")?.text);
      LogUtil.d(item.querySelector("a")?.attributes['href']);
    }
  }
}
