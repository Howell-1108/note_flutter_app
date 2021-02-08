import 'package:flutter/material.dart';
import 'AccountDB.dart';
import 'dart:async';
import 'Constants.dart';

Timer _timerSummary;
const ms = const Duration(milliseconds: 200);
class SummaryPage extends StatefulWidget{
  SummaryPage({Key key}) : super(key: key);
  @override
  SummaryPageState createState() => SummaryPageState();
}

class SummaryPageState extends State<SummaryPage> {
  @override
  void initState(){
    super.initState();
    querygroupby();
    Timer.periodic(ms, (_timerSummary) {
      //print('定时任务时间：${DateTime.now().toString()}');
      //刷新页面
      if(this.mounted){
        setState(() {});
      }
    });
  }
  String textShower(int x){
    String S= dataGroupList[x]['SUM(moneyValue)'].toString();
    if(S.contains('.'))
    {
      int _pointIndex=S.indexOf('.');
      String A=S.substring(0,_pointIndex);
      String B='';
      if(S.length-_pointIndex>2){
        B=A+'.'+S.substring(_pointIndex+1,_pointIndex+3);
      }else
      {
        B=A+'.'+S.substring(_pointIndex+1,S.length);
      }
      S=B;
    }else{
      if(S.length>6){
        S=S.substring(0,S.length-1);
      }
    }
    return S;

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBackground,
      appBar: AppBar(
        title: Text("统计"),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: 10.0),
            Row(
              children: <Widget>[
                Icon(Icons.restaurant),
                Text(
                    "   饮食类    总支出：",
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
                Text(
                    textShower(0),
                    style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            Row(
              children: <Widget>[
                Icon(Icons.gamepad),
                Text(
                    "   玩乐类    总支出：",
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
                Text(textShower(1),
                  style: TextStyle(
                    fontSize: 20.0,
                  ),),
              ],
            ),
            SizedBox(height: 10.0),
            Row(
              children: <Widget>[
                Icon(Icons.directions_car),
                Text(
                    "   出行类    总支出：",
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
                Text(textShower(2),
                  style: TextStyle(
                    fontSize: 20.0,
                  ),),
              ],
            ),
            SizedBox(height: 10.0),
            Row(
              children: <Widget>[
                Icon(Icons.devices_other),
                Text(
                    "   其它类    总支出：",
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
                Text(textShower(3),
                  style: TextStyle(
                  fontSize: 20.0,
                ),),
              ],
            ),
          ],
        ),
      ),
    );
  }
}