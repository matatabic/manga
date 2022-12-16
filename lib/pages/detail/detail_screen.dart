import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:manga/common/widget/common_image.dart';
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

    return SafeArea(
        child: CustomScrollView(
      shrinkWrap: true,
      slivers: <Widget>[
        SliverPadding(
          padding: const EdgeInsets.all(20.0),
          sliver: SliverList(
            delegate: SliverChildListDelegate(
              <Widget>[
                SizedBox(
                  height: 210,
                  child: Row(
                    children: [
                      SizedBox(
                          width: 145,
                          height: 210,
                          child: CommonImage(imgUrl: detailEntity.info.imgUrl)),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(detailEntity.info.title,
                                style: const TextStyle(fontSize: 20)),
                            Text(detailEntity.info.author,
                                style: const TextStyle(fontSize: 17)),
                            Text(detailEntity.info.tagList.toString(),
                                style: const TextStyle(fontSize: 17)),
                            Text(detailEntity.info.supporting,
                                style: const TextStyle(color: Colors.red)),
                            // Text(detailEntity.info.desc),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                InkWell(
                  child: ExpandableText(
                    detailEntity.info.desc,
                    animation: true,
                    prefixText: detailEntity.info.title,
                    prefixStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 26,
                        color: Theme.of(context).primaryColor),
                    expandText: '顯示完整資訊',
                    collapseText: '只顯示部分資訊',
                    maxLines: 3,
                    linkColor: Colors.cyan,
                  ),
                ),
                Container(
                  width: 30,
                  height: 100,
                  color: Colors.red,
                ),
                Flex(direction: Axis.horizontal, children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () {},
                      child: const Text('加入書架'),
                    ),
                  ),
                  Expanded(
                    child: TextButton(
                      onPressed: () {},
                      child: const Text('開始閱讀'),
                    ),
                  ),
                ]),
                Wrap(spacing: 10, runSpacing: 10, children: [
                  ..._buildTagWidget(detailEntity.newChapter, () {})
                ]),
              ],
            ),
          ),
        ),
      ],
    ));
  }
}

List<Widget> _buildTagWidget(List<DetailNewChapter> tagList, onTap) {
  List<Widget> tagWidgetList = [];
  for (var item in tagList) {
    tagWidgetList.add(InkWell(
      onTap: () => onTap(item.title),
      child: Container(
        height: 60,
        width: 150,
        padding: const EdgeInsets.all(3.5),
        decoration: BoxDecoration(
            border: Border.all(
          color: Colors.grey, //边框颜色
          width: 1, //边框粗细
        )),
        child: Text(
          item.title,
          style: const TextStyle(fontSize: 17),
        ),
      ),
    ));
  }

  return tagWidgetList;
}
