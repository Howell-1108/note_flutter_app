import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'AccountDB.dart';

class NoteDetail extends StatefulWidget {
  String _title, _notebook, _position, _time_Create, _time_Modify,_id;
  int _type;

  @override
  NoteDetail(this._id, this._type,this._title,this._notebook, this._position,this._time_Create,this._time_Modify);
  NoteDetailState createState() => NoteDetailState(
    id:_id,
    type:_type,
    title: _title,
    notebook: _notebook,
    position: _position,
    time_Create: _time_Create,
    time_Modify: _time_Modify,
  );
}

class NoteDetailState extends State<NoteDetail> {

  final registerFormKey = GlobalKey<FormState>();
  bool autoValidDateBool = false;
  String title, notebook, position, time_Create, time_Modify,id;
  int type;

  NoteDetailState({
    @required this.id,this.type,this.title,this.notebook,this.position,this.time_Create,this.time_Modify
});

  void submitNotebook() {
    if(registerFormKey.currentState.validate()) {
      registerFormKey.currentState.save();
      //queryData();
      update(id, type, title, notebook, position);
    }
    else
    {
      setState(() {
        autoValidDateBool = true;
      });
    }
  }

  _openAlertDialog(){
    showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          title: Text('保存'),
          content: Text('确定要保存吗'),
          actions: <Widget>[
            FlatButton(
              child: Text('确定'),
              onPressed: (){
                submitNotebook();
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

  _openAlertDeleteDialog(){
    showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          title: Text('删除'),
          content: Text('确定要删除吗'),
          actions: <Widget>[
            FlatButton(
              child: Text('确定'),
              onPressed: (){
                update(id, 1, title, notebook, position);
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

  String validateTitle(value) {
    if (value.isEmpty) {
      return "请键入标题";
    } else
      return null;
  }

  String validateNotebook(value) {
    if (value.isEmpty) {
      return "请键入内容";
    } else
      return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notebook"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.done),
            tooltip: "保存",
            onPressed: (){_openAlertDialog();},
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.delete),
        onPressed: (){
          _openAlertDeleteDialog();
        },
      ),
      body:SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Form(
                key: registerFormKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    TextFormField(
                      initialValue: title,
                      style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.w400),
                      decoration: InputDecoration(
                        //helperText: "标题",
                      ),
                      onSaved: (value) {
                        title = value;
                      },
                      validator: validateTitle,
                      autovalidate: autoValidDateBool,
                    ),
                    Text("最近修改"+time_Modify+"\n创建时间"+time_Create,style: TextStyle(
                      fontSize: 9.0,),),
                    SizedBox(
                      height: 14.0,
                    ),
                    Card(
                      margin: EdgeInsets.all(0.0),
                      child: Container(
                        height: 500.0,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                height: MediaQuery.of(context).size.height,
                                padding: EdgeInsets.only(
                                  left: 18.0,
                                  right: 18.0,
                                  bottom: 20.0,
                                  top: 2.0,
                                ),
                                child: TextFormField(
                                  initialValue: notebook,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: '点按即可输入文本',
                                  ),
                                  onSaved: (value) {
                                    notebook = value;
                                  },
                                  validator: validateNotebook,
                                  autovalidate: autoValidDateBool,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15.0,
                                  ),
                                  maxLines: 999,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
