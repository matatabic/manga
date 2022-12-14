import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:manga/services/home_services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: ButtonTheme(
          minWidth: 200,
          height: 50,
          child: ElevatedButton(
            onPressed: () {
              loadData();
            },
            child: const Text('Button'),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  loadData() async {
    await HomeServices.getData();
  }
}
