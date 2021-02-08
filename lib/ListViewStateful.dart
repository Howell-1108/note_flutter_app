import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './ListDetail.dart';
import 'AccountDB.dart';
import 'dart:async';
import 'Constants.dart';
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';

const ms = const Duration(milliseconds: 200);
Timer _timer;

class ListViewAccount extends StatefulWidget {
  ListViewAccount({Key key}) : super(key: key);
  @override
  ListViewAccountState createState() => ListViewAccountState();
}

class ListViewAccountState extends State<ListViewAccount> {

  jumpToDetail(int index){
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => AccountDetail(
            dataList[index]["type"].toString(),
            dataList[index]["name"],
            dataList[index]["moneyValue"].toString(),
            dataList[index]["time"],
            dataList[index]["description"],
            dataList[index]["id"].toString())
    ))
    //     .then((value){
    //   Future.delayed(Duration(milliseconds: 500), () {
    //     setState(() {});
    //     },
    //   );
    // })
    ;
  }
  Widget _listItemBuilder(BuildContext context, int index) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
              color: colorList,
              margin: EdgeInsets.all(8.0),
              child: StatefulBuilder(
                builder: (BuildContext context, void Function(void Function()) setState){
                  return Stack(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text('           '),
                          if (dataList[index]["type"].toString() == "0")
                            Icon(Icons.restaurant),
                          if (dataList[index]["type"].toString() == "1")
                            Icon(Icons.gamepad),
                          if (dataList[index]["type"].toString() == "2")
                            Icon(Icons.directions_car),
                          if (dataList[index]["type"].toString() == "3")
                            Icon(Icons.devices_other),
                          Text('         '),
                          Text(
                            dataList[index]["time"],
                            style: TextStyle(
                              fontSize: 14.0,
                            ),
                          ),
                          Text('   ¥'),
                          //Icon(FontAwesomeIcons.),
                          Text(dataList[index]["moneyValue"].toString()),
                          Text(
                            "    " + dataList[index]["name"],
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                      Positioned.fill(
                          child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                splashColor: Colors.white.withOpacity(0.3),
                                highlightColor: Colors.white.withOpacity(0.1),
                                onTap: () {
                                  jumpToDetail(index);
                                },
                              )))
                    ],
                  );
                },
              )
          )
        ],
      ),
    );
  }
  @override
  void initState(){
    super.initState();
    Timer.periodic(ms, (_timer) {
      //print('定时任务时间：${DateTime.now().toString()}');
      //刷新页面
      if(this.mounted){
        setState(() {});
      }
    });
  }
  // void dispose() {
  //   // 组件销毁时判断Timer是否仍然处于激活状态，是则取消
  //   if(_timer.isActive){
  //     _timer.cancel();
  //   }
  //   super.dispose();
  // }
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: dataList.length,
      itemBuilder: _listItemBuilder,
      shrinkWrap: true,
      physics: new NeverScrollableScrollPhysics(),
    );
  }
}
