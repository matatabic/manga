import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:manga/pages/search/menu/filter_menu.dart';
import 'package:manga/pages/search/menu/region_menu.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'menu/state_menu.dart';
import 'menu/type_menu.dart';

List _menuList = [
  {"id": 0, "icon": Icons.app_registration},
  {"id": 1, "icon": Icons.category},
  {"id": 2, "icon": Icons.type_specimen},
  {"id": 3, "icon": Icons.filter},
];

class SearchMenuWidget extends StatelessWidget {
  final Function(dynamic) loadData;
  final int regionIndex;
  final int stateIndex;
  final int typeIndex;
  final int filterIndex;

  const SearchMenuWidget({
    Key? key,
    required this.loadData,
    required this.regionIndex,
    required this.stateIndex,
    required this.typeIndex,
    required this.filterIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> dataList = [];

    for (var menu in _menuList) {
      dataList.add(Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: ClipOval(
          child: Material(
            color: getActive(this, menu['id']),
            child: InkWell(
              customBorder: const StadiumBorder(),
              onTap: () {
                showBarModalBottomSheet(
                    expand: true,
                    context: context,
                    backgroundColor: Colors.transparent,
                    builder: (context) {
                      return getMenuDetail(this, menu['id'], loadData);
                    });
              },
              child: SizedBox(
                height: 50,
                width: 50,
                child: Center(
                  child: Icon(
                    menu['icon'] as IconData,
                    color: Colors.white70,
                  ),
                ),
              ),
            ),
          ),
        ),
      ));
    }
    return CupertinoScaffold(
        body: Flex(
      direction: Axis.horizontal,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: dataList,
    ));
  }
}

Color getActive(that, index) {
  switch (index) {
    case 0:
      return that.regionIndex > 0
          ? Colors.orangeAccent
          : const Color.fromRGBO(51, 51, 51, 1);
    case 1:
      return that.stateIndex > 0
          ? Colors.orangeAccent
          : const Color.fromRGBO(51, 51, 51, 1);
    case 2:
      return that.typeIndex > 0
          ? Colors.orangeAccent
          : const Color.fromRGBO(51, 51, 51, 1);
    case 3:
      return that.filterIndex > 0
          ? Colors.orangeAccent
          : const Color.fromRGBO(51, 51, 51, 1);
  }
  return const Color.fromRGBO(51, 51, 51, 1);
}

Widget getMenuDetail(that, index, loadData) {
  switch (index) {
    case 0:
      return RegionMenu(
        loadData: loadData,
        regionIndex: that.genreIndex,
      );
    case 1:
      return StateMenu(
        loadData: loadData,
        stateIndex: that.genreIndex,
      );
    case 2:
      return TypeMenu(loadData: loadData, brandList: []);
    case 3:
      return FilterMenu(
        loadData: loadData,
        brandList: that.brandList,
      );
    default:
      return Container();
  }
}
