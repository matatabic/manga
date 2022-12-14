import 'package:dio/dio.dart';
import 'package:html/parser.dart' show parse;
import 'package:manga/request/dio_manage.dart';

class WatchServices {
  static Future getData() async {
    Response? response = await DioManage.get(
        "https://www.webmota.com/comic/chapter/wuliandianfeng-pikapi_7ajf1a/0_2871.html");

    var document = parse(response?.data);

    var comicElement =
        document.querySelector(".comic-contain")?.querySelectorAll("amp-img");

    for (var comic in comicElement!) {
      print(comic.attributes['src']);
    }
  }
}
