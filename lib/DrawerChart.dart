import 'package:flutter/material.dart';
import 'AccountDB.dart';
import 'Constants.dart';

//抽屉部分，主要功能待定
class DrawerDemo extends StatefulWidget {
  DrawerDemo({Key key}) : super(key: key);
  @override
  DrawerDemoState createState() => DrawerDemoState();
}

class DrawerDemoState extends State<DrawerDemo> {
  _openMessageDialog(){
    showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
           title: Text("关于"),
          content: Text("咱也没啥好说的好像XD"),
          elevation: 9.0,
          actions: <Widget>[
            FlatButton(
              child: Text('确定'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      }
    );
  }
  _openAlertDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          if (dataList.isEmpty) {
            return AlertDialog(
              title: Text('账目已为空'),
              actions: <Widget>[
                FlatButton(
                  child: Text('确定'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          } else {
            return AlertDialog(
              title: Text('删除所有账目'),
              content: Text('确定要删除所有账目吗'),
              actions: <Widget>[
                FlatButton(
                  child: Text('确定'),
                  onPressed: () {
                    delete();
                    Navigator.pop(context);
                    Navigator.of(context).pop("");
                  },
                ),
                FlatButton(
                  child: Text('取消'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          }
        }
    );
  }
  // _openColorChangeDialog(){
  //   showDialog(
  //       context: (context),
  //       builder: (BuildContext context){
  //         return SimpleDialog(
  //           title: Text('选择颜色主题'),
  //           children: <Widget>[
  //             SimpleDialogOption(
  //               child: Text("紫色"),
  //               onPressed: (){
  //                 changeColorPurple();
  //                 Navigator.pop(context);
  //               },
  //             ),
  //             SimpleDialogOption(
  //               child: Text("蓝色"),
  //               onPressed: (){
  //                 changeColorBlue();
  //                 Navigator.pop(context);
  //               },
  //             ),
  //           ],
  //         );
  //       }
  //   );
  // }
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            //arrowColor: ,
            accountName: Text("Howell", style: TextStyle(fontWeight: FontWeight.bold),),
            accountEmail: Text("12341234@gmail.com",),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage("https://i.loli.net/2020/11/28/nCN5pGMgL43dtaV.jpg"),
            ),
            decoration: BoxDecoration(
                color: Colors.blue,
                image: DecorationImage(
                  image: NetworkImage("https://i.loli.net/2020/11/28/6iQFU9mkgMdTJZo.jpg"),
                  fit: BoxFit.cover,
                  //colorFilter: ColorFilter.mode(Colors.yellow.withOpacity(0.5), BlendMode.hardLight),
                )
            ),
          ),
          ListTile(
            title: Text(
              "信息",
              textAlign: TextAlign.left,
            ),
            leading:
            Icon(Icons.message, color: Colors.black26, size: 20.0),
            onTap: ()=> _openMessageDialog(),
          ),
          ListTile(
            title: Text(
              "删库跑路",
              textAlign: TextAlign.left,
            ),
            leading:Icon(Icons.delete_forever, color: Colors.black26, size: 20.0,),
            onTap: ()=> _openAlertDialog(),
          ),
          ListTile(
            title: Text(
              "返回",
              textAlign: TextAlign.left,
            ),
            leading: Icon(Icons.arrow_back, color: Colors.black26, size: 20.0),
            onTap: ()=> Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}