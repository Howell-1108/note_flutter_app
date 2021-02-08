import 'package:flutter/material.dart';
import 'AccountDB.dart';
import 'ListViewStateful.dart';
import 'Constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AccountPage extends StatefulWidget{
  AccountPage({Key key}) : super(key: key);
  @override
  AccountPageState createState() => AccountPageState();
}

class AccountPageState extends State<AccountPage> {
  bool flagType=false,flagTime=false, flagMoney=false;
  void changeType(){
    flagType=!flagType;
    if(flagType==true){
      queryOrderByTypePositive();
    }else queryOrderByTypeNegative();
  }
  void changeTime(){
    flagTime=!flagTime;
    if(flagTime==true){
      queryOrderByTimePositive();
    }else queryOrderByTimeNegative();
  }
  void changeMoney(){
    flagMoney=!flagMoney;
    if(flagMoney==true){
      queryOrderByMoneyPositive();
    }else queryOrderByMoneyNegative();
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(

              height: 55.0,
              margin: EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  RaisedButton.icon(
                      icon: Icon(Icons.sort),
                      label: Text('类型'),
                      color: colorBars,
                      textColor: Colors.white,
                      onPressed: () {
                        print("排序：类型");
                        changeType();
                        setState(() {});
                      }),
                  RaisedButton.icon(
                      icon: Icon(Icons.access_time),
                      label: Text('时间'),
                      color: colorBars,
                      textColor: Colors.white,
                      onPressed: () {
                        print("排序：时间");
                        changeTime();
                        setState(() {});
                      }),
                  RaisedButton.icon(
                      icon: Icon(Icons.payment),
                      label: Text('金额'),
                      color: colorBars,
                      textColor: Colors.white,
                      onPressed: () {
                        print("排序：金额");
                        changeMoney();
                        setState(() {});
                      }),
                ],
              )
          ),
          ListViewAccount(),
        ],
      ),
    );
  }
}
// class AccountListPageDemo extends StatelessWidget{
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child:  Column(
//         children: <Widget>[
//           Container(
//             child:OrderSelectBarDemo(),
//           ),
//           Container(
//             child: ListViewAccount(),
//           ),
//         ],
//       ),
//     );
//   }
// }