import 'dart:isolate';
import 'dart:ui';

import 'package:bot_toast/bot_toast.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:manga/pages/home/home_screen.dart';
import 'package:manga/pages/my/my_screen.dart';
import 'package:manga/pages/search/search_screen.dart';

class BottomNavBar extends StatefulWidget {
  BottomNavBar({Key? key}) : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar>
    with SingleTickerProviderStateMixin {
  dynamic _lastTime;
  late TabController tabController;

  int currentIndex = 0;

  ReceivePort _port = ReceivePort();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadCache();
    tabController = TabController(vsync: this, length: 3);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          // backgroundColor: colors[currentIndex],
          color: Theme.of(context).primaryColor,
          buttonBackgroundColor: Colors.transparent,
          backgroundColor: Colors.black26,
          // index: currentIndex,
          items: <Widget>[
            const Icon(Icons.home, size: 30),
            const Icon(Icons.cloud_circle, size: 30),
            const Icon(Icons.collections, size: 30),
          ],
          onTap: (index) {
            //Handle button tap
            // setState(() {
            //   currentIndex = index;
            // });
            tabController.animateTo(index,
                duration: const Duration(milliseconds: 300),
                curve: Curves.ease);
          },
        ),
        body: WillPopScope(
          onWillPop: () async {
            _doQuit();
            return false;
          },
          child: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            controller: tabController,
            children: const <Widget>[
              HomeScreen(),
              SearchScreen(),
              MyScreen(),
            ],
          ),
        ));
  }

  void loadCache() async {}

  void _doQuit() async {
    // ????????????????????????????????????
    if (_lastTime == null ||
        DateTime.now().difference(_lastTime) > Duration(seconds: 2)) {
      // ?????????????????????????????????
      _lastTime = DateTime.now();
      BotToast.showCustomNotification(
          duration: const Duration(seconds: 2),
          align: Alignment(0, -1.2),
          toastBuilder: (_) {
            return Container(
              alignment: Alignment.bottomLeft,
              width: MediaQueryData.fromWindow(window).size.width,
              height: 130,
              color: Colors.redAccent,
              child: Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Row(
                  children: [
                    Icon(Icons.airport_shuttle, color: Colors.white),
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Text(
                        "?????????????????????????????????",
                        style: TextStyle(fontSize: 18),
                      ),
                    )
                  ],
                ),
              ),
            );
          });
    }
    // ????????????????????????????????????????????? APP
    else {
      await SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    }
  }
}
