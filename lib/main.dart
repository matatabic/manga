import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:manga/providers/home_model.dart';
import 'package:provider/provider.dart';

import 'bottom_nav_bar.dart';

void main() => runApp(
      MultiProvider(
        providers: [ChangeNotifierProvider(create: (_) => HomeModel())],
        child: const MyApp(),
      ),
    );

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        showPerformanceOverlay: false,
        locale: const Locale('en'),
        builder: BotToastInit(), //1.调用BotToastInit
        navigatorObservers: [BotToastNavigatorObserver()], //2.注册路由观察者
        theme: ThemeData(
          platform: TargetPlatform.iOS,
          brightness: Brightness.dark,
          dialogBackgroundColor: Colors.black,
          primaryColor: Colors.orange[800],
          accentColor: Colors.orange[300],
          scaffoldBackgroundColor: Colors.black26,
        ),
        home: BottomNavBar());
  }
}
