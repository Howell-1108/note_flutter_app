import 'package:decimal/decimal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'AccountDB.dart';
import 'NumberInputControl.dart';
import 'Constants.dart';

class AccountForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBackground,
      body: Theme(
        data: Theme.of(context).copyWith(
          primaryColor: Colors.black,
        ),
       child: SingleChildScrollView(
         child: Container(
           padding: EdgeInsets.all(16.0),
           child: Column(
             mainAxisAlignment: MainAxisAlignment.center,
             children: <Widget>[
               Text(
                 "添加账目",
                 style: TextStyle(
                   fontSize: 30.0,
                   fontWeight: FontWeight.w200,
                 ),
               ),
               AccountFormDemo(),
             ],
           ),
         ),
       ),
      ),
    );
  }
}

class AccountFormDemo extends StatefulWidget {
  @override
  AccountFormDemoState createState() => AccountFormDemoState();
}

class AccountFormDemoState extends State<AccountFormDemo> {
  final registerFormKey = GlobalKey<FormState>();
  String name, moneyValue, description;
  bool autoValidDateBool = false;
  int accountType=0;
  void handleRadioValueChanged(int value){
    setState(() {
      accountType=value;
    });
  }


  void submitAccountForm() {
    if (registerFormKey.currentState.validate()) {
      registerFormKey.currentState.save();
      //print("CCCKKKKKKKCCC:"+moneyValue);
      if(moneyValue[moneyValue.length-1]=='.'&& moneyValue[moneyValue.length-2]=='.')
        {
          moneyValue=moneyValue.substring(0,moneyValue.length-2);
        }
      else if(moneyValue.contains('.'))
        {
          int _pointIndex=moneyValue.indexOf('.');
          String A=moneyValue.substring(0,_pointIndex);
          String B='';
          if(moneyValue.length-_pointIndex>2){
            B=A+'.'+moneyValue.substring(_pointIndex+1,_pointIndex+3);
          }else
          {
            B=A+'.'+moneyValue.substring(_pointIndex+1,moneyValue.length);
          }
          moneyValue=B;
        }else{
        if(moneyValue.length>6){
          moneyValue=moneyValue.substring(0,moneyValue.length-1);
        }
      }

     // print("CCCCCCCCCCCCCCCCC:"+moneyValue);
      //moneyValue=(double.parse(int.parse((double.parse(moneyValue)*100).toString()).toString())/100).toString();
      insertData(accountType, name,Decimal.parse(moneyValue), description);
      // debugPrint("name:$name");
      // debugPrint("moneyValue:$moneyValue");
      // debugPrint("description:$description");
      // debugPrint("type:$accountType");
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text("已处理√"),
        )
      );
    } else
      setState(() {
        autoValidDateBool = true;
      });
  }

  String validateName(value) {
    if (value.isEmpty) {
      return "请键入账目标题！";
    }
    if(value.length>5){
      return '长度不能大于5个字！';
    }
    return null;
  }

  //判断字符串是否是数字
  bool isNumber(String s){
    if(s.isEmpty)
      return false;
    return double.tryParse(s) != null;
  }
  String validateMoneyValue(value) {
    if (value.isEmpty||!isNumber(value)) {
      return "请键入合法费用";
    } else
      return null;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: registerFormKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(
                labelText: '标题',
                helperText: "在此键入该笔账目的标题",
              ),
              onSaved: (value) {
                name = value;
              },
              validator: validateName,
              autovalidate: autoValidDateBool,
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: '价格',
                helperText: "在此键入该笔账目的价格",
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [
                NumLengthInputFormatter(decimalLength: 2,integerLength: 6),
              ],
              onSaved: (value) {
                moneyValue = value;
              },
              validator: validateMoneyValue,
              autovalidate: autoValidDateBool,
            ),
            SizedBox(height: 9.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  "类型",
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w100,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Radio(
                  value: 0,
                  groupValue: accountType,
                  onChanged: handleRadioValueChanged,
                  activeColor: Colors.amber,
                ),
                Text("饮食"),
                Radio(
                  value: 1,
                  groupValue: accountType,
                  onChanged: handleRadioValueChanged,
                  activeColor: Colors.amber,
                ),
                Text("玩乐"),
                Radio(
                  value: 2,
                  groupValue: accountType,
                  onChanged: handleRadioValueChanged,
                  activeColor: Colors.amber,
                ),
                Text("出行"),
                Radio(
                  value: 3,
                  groupValue: accountType,
                  onChanged: handleRadioValueChanged,
                  activeColor: Colors.amber,
                ),
                Text("其它"),
              ],
            ),
            TextFormField(
             // obscureText: true,
              decoration: InputDecoration(
                labelText: '简介',
                helperText: "在此键入该笔账目的简介(非必填)",
              ),
              onSaved: (value) {
                description = value;
              },
              autovalidate: autoValidDateBool,
            ),
            SizedBox(height: 32.0),
            Container(
              width: double.infinity,
              child: RaisedButton(
                color: Theme.of(context).accentColor,
                child: Text(
                  '提交',
                  style: TextStyle(color: Colors.white),
                ),
                elevation: 0.0,
                onPressed: submitAccountForm,
              ),
            )
          ],
        ),
      );
  }
}
