import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:manga/common/widget/common_image.dart';
import 'package:manga/services/watch_services.dart';

import '../../entity/watch_entity.dart';

class WatchScreen extends StatefulWidget {
  final String htmlUrl;

  const WatchScreen({Key? key, required this.htmlUrl}) : super(key: key);

  @override
  State<WatchScreen> createState() => _WatchScreenState();
}

class _WatchScreenState extends State<WatchScreen> {
  var _futureBuilderFuture;

  @override
  initState() {
    super.initState();
    _futureBuilderFuture = loadData(widget.htmlUrl);
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future loadData(htmlUrl) async {
    WatchEntity watchEntity = await WatchServices.getData(htmlUrl);

    return watchEntity.chapter;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        builder: _buildFuture,
        future:
            _futureBuilderFuture, // 用户定义的需要异步执行的代码，类型为Future<String>或者null的变量或函数
      ),
    );
  }

  Widget _buildFuture(BuildContext context, AsyncSnapshot snapshot) {
    switch (snapshot.connectionState) {
      case ConnectionState.none:
        print('还没有开始网络请求');
        return const Text('还没有开始网络请求');
      case ConnectionState.active:
        print('active');
        return const Text('ConnectionState.active');
      case ConnectionState.waiting:
        print('waiting');
        return const Center(
          child: CircularProgressIndicator(),
        );
      case ConnectionState.done:
        print('done');
        print(snapshot.error);
        if (snapshot.hasError) {
          return Center(
              child: MaterialButton(
            color: Colors.blue,
            textColor: Colors.white,
            child: const Text('网络异常,点击重新加载'),
            onPressed: () {
              setState(() {
                _futureBuilderFuture = loadData(widget.htmlUrl);
              });
            },
          ));
        } else {
          return _createWidget(context, snapshot);
        }
    }
  }

  Widget _createWidget(BuildContext context, AsyncSnapshot snapshot) {
    print("_createWidget");
    List<String> chapterList = snapshot.data;

    return ListView.builder(
        // shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: chapterList.length,
        itemBuilder: (BuildContext context, int index) {
          return CommonImage(imgUrl: chapterList[index]);
        });
  }
}
