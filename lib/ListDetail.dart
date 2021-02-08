import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'AccountDB.dart';
import 'AccountModify.dart';
import 'Constants.dart';

String idCurrent;

class AccountDetail extends StatefulWidget {
  final String name;
  final String type;
  final String moneyValue;
  final String time;
  final String description;
  final String id;

  @override
  AccountDetail(this.type, this.name, this.moneyValue, this.time,
      this.description, this.id);
  AccountDetailState createState() => AccountDetailState(
      type: type,
      name: name,
      moneyValue: moneyValue,
      time: time,
      description: description,
      id: id);
}

//点击ListView元素后进入的详情页面
class AccountDetailState extends State<AccountDetail> {

  handleDelete(String id) {
    print("删除了第$id号项目");
    int IntId = int.parse(id);
    deleteSingle(IntId);
  }

  _openAlertDialog(){
    showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text('删除账目'),
            content: Text('确定要删除这条账目吗'),
            actions: <Widget>[
              FlatButton(
                child: Text('确定'),
                onPressed: (){handleDelete(id);Navigator.pop(context);Navigator.of(context).pop("");},
              ),
              FlatButton(
                child: Text('取消'),
                onPressed: (){Navigator.pop(context);},
              ),
            ],
          );
    }
    );
  }
  final String type, name, moneyValue, time, description, id;
  AccountDetailState(
      {@required this.type,
      this.name,
      this.moneyValue,
      this.time,
      this.description,
      this.id});

  void changeSingleAccountDB(String id) {
    idCurrent = id;
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
        backgroundColor: colorBackground,
        appBar: AppBar(
          title: Text("账目细则"),
          elevation: 0.0,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.delete),
              tooltip: "删除",
              onPressed: () { _openAlertDialog();}
            ),
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Text(
                //   "账目名：",
                //   style: TextStyle(
                //     fontSize: 40.0,
                //     fontWeight: FontWeight.w800,
                //   ),
                // ),
                Text(
                  name,
                  style: TextStyle(
                      fontSize: 40.0,
                      fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                if (type == '0') Icon(Icons.fastfood),
                if (type == '1') Icon(Icons.gamepad),
                if (type == '2') Icon(Icons.directions_car),
                if (type == '3') Icon(Icons.whatshot),
                if (type == '0') Text("饮食类"),
                if (type == '1') Text("玩乐类"),
                if (type == '2') Text("出行类"),
                if (type == '3') Text("其它类"),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "创建时间：",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Text(
                  time,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 64.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  moneyValue+'元',
                  style: TextStyle(
                    fontSize: 45.0,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 33.0,
            ),
            Container(
              width: 300.0,
              height: 300.0,
              margin: EdgeInsets.all(8.0),
              color: colorBars,
              child:Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "   "+description,
                  maxLines: 9,
                  style: TextStyle(
                    fontSize: 15.0,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 33.0,
            ),
            RaisedButton.icon(
                icon: Icon(Icons.settings),
                label: Text('修改'),
                color: Theme.of(context).accentColor,
                textColor: Colors.white,
                // onPressed: null,
                onPressed: () {
                  idCurrent = id;
                  print("修改数据");
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => AccountModifyPage(id: id,name: name,type: type, moneyValue: moneyValue, description: description,time: time,)));
                  setState(() {});
                }),
          ],
        ));
  }
}
