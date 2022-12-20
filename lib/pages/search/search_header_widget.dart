import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:manga/pages/search/search_engine_widget.dart';
import 'package:manga/pages/search/search_menu_widget.dart';

class SearchHeaderWidget extends StatefulWidget {
  final double topHeight;
  final Function(dynamic) loadData;
  final int regionIndex;
  final int stateIndex;
  final int typeIndex;
  final int filterIndex;

  const SearchHeaderWidget({
    Key? key,
    required this.topHeight,
    required this.loadData,
    required this.regionIndex,
    required this.stateIndex,
    required this.typeIndex,
    required this.filterIndex,
  }) : super(key: key);

  @override
  _SearchHeaderWidgetState createState() => _SearchHeaderWidgetState();
}

class _SearchHeaderWidgetState extends State<SearchHeaderWidget> {
  final focusNode = FocusNode();
  String _tempQuery = "";

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: false,
      floating: true,
      stretch: true,
      automaticallyImplyLeading: false,
      toolbarHeight: widget.topHeight,
      expandedHeight: widget.topHeight,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.all(0),
        title: Column(
          children: [
            SearchEngineWidget(
                focusNode: focusNode,
                onChangeQuery: (dynamic data) => _onChangeQuery(data),
                loadData: (dynamic data) => widget.loadData(data),
                query: _tempQuery),
            SearchMenuWidget(
                loadData: (dynamic data) => widget.loadData(data),
                regionIndex: widget.regionIndex,
                stateIndex: widget.stateIndex,
                typeIndex: widget.typeIndex,
                filterIndex: widget.filterIndex),
          ],
        ),
      ),
    );
  }

  void _onChangeQuery(String data) {
    setState(() {
      _tempQuery = data;
    });
  }
}
