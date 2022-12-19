import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:manga/common/menu_widget.dart';

class GenreMenu extends StatefulWidget {
  final Function(dynamic) loadData;
  final int genreIndex;

  const GenreMenu({Key? key, required this.loadData, required this.genreIndex})
      : super(key: key);

  @override
  _GenreMenuState createState() => _GenreMenuState();
}

class _GenreMenuState extends State<GenreMenu> {
  late int _index;

  @override
  void initState() {
    super.initState();
    _index = widget.genreIndex;
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
              widget.loadData({"type": "genre", "data": _index});
              Navigator.pop(context);
            },
          ),
          title: Text("23"),
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
                title: "2312",
                onTap: () {
                  setState(() {
                    _index = index;
                  });
                },
              ),
            );
          },
          itemCount: 6,
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
