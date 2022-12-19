import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:manga/common/menu_widget.dart';

class DurationMenu extends StatefulWidget {
  final Function(dynamic) loadData;
  final int durationIndex;

  const DurationMenu(
      {Key? key, required this.loadData, required this.durationIndex})
      : super(key: key);

  @override
  State<DurationMenu> createState() => _DurationMenuState();
}

class _DurationMenuState extends State<DurationMenu> {
  late int _index;

  @override
  void initState() {
    super.initState();
    _index = widget.durationIndex;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        widget.loadData({"type": "duration", "data": _index});
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
                widget.loadData({"type": "duration", "data": _index});
                Navigator.pop(context);
              },
            ),
            title: Text("23"),
          ),
          body: ListView.separated(
            padding: const EdgeInsets.only(top: 10),
            itemBuilder: (BuildContext context, int index) {
              return Material(
                color: index == _index
                    ? Theme.of(context).primaryColor
                    : Colors.black,
                child: MenuWidget(
                  title: "123",
                  onTap: () {
                    setState(() {
                      _index = index;
                    });
                  },
                ),
              );
            },
            itemCount: 5,
            separatorBuilder: (BuildContext context, int index) {
              return Container(
                height: 2.5,
                color: Colors.white30,
              );
            },
          )),
    );
  }
}
