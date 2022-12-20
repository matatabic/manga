import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:manga/common/hero_slide_page.dart';
import 'package:manga/common/widget/anime3_card.dart';
import 'package:manga/entity/search_entity.dart';
import 'package:manga/pages/search/search_header_widget.dart';
import 'package:manga/services/search_services.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  Interval opacityCurve = const Interval(0.0, 1, curve: Curves.fastOutSlowIn);

  var _futureBuilderFuture;
  int _page = 1;
  bool hasMore = true;
  final List<SearchComics> _searchList = [];

  String _htmlUrl = "";

  String _query = "";
  int _regionIndex = 0;
  int _stateIndex = 0;
  int _typeIndex = 0;
  int _filterIndex = 0;

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  final double _topHeight = MediaQueryData.fromWindow(window).padding.top + 82;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
          backgroundColor: Colors.black,
          body: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              FocusManager.instance.rootScope.requestFocus(FocusNode());
            },
            child: SmartRefresher(
              // physics: const ClampingScrollPhysics(),
              enablePullDown: false,
              enablePullUp: true,
              controller: _refreshController,
              onLoading: () => _onLoading({}, true),
              footer: CustomFooter(
                builder: (BuildContext context, LoadStatus? mode) {
                  Widget body;
                  if (mode == LoadStatus.loading) {
                    body = const CupertinoActivityIndicator();
                  } else if (mode == LoadStatus.failed) {
                    body = const Text("加载失败！点击重试！");
                  } else if (mode == LoadStatus.canLoading) {
                    body = const Text("松手,加载更多!");
                  } else if (mode == LoadStatus.noMore) {
                    body = const Text("没有更多数据了!");
                  } else {
                    body = const Text("没有更多数据了!");
                  }
                  return SizedBox(
                    height: 55.0,
                    child: Center(child: body),
                  );
                },
              ),
              child: CustomScrollView(
                slivers: <Widget>[
                  SearchHeaderWidget(
                    loadData: (dynamic data) => _onLoading(data, false),
                    topHeight: _topHeight,
                    regionIndex: _regionIndex,
                    stateIndex: _stateIndex,
                    typeIndex: _typeIndex,
                    filterIndex: _filterIndex,
                  ),
                  const SliverPadding(
                    padding: EdgeInsets.only(top: 10),
                  ),
                  FutureBuilder(
                    builder: _buildFuture,
                    future:
                        _futureBuilderFuture, // 用户定义的需要异步执行的代码，类型为Future<String>或者null的变量或函数
                  ),
                  const SliverPadding(
                    padding: EdgeInsets.only(bottom: 10),
                  ),
                ],
              ),
            ),
          )),
    );
  }

  Widget _buildFuture(BuildContext context, AsyncSnapshot snapshot) {
    print("_buildFuture");
    double surHeight = MediaQuery.of(context).size.height -
        _topHeight -
        MediaQueryData.fromWindow(window).padding.top -
        40 -
        kBottomNavigationBarHeight;

    switch (snapshot.connectionState) {
      case ConnectionState.none:
        print('还没有开始网络请求');
        return const Text('还没有开始网络请求');
      case ConnectionState.active:
        print('active');
        return const Text('ConnectionState.active');
      case ConnectionState.waiting:
        print('waiting');
        return SliverToBoxAdapter(
          child: SizedBox(
            height: surHeight,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      case ConnectionState.done:
        print('done');
        if (snapshot.hasError) {
          return SliverToBoxAdapter(
            child: SizedBox(
              height: surHeight,
              child: Center(
                  child: MaterialButton(
                color: Colors.blue,
                textColor: Colors.white,
                child: const Text('网络异常,点击重新加载'),
                onPressed: () {
                  setState(() {
                    _futureBuilderFuture = loadData(_jointHtml());
                  });
                },
              )),
            ),
          );
          // return Text('Error: ${snapshot.error}');
        } else {
          return _createWidget(context, snapshot);
        }
    }
  }

  Widget _createWidget(BuildContext context, AsyncSnapshot snapshot) {
    print("_createWidget");
    List<SearchComics> searchComics = snapshot.data;

    return SliverGrid(
      //调整间距
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          //横轴元素个数
          crossAxisCount: 3,
          //纵轴间距
          mainAxisSpacing: 5.0,
          //横轴间距
          crossAxisSpacing: 5.0,
          //子组件宽高长度比例
          childAspectRatio: 2 / 3),
      //加载内容
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          String heroTag = UniqueKey().toString();
          return Anime3Card(
              onTap: () {},
              onLongPress: () {
                Navigator.of(context).push(PageRouteBuilder(
                    opaque: false,
                    pageBuilder: (context, animation, secondaryAnimation) {
                      return AnimatedBuilder(
                        animation: animation,
                        builder: (context, child) {
                          return Opacity(
                            opacity: opacityCurve.transform(animation.value),
                            child: HeroSlidePage(
                                heroTag: heroTag,
                                url: searchComics[index].imgUrl),
                          );
                        },
                      );
                    }));
              },
              heroTag: heroTag,
              title: searchComics[index].title,
              imgUrl: searchComics[index].imgUrl);
        },
        childCount: searchComics.length, //设置个数
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _futureBuilderFuture = loadData(_jointHtml());
  }

  void initTagListAndCustomTagList() {
    List tempList = [];

    // for (var item in searchTag.data) {
    //   tempList.addAll(item.data);
    // }
    //
    // for (var item in widget.tagList) {
    //   _tagList.add(item);
    //   if (!tempList.contains(item)) {
    //     _customTagList.add(item);
    //   }
    // }
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _onLoading(dynamic data, bool loadMore) async {
    print("_onLoading");
    print(data);
    _saveData(data);
    String newHtml = _jointHtml();
    print(_htmlUrl);
    print(newHtml);
    if (loadMore) {
      if (hasMore) {
        //获取下一页数据
        print("获取下一页数据");
        _page = _page + 1;
        String tempHtml = "$newHtml&page=$_page";
        await loadData(tempHtml);
        setState(() {});
        _refreshController.loadComplete();
      } else {
        //已经没有更多数据
        print("已经没有更多数据");
        _refreshController.loadNoData();
      }
    } else {
      //获取新的数据，相同的url就不执行
      print("获取新的数据，相同的url就不执行");
      if (newHtml != _htmlUrl) {
        _page = 1;
        // _searchVideoList = [];
        setState(() {
          _futureBuilderFuture = loadData(newHtml);
        });
        _refreshController.loadComplete();
      }
    }
  }

  void _saveData(dynamic data) {
    print("_saveData: $data");
    switch (data['type']) {
      case "query":
        _query = data['data'];
        break;
      case "region":
        _regionIndex = data['data'];
        break;
      case "state":
        _stateIndex = data['data'];
        break;
      case "type":
        _typeIndex = data['data'];
        break;
      case "filter":
        _filterIndex = data['data'];
        break;
    }
  }

  String _jointHtml() {
    String newHtml = "https://tw.baozimh.com/classify";
    if (_regionIndex != 0) {
      newHtml = "$newHtml&region=${searchRegion.data[_regionIndex].enName}";
    }
    if (_stateIndex != 0) {
      newHtml = "$newHtml&state=${searchState.data[_stateIndex].enName}";
    }
    if (_typeIndex != 0) {
      newHtml = "$newHtml&type=${searchType.data[_typeIndex].enName}";
    }
    if (_filterIndex != 0) {
      newHtml = "$newHtml&filter=${searchFilter.data[_filterIndex]}";
    }

    return newHtml;
  }

  Future loadData(url) async {
    print("请求数据");
    SearchEntity searchEntity = await SearchServices.getData();
    _htmlUrl = url;
    if (searchEntity.comics.length == 36) {
      hasMore = true;
    } else {
      hasMore = false;
    }

    return searchEntity.comics;
    // SearchEntity searchEntity = data;
    // _htmlUrl = url;
    // _commendCount = searchEntity.commendCount;
    // _totalPage = searchEntity.page;
    _searchList.addAll(searchEntity.comics);

    // return _searchVideoList;
  }
}
