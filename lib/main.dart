import 'package:flutter/material.dart';
import 'package:note_flutter_app/AccountDB.dart';
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

  StreamController _streamController = StreamController<List<Map>>();
  Timer _timer;

  Future getData() async {
    //Add your data to stream
    _streamController.add(dataList);
  }

  @override
  void initState() {
    super.initState();
    initDB();
    getData();
    queryData();
    _timer = Timer.periodic(Duration(seconds: 2), (timer) => getData());
   // queryData();
  }
  //初始化

  @override
  void dispose() {
    //controller.dispose();
    if (_timer.isActive) _timer.cancel();
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
        body: StreamBuilder(
          stream: _streamController.stream,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData)
              return ListView(
                children: snapshot.data.map<Widget>((document) {
                  return ListTile(
                    title: Text(document['title']),
                    subtitle: Text(document['title']),
                  );
                }).toList(),
              );
            return Text('Loading...');
          },
        ),
        drawer: DrawerDemo(),
      ),
    );
  }
}
