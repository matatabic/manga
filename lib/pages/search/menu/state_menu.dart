import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:manga/common/menu_widget.dart';
import 'package:manga/services/search_services.dart';

class StateMenu extends StatefulWidget {
  final Function(dynamic) loadData;
  final int stateIndex;

  const StateMenu({Key? key, required this.loadData, required this.stateIndex})
      : super(key: key);

  @override
  _StateMenuState createState() => _StateMenuState();
}

class _StateMenuState extends State<StateMenu> {
  late int _index;

  @override
  void initState() {
    super.initState();
    _index = widget.stateIndex;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        widget.loadData({"type": "state", "data": _index});
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
              widget.loadData({"type": "state", "data": _index});
              Navigator.pop(context);
            },
          ),
          title: Text(searchState.label),
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
                title: searchState.data[index].cnName,
                onTap: () {
                  setState(() {
                    _index = index;
                  });
                },
              ),
            );
          },
          itemCount: searchState.data.length,
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
