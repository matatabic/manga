import 'package:dio/dio.dart';
import 'package:html/parser.dart' show parse;
import 'package:manga/entity/search_entity.dart';
import 'package:manga/request/dio_manage.dart';

//國漫日本韓國歐美
SearchRegion searchRegion = SearchRegion.fromJson({
  "label": "地區",
  "data": [
    {"enName": "all", "cnName": "全部"},
    {"enName": "cn", "cnName": "國漫"},
    {"enName": "jp", "cnName": "日本"},
    {"enName": "kr", "cnName": "韓國"},
    {"enName": "eu", "cnName": "歐美"},
  ]
});
//連載中已完結
SearchState searchState = SearchState.fromJson({
  "label": "狀態",
  "data": [
    {"enName": "all", "cnName": "全部"},
    {"enName": "ongoing", "cnName": "連載中"},
    {"enName": "completed", "cnName": "已完結"},
  ]
});
//戀愛純愛古風異能懸疑劇情科幻奇幻玄幻穿越冒險推理武俠格鬥戰爭熱血搞笑大女主都市總裁後宮日常韓漫少年其它
SearchType searchType = SearchType.fromJson({
  "label": "類型",
  "data": [
    {
      "enName": "all",
      "cnName": "全部",
    },
    {
      "enName": "lianai",
      "cnName": "戀愛",
    },
    {
      "enName": "chunai",
      "cnName": "純愛",
    },
    {
      "enName": "gufeng",
      "cnName": "古風",
    },
    {
      "enName": "yineng",
      "cnName": "異能",
    },
    {
      "enName": "xuanyi",
      "cnName": "懸疑",
    },
    {
      "enName": "juqing",
      "cnName": "劇情",
    },
    {
      "enName": "kehuan",
      "cnName": "科幻",
    },
    {
      "enName": "qihuan",
      "cnName": "奇幻",
    },
    {
      "enName": "xuanhuan",
      "cnName": "玄幻",
    },
    {
      "enName": "chuanyue",
      "cnName": "穿越",
    },
    {
      "enName": "maoxian",
      "cnName": "冒險",
    },
    {
      "enName": "tuili",
      "cnName": "推理",
    },
    {
      "enName": "wuxia",
      "cnName": "武俠",
    },
    {
      "enName": "gedou",
      "cnName": "格鬥",
    },
    {
      "enName": "zhanzheng",
      "cnName": "戰爭",
    },
    {
      "enName": "rexue",
      "cnName": "熱血",
    },
    {
      "enName": "gaoxiao",
      "cnName": "搞笑",
    },
    {
      "enName": "danuzhu",
      "cnName": "大女主",
    },
    {
      "enName": "dushi",
      "cnName": "都市",
    },
    {
      "enName": "zongcai",
      "cnName": "總裁",
    },
    {
      "enName": "hougong",
      "cnName": "後宮",
    },
    {
      "enName": "richang",
      "cnName": "日常",
    },
    {
      "enName": "hanman",
      "cnName": "韓漫",
    },
    {
      "enName": "shaonian",
      "cnName": "少年",
    },
    {
      "enName": "qita",
      "cnName": "其它",
    },
  ]
});
// ABCD EFGH IJKL MNOP QRST UVW XYZ 0-9
SearchFilter searchFilter = SearchFilter.fromJson({
  "label": "首字母",
  "data": [
    "全部",
    "ABCD",
    "EFGH",
    "IJKL",
    "MNOP",
    "QRST",
    "UVW",
    "XYZ",
    "0-9",
  ]
});

class SearchServices {
  static Future getData() async {
    Response? response = await DioManage.get(
        "https://tw.baozimh.com/classify?type=all&region=all&state=all&filter=ABCD");
    if (response == null) {
      return null;
    }

    var document = parse(response.data);

    var contentElement = document.querySelector(".classify-items");

    var comicsCardElement = contentElement?.querySelectorAll(".comics-card");

    List itemList = [];
    for (var comicCard in comicsCardElement!) {
      itemList.add({
        "title": comicCard.querySelector(".comics-card__title")?.text.trim(),
        "htmlUrl": comicCard.querySelector("a")?.attributes["href"],
        "imgUrl": comicCard.querySelector("amp-img")?.attributes["src"],
        "tag": comicCard.querySelector(".tags")?.text.trim(),
        "cls": comicCard
            .querySelector(".cls")
            ?.text
            .trim()
            .replaceAll("\n", ".")
            .replaceAll(" ", "")
            .replaceAll("..", "、")
      });
    }
    var searchData = {
      // "region": searchRegion,
      // "state": searchState,
      // "type": searchType,
      // "filter": searchFilter,
      "comics": itemList,
    };
    // LogUtil.d(json.encode(searchRegion));
    return SearchEntity.fromJson(searchData);
  }
}
