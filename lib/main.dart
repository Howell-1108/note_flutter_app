import 'package:flutter/material.dart';
import 'package:note_flutter_app/AddNote.dart';
import 'DrawerChart.dart';
import 'dart:async';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Notebook',
      home: MyHomePage(title: 'Notebook home page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {

  @override
  void initState() {
    super.initState();
  }
  //初始化

  @override
  void dispose() {
    //controller.dispose();
    super.dispose();
  }
  //关流

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Notebook"),
        ),
        body: AddNote(),
        drawer: DrawerDemo(),
      ),
    );
  }


}
