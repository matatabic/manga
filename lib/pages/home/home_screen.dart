import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:manga/entity/home_entity.dart';
import 'package:manga/pages/home/catalog_widget.dart';
import 'package:manga/pages/home/home_header_screen.dart';
import 'package:manga/services/home_services.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  bool get wantKeepAlive => true;

  var _futureBuilderFuture;
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  final Interval _opacityCurve =
      const Interval(0.0, 1, curve: Curves.fastOutSlowIn);

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
                _futureBuilderFuture = loadData();
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
    HomeEntity homeEntity = snapshot.data;
    // print(homeEntity.content.length);
    return NotificationListener<ScrollNotification>(
        child: SmartRefresher(
      enablePullDown: true,
      onRefresh: _onRefresh,
      header: const WaterDropMaterialHeader(),
      controller: _refreshController,
      child: CustomScrollView(semanticChildCount: 2, slivers: <Widget>[
        SliverToBoxAdapter(
            child: HomeHeaderScreen(swiperList: homeEntity.swiper)),
        SliverList(
            delegate:
                SliverChildBuilderDelegate((BuildContext context, int index) {
          return CatalogWidget(
            homeCatalog: homeEntity.catalog[index],
            opacityCurve: _opacityCurve,
          );
        }, childCount: 9)),
        // 当列表项高度固定时，使用 SliverFixedExtendList 比 SliverList 具有更高的性能
      ]),
    ));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _futureBuilderFuture = loadData();
  }

  void _onRefresh() async {
    setState(() {
      _futureBuilderFuture = loadData();
    });
  }

  Future loadData() async {
    HomeEntity homeEntity = await HomeServices.getData();

    return homeEntity;
  }
}
