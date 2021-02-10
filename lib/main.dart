import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:note_flutter_app/AccountDB.dart';
import 'package:note_flutter_app/AddNote.dart';
import 'DetailNote.dart';
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
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => AddNote()
            ));
          },
        ),
        body: StreamBuilder(
          stream: _streamController.stream,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData)
              return ListView(
                children: snapshot.data.map<Widget>((document) {
                  return ListTile(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => NoteDetail(
                              document["id"].toString(),
                              document["type"],
                              document["title"],
                              document["notebook"],
                              document["position"],
                              document["time_create"],
                              document["time_modify"]
                          )
                      ));
                    },
                    title: Text(
                      document['title'],
                      style: TextStyle(
                        fontSize: 33.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    subtitle: Text("最近修改"+document['time_modify']+"\n创建时间"+document['time_create'],style: TextStyle(
                      fontSize: 9.0,),),
                    trailing: Icon(Icons.more_horiz),
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
