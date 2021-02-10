import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:note_flutter_app/AccountDB.dart';
import 'package:note_flutter_app/AddNote.dart';
import 'DetailNote.dart';
import 'dart:async';

class DustbinNote extends StatefulWidget {
  DustbinNote({Key key, this.title}) : super(key: key);
  final String title;

  @override
  DustbinNoteState createState() => DustbinNoteState();
}

class DustbinNoteState extends State<DustbinNote> with SingleTickerProviderStateMixin {

  StreamController _streamController = StreamController<List<Map>>();
  Timer _timer;

  Future getData() async {
    //Add your data to stream
    _streamController.add(dataListDelete);
  }

  _openAlertRecoverDialog(String _id,_title,_notebook,_position){
    showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          title: Text('还原'),
          content: Text('确定要还原吗'),
          actions: <Widget>[
            FlatButton(
              child: Text('确定'),
              onPressed: (){
                update(_id, 0, _title, _notebook, _position);
                Navigator.pop(context);
                Navigator.of(context).pop("");
              },
            ),
            FlatButton(
              child: Text('取消'),
              onPressed: (){Navigator.pop(context);},
            ),
          ],
        );
      },
    );
  }

  _openAlertForeverDeleteDialog(int _id){
    showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          title: Text('永久删除'),
          content: Text('确定要永久删除吗'),
          actions: <Widget>[
            FlatButton(
              child: Text('确定'),
              onPressed: (){
                deleteSingle(_id);
                Navigator.pop(context);
                Navigator.of(context).pop("");
              },
            ),
            FlatButton(
              child: Text('取消'),
              onPressed: (){Navigator.pop(context);},
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    initDB();
    getData();
    queryDeleteData();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) => getData());
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
          title: Text("回收站"),
        ),
        body: StreamBuilder(
          stream: _streamController.stream,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData)
              return ListView(
                children: snapshot.data.map<Widget>((document) {
                  return ListTile(
                    onTap: (){
                      _openAlertRecoverDialog(
                        document["id"].toString(),
                        document["title"],
                        document["notebook"],
                        document["position"],);
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
                    trailing: IconButton(
                        icon: Icon(Icons.delete_forever),
                      onPressed: (){_openAlertForeverDeleteDialog(document["id"]);},
                    ),
                  );
                }).toList(),
              );
            return Text('Loading...');
          },
        ),
      ),
    );
  }
}

