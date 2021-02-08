import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'NumberInputControl.dart';
import 'AccountDB.dart';
import 'ListDetail.dart';

class AccountModifyPage extends StatelessWidget {
  final String id, type, name, moneyValue, time, description;
  AccountModifyPage({
    @required this.id,this.type,this.name,this.moneyValue,this.time,this.description,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text(
          "修改账目",
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w200,
          ),
        ),
      ),
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
                AccountModifyForm(id, type, name,moneyValue, time, description),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AccountModifyForm extends StatefulWidget {
  final String _id, _type, _name, _moneyValue, _time, _description;
  AccountModifyForm(
    this._id,this._type,this._name,this._moneyValue,this._time,this._description);
  @override
  AccountModifyFormState createState() => AccountModifyFormState(_id, _type, _name,_moneyValue, _time, _description);
}

class AccountModifyFormState extends State<AccountModifyForm> {
  final String _id, _type, _name, _moneyValue, _time, _description;
  AccountModifyFormState(
      this._id,this._type,this._name,this._moneyValue,this._time,this._description);
  final registerFormKey = GlobalKey<FormState>();
  String name, moneyValue, description;
  bool autoValidDateBool = false;
  int accountType=0;
  void handleRadioValueChanged(int value){
    setState(() {
      accountType=value;
    });
  }


  void submitAccountChange() {
    if (registerFormKey.currentState.validate()) {
      registerFormKey.currentState.save();
      //accountType++;
      if(name=='') name=_name;
      if(moneyValue=='')moneyValue=_moneyValue;
      if(description=='')description=_description;
      if(moneyValue[moneyValue.length-1]=='.'&& moneyValue[moneyValue.length-2]=='.')
      {
        moneyValue=moneyValue.substring(0,moneyValue.length-2);
        // print("C()()()()())KKKKCCC:"+moneyValue);
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
        // print("AAAAAAAAAAAAAAAAAAAAAAAA:"+A);
        // print("BBBBBBBBBBBBBBBBBBBBBBBB:"+B);
        moneyValue=B;
      }else{
        if(moneyValue.length>6){
          moneyValue=moneyValue.substring(0,moneyValue.length-1);
        }
      }
      update(idCurrent,accountType.toString(), name, moneyValue, description);
      debugPrint("name:$name");
      debugPrint("moneyValue:$moneyValue");
      debugPrint("description:$description");
      debugPrint("type:$accountType");
      // Navigator.of(context).push(
      //     MaterialPageRoute(builder: (context) => MyHomePage())
      // );
      Navigator.pop(context);
      Navigator.pop(context);
    } else
      setState(() {
        autoValidDateBool = true;
      });
  }

  String validateName(value) {
    if(value.length>5){
      return '长度不能大于5个字！';
    }
    return null;
  }

  bool isNumber(String s){
    if(s.isEmpty)
      return true;
    return double.tryParse(s) != null;
  }
  String validateMoneyValue(value) {
    if (!isNumber(value)) {
      return "请键入合法账目费用";
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
            onSaved: (value) {
              moneyValue = value;
            },
            validator: validateMoneyValue,
            inputFormatters: [NumLengthInputFormatter(decimalLength: 2,integerLength: 6)],
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
              helperText: "在此键入该笔账目的简介",
            ),
            onSaved: (value) {
              description = value;
            },
            autovalidate: autoValidDateBool,
          ),
          SizedBox(height: 32.0),
          Text(
            "请只输入需要修改的项目其它项目不填\n                      （类型必选）"
          ),
          Container(
            width: double.infinity,
            child: RaisedButton(
              color: Theme.of(context).accentColor,
              child: Text(
                '提交',
                style: TextStyle(color: Colors.white),
              ),
              elevation: 0.0,
              onPressed: submitAccountChange,
            ),
          )
        ],
      ),
    );
  }
}
