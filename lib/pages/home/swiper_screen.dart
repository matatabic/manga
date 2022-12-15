import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:manga/common/widget/common_image.dart';
import 'package:manga/entity/home_entity.dart';
import 'package:manga/providers/home_model.dart';
import 'package:provider/src/provider.dart';

class SwiperScreen extends StatelessWidget {
  final List<HomeSwiper> swiperList;
  final Function(HomeSwiper swiper) onTap;
  const SwiperScreen({Key? key, required this.swiperList, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Swiper(
        autoplay: true,
        onTap: (int index) {
          onTap(swiperList[index]);
        },
        itemBuilder: (BuildContext context, int index) {
          return CommonImage(
            imgUrl: swiperList[index].imgUrl,
          );
        },
        onIndexChanged: (int index) {
          context.read<HomeModel>().setIndex(index);
        },
        itemCount: swiperList.length,
        viewportFraction: 0.9,
        scale: 0.9,
        pagination: SwiperPagination(
            margin: EdgeInsets.zero,
            builder: SwiperCustomPagination(builder: (context, config) {
              return ConstrainedBox(
                constraints: const BoxConstraints.expand(height: 45),
                child: Container(
                    color: const Color.fromRGBO(0, 0, 0, .5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          '${config.activeIndex + 1}/${config.itemCount}',
                          style: const TextStyle(fontSize: 15),
                        ),
                        Text(
                          swiperList[config.activeIndex].title,
                          style: const TextStyle(fontSize: 16),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    )),
              );
            })),
      ),
    );
  }
}
