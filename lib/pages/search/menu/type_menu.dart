import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:manga/entity/search_entity.dart';
import 'package:manga/services/search_services.dart';

class TypeMenu extends StatelessWidget {
  final Function(dynamic) loadData;
  final List<String> brandList;

  const TypeMenu({Key? key, required this.loadData, required this.brandList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('BrandMenu build');
    List<Widget> tagWidgetList = [];
    for (SearchTypeData item in searchType.data) {
      tagWidgetList.add(BrandDetail(
          brandList: brandList,
          title: item.cnName,
          active: brandList.contains(item.enName)));
    }
    return WillPopScope(
      onWillPop: () async {
        loadData({});
        return true;
      },
      child: Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Theme.of(context).primaryColor,
            leading: IconButton(
              icon: const Icon(Icons.close_rounded),
              onPressed: () {
                loadData({});
                Navigator.pop(context);
              },
            ),
            title: Text(searchType.label),
          ),
          body: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: SingleChildScrollView(
                padding: const EdgeInsets.only(top: 10),
                physics: const ClampingScrollPhysics(),
                child: Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: tagWidgetList,
                )),
          )),
    );
  }
}

// search.brandList.indexOf(title) > -1
class BrandDetail extends StatefulWidget {
  final List<String> brandList;
  final String title;
  final bool active;

  const BrandDetail(
      {Key? key,
      required this.brandList,
      required this.title,
      required this.active})
      : super(key: key);

  @override
  State<BrandDetail> createState() => _BrandDetailState();
}

class _BrandDetailState extends State<BrandDetail> {
  bool _active = false;

  @override
  initState() {
    super.initState();
    _active = widget.active;
  }

  void _onPressHandler() {
    setState(() {
      _active = !_active;
    });
    if (_active) {
      widget.brandList.add(widget.title);
    } else {
      widget.brandList.remove(widget.title);
    }
    print('_brandList: $widget.brandList');
  }

  @override
  Widget build(BuildContext context) {
    print("_BrandDetailState build");
    return Material(
      borderRadius: const BorderRadius.all(
        Radius.circular(7),
      ),
      color: _active ? Theme.of(context).primaryColor : Colors.black,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(7),
            ),
            border: Border.all(
              color: Colors.grey, //边框颜色
              width: 2.5, //边框粗细
            )),
        child: InkWell(
            onTap: () {
              _onPressHandler();
            },
            child: Container(
              padding: const EdgeInsets.all(5),
              child: Text(
                widget.title,
                style: const TextStyle(fontSize: 17),
              ),
            )),
      ),
    );
  }
}
