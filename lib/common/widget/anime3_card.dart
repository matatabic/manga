import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'common_image.dart';

class Anime3Card extends StatelessWidget {
  final String title;
  final String imgUrl;
  final VoidCallback onTap;
  final VoidCallback onLongPress;
  final String heroTag;

  const Anime3Card(
      {Key? key,
      required this.title,
      required this.imgUrl,
      required this.onTap,
      required this.onLongPress,
      required this.heroTag})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        onLongPress: onLongPress,
        child: Stack(
          alignment: const Alignment(-1, 1),
          children: <Widget>[
            ConstrainedBox(
              constraints: const BoxConstraints.expand(),
              child: Hero(tag: heroTag, child: CommonImage(imgUrl: imgUrl)),
            ),
            Text(
              title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                shadows: <Shadow>[
                  Shadow(
                    offset: Offset(2.5, 2.5),
                    blurRadius: 3.5,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
