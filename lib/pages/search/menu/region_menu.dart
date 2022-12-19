import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:manga/common/menu_widget.dart';
import 'package:manga/services/search_services.dart';

class RegionMenu extends StatefulWidget {
  final Function(dynamic) loadData;
  final int regionIndex;

  const RegionMenu(
      {Key? key, required this.loadData, required this.regionIndex})
      : super(key: key);

  @override
  _RegionMenuState createState() => _RegionMenuState();
}

class _RegionMenuState extends State<RegionMenu> {
  late int _index;

  @override
  void initState() {
    super.initState();
    _index = widget.regionIndex;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        widget.loadData({"type": "genre", "data": _index});
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
              widget.loadData({"type": "region", "data": _index});
              Navigator.pop(context);
            },
          ),
          title: Text(searchRegion.label),
        ),
        body: ListView.separated(
          padding: const EdgeInsets.only(top: 10),
          physics: const ClampingScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            return Material(
              color: index == _index
                  ? Theme.of(context).primaryColor
                  : Colors.black,
              child: MenuWidget(
                title: searchRegion.data[index].cnName,
                onTap: () {
                  setState(() {
                    _index = index;
                  });
                },
              ),
            );
          },
          itemCount: searchRegion.data.length,
          separatorBuilder: (BuildContext context, int index) {
            return Container(
              height: 2.5,
              color: Colors.white30,
            );
          },
        ),
      ),
    );
  }
}
