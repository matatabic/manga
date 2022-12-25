import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WatchItem extends StatefulWidget {
  final String imgUrl;
  final double imgWidth;
  final double imgHeight;

  const WatchItem(
      {Key? key,
      required this.imgUrl,
      required this.imgWidth,
      required this.imgHeight})
      : super(key: key);

  @override
  State<WatchItem> createState() => _WatchItemState();
}

class _WatchItemState extends State<WatchItem> {
  @override
  Widget build(BuildContext context) {
    return ExtendedImage(
      fit: BoxFit.cover,
      image: ExtendedResizeImage(
        ExtendedNetworkImageProvider(widget.imgUrl,
            cache: false,
            retries: 3,
            timeRetry: const Duration(milliseconds: 700)),
        compressionRatio: 1,
      ),
      loadStateChanged: (ExtendedImageState state) {
        switch (state.extendedImageLoadState) {
          case LoadState.loading:
            return SizedBox(
              width: 375,
              height: widget.imgHeight * (375 / widget.imgWidth),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          case LoadState.completed:
            return null;
          case LoadState.failed:
            return GestureDetector(
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  Image.asset(
                    "assets/images/error.png",
                    fit: BoxFit.fill,
                  ),
                  const Positioned(
                    bottom: 0.0,
                    left: 0.0,
                    right: 0.0,
                    child: Text(
                      "load image failed, click to reload",
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
              onTap: () {
                state.reLoadImage();
              },
            );
        }
      },
    );
  }
}
