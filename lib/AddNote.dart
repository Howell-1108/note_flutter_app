import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'AccountDB.dart';

class AddNote extends StatefulWidget {
  @override
  FormDemoState createState() => FormDemoState();
}

class FormDemoState extends State<AddNote> {

  final registerFormKey = GlobalKey<FormState>();
  bool autoValidDateBool = false;
  String _title, _notebook, _position="positionpositionposition";

  void submitNotebook() {
    if(registerFormKey.currentState.validate()) {
          registerFormKey.currentState.save();
          //queryData();
          insertData(0, _title, _notebook, _position);
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
                  //Navigator.of(context).pop("");
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
      body:SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Form(
                key: registerFormKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      initialValue: "test标题",
                      style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.w400),
                      decoration: InputDecoration(
                        //helperText: "标题",
                      ),
                      onSaved: (value) {
                        _title = value;
                      },
                      validator: validateTitle,
                      autovalidate: autoValidDateBool,
                    ),
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
                                  initialValue: "test yeah",
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: '点按即可输入文本',
                                  ),
                                  onSaved: (value) {
                                    _notebook = value;
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
