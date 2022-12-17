import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:manga/common/widget/common_image.dart';
import 'package:manga/entity/detail_entity.dart';
import 'package:manga/pages/watch/watch_screen.dart';
import 'package:manga/services/detail_services.dart';

const double _kDrawerHeaderHeight = 160.0 + 1.0; // bottom edge

class DetailScreen extends StatefulWidget {
  final String htmlUrl;

  const DetailScreen({Key? key, required this.htmlUrl}) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen>
    with SingleTickerProviderStateMixin {
  var _futureBuilderFuture;
  late AnimationController _animationController;
  bool _expanded = false;

  @override
  initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      upperBound: 0.5,
    );
    _futureBuilderFuture = loadData(widget.htmlUrl);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future loadData(htmlUrl) async {
    DetailEntity detailEntity = await DetailServices.getData(htmlUrl);

    return detailEntity;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FutureBuilder(
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
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    DetailEntity detailEntity = snapshot.data;

    return Scaffold(
        body: Builder(builder: (context) {
          return CustomScrollView(
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
                                child: CommonImage(
                                    imgUrl: detailEntity.info.imgUrl)),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(detailEntity.info.title,
                                      style: const TextStyle(fontSize: 20)),
                                  Text(detailEntity.info.author,
                                      style: const TextStyle(fontSize: 17)),
                                  Text(detailEntity.info.tagList.join(','),
                                      style: const TextStyle(fontSize: 17)),
                                  Text(detailEntity.info.supporting,
                                      style:
                                          const TextStyle(color: Colors.red)),
                                  // Text(detailEntity.info.desc),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      ExpandableText(
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
                      Center(
                          child: InkWell(
                        onTap: () {
                          Scaffold.of(context).openEndDrawer();
                        },
                        child: Container(
                          margin: const EdgeInsets.only(top: 15),
                          width: 170,
                          height: 50,
                          color: Colors.grey,
                          child: const Center(
                              child: Text("查看全部章節",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold))),
                        ),
                      )),
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
                        ..._buildNewChapterWidget(detailEntity.newChapter,
                            (htmlUrl) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      WatchScreen(htmlUrl: htmlUrl)));
                        })
                      ]),
                    ],
                  ),
                ),
              ),
            ],
          );
        }),
        endDrawer: Drawer(
          child: CustomScrollView(shrinkWrap: true, slivers: <Widget>[
            SliverAppBar(
                pinned: true,
                actions: [Container()],
                automaticallyImplyLeading: false,
                toolbarHeight: statusBarHeight + _kDrawerHeaderHeight,
                flexibleSpace: FlexibleSpaceBar(
                    titlePadding: const EdgeInsets.all(0),
                    title: DrawerHeader(
                      decoration:
                          const BoxDecoration(color: Colors.orangeAccent),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "章節列表",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                              Text(
                                "共 ${detailEntity.chapter.length} 章",
                                style: const TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 80,
                                height: 40,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: Colors.yellow,
                                    borderRadius: BorderRadius.circular(15)),
                                child: Text(
                                  detailEntity.info.tagList[0],
                                  style: const TextStyle(
                                      fontSize: 20, color: Colors.red),
                                ),
                              ),
                              RotationTransition(
                                turns: Tween(begin: 0.0, end: 1.0)
                                    .animate(_animationController),
                                child: IconButton(
                                  icon: const Icon(Icons.arrow_upward),
                                  onPressed: () {
                                    setState(() {
                                      if (_expanded) {
                                        _animationController.reverse(from: 0.5);
                                      } else {
                                        _animationController.forward(from: 0.0);
                                      }
                                      _expanded = !_expanded;
                                      //翻转detailEntity.chapter数组
                                      detailEntity.chapter = detailEntity
                                          .chapter.reversed
                                          .toList();
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ))),
            SliverList(
                delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                print(index);
                return ListTile(
                  title: Text(detailEntity.chapter[index].title),
                  onTap: () {
                    print(detailEntity.chapter[index].htmlUrl);
                    // Navigator.pop(context);
                  },
                );
              },
              childCount: detailEntity.chapter.length,
            ))
          ]),
        ));
  }
}

List<Widget> _buildNewChapterWidget(
    List<DetailNewChapter> newChapterList, onTap) {
  List<Widget> newChapterWidgetList = [];
  for (var item in newChapterList) {
    newChapterWidgetList.add(InkWell(
      onTap: () => onTap(item.htmlUrl),
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

  return newChapterWidgetList;
}
