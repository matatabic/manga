import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:manga/common/widget/common_image.dart';
import 'package:manga/entity/home_entity.dart';
import 'package:manga/pages/home/swiper_screen.dart';
import 'package:manga/providers/home_model.dart';
import 'package:provider/src/provider.dart';

class HomeHeaderScreen extends StatelessWidget {
  final List<HomeSwiper> swiperList;

  const HomeHeaderScreen({Key? key, required this.swiperList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    int swiperIndex =
        context.select<HomeModel, int>((value) => value.swiperIndex);

    return SizedBox(
      height: 260,
      child: Stack(children: [
        ConstrainedBox(
          constraints: const BoxConstraints.expand(),
          child: Stack(children: [
            CommonImage(imgUrl: swiperList[swiperIndex].imgUrl),
            ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                child: Opacity(
                  opacity: 0.5,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade500.withOpacity(0.3),
                    ),
                  ),
                ),
              ),
            )
          ]),
        ),
        Container(
          alignment: AlignmentDirectional.bottomStart,
          child: SwiperScreen(
              swiperList: swiperList,
              onTap: (HomeSwiper swiper) => {
                    // Navigator.push(
                    //     context,
                    //     CupertinoPageRoute(
                    //         builder: (context) =>
                    //             WatchScreen(htmlUrl: swiper.htmlUrl)))
                  }),
        )
      ]),
    );
  }
}
