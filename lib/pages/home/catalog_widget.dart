import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:manga/common/hero_slide_page.dart';
import 'package:manga/common/widget/cover_photo.dart';
import 'package:manga/entity/home_entity.dart';
import 'package:manga/pages/detail/detail_screen.dart';

class CatalogWidget extends StatelessWidget {
  final HomeCatalog homeCatalog;
  final Interval opacityCurve;

  const CatalogWidget(
      {Key? key, required this.homeCatalog, required this.opacityCurve})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Container(
          height: 35,
          alignment: Alignment.topCenter,
          margin: const EdgeInsets.only(left: 2.5),
          width: double.infinity,
          child: Row(children: <Widget>[
            Text(
              homeCatalog.label,
              style: const TextStyle(fontSize: 19),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              size: 18,
            )
          ])),
      SizedBox(
          height: 200,
          child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: homeCatalog.comics.length,
              itemBuilder: (BuildContext context, int index) {
                String heroTag = UniqueKey().toString();
                return CoverPhoto(
                  title: homeCatalog.comics[index].title,
                  imgUrl: homeCatalog.comics[index].imgUrl,
                  heroTag: heroTag,
                  width: 135,
                  onTap: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) => DetailScreen(
                              htmlUrl: homeCatalog.comics[index].htmlUrl)),
                    );
                  },
                  onLongPress: () {
                    Navigator.of(context).push(PageRouteBuilder(
                        opaque: false,
                        pageBuilder: (context, animation, secondaryAnimation) {
                          return AnimatedBuilder(
                            animation: animation,
                            builder: (context, child) {
                              return Opacity(
                                opacity:
                                    opacityCurve.transform(animation.value),
                                child: HeroSlidePage(
                                    heroTag: heroTag,
                                    url: homeCatalog.comics[index].imgUrl),
                              );
                            },
                          );
                        }));
                  },
                );
              }))
    ]);
  }
}
