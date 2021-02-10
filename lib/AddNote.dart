import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddNote extends StatelessWidget{


  @override
  Widget build(BuildContext context) {
   return Scaffold(
     body:SingleChildScrollView(
         child: Container(
           padding: EdgeInsets.all(16.0),
           child: Column(
             mainAxisAlignment: MainAxisAlignment.start,
             children: <Widget>[
               FormDemo(),
             ],
           ),
         ),
       ),
   );
  }

}

class FormDemo extends StatefulWidget {
  @override
  FormDemoState createState() => FormDemoState();
}

class FormDemoState extends State<FormDemo> {

  final registerFormKey = GlobalKey<FormState>();
  String notebook, title;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: registerFormKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            initialValue: "标题",
            style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.w400),
            decoration: InputDecoration(
              //helperText: "标题",
            ),
            // onSaved: (value) {
            //   name = value;
            // },
          ),
          Card(
            margin: EdgeInsets.all(0.0),
            child: Container(
              height: 500.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextDemo(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TextDemo extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.only(
          left: 18.0,
          right: 18.0,
          bottom: 20.0,
          top: 2.0,
        ),
        child: TextField(
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: '点按即可输入文本',
          ),
          style: TextStyle(
            color: Colors.black,
            fontSize: 15.0,
          ),
          maxLines: 999,
          
        ),
      ),
    );
  }

}