import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Constants.dart';

class HiddenPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("写给咱家的小朋友"),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("创建时间:2020-01-20-22:37",style: TextStyle(
              fontSize: 9.0,),),
            Card(
              margin: EdgeInsets.all(0.0),
              //color: Colors.cyan,
              child: Container(
                height: 280.0,
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
                        child: Text(
                          hiddenMessage,
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
            //Image.asset("images/hidden_left.jpg",fit: BoxFit.contain,),
            Image.asset("images/hidden_lyric.jpg",fit: BoxFit.contain,),
            //Image.asset("images/hidden_right.jpg",fit: BoxFit.contain,),
          ],
        ),
      ),
    );
  }

}