import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:manga/entity/detail_entity.dart';
import 'package:manga/services/detail_services.dart';

class DetailScreen extends StatefulWidget {
  final String htmlUrl;

  const DetailScreen({Key? key, required this.htmlUrl}) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  var _futureBuilderFuture;

  @override
  initState() {
    super.initState();
    _futureBuilderFuture = loadData(widget.htmlUrl);
  }

  Future loadData(htmlUrl) async {
    DetailEntity detailEntity = await DetailServices.getData(htmlUrl);

    return detailEntity;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
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
    DetailEntity detailEntity = snapshot.data;
    print(detailEntity.info);

    return SafeArea(
      child: SizedBox(
        height: 200,
        child: Row(
          children: [
            // CommonImage(imgUrl: detailEntity.info.),
            Column(
              children: [
                // Text(detailEntity.info.title),
                // Text(detailEntity.info.author),
                // Text(detailEntity.info.tagList.toString()),
                // Text(detailEntity.info.supporting),
                // Text(detailEntity.info.desc),
              ],
            )
          ],
        ),
      ),
    );
  }
}
