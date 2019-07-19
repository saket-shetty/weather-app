import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:line_icons/line_icons.dart';


class changecolumnchart extends StatefulWidget {
  @override
  _changecolumnchartState createState() => _changecolumnchartState();
}

class _changecolumnchartState extends State<changecolumnchart> {

  var name, value, health;
  int newvalue;
  final storage = new FlutterSecureStorage();

  bool longpressup = false;

  Future get_data() async{
    name = await storage.read(key: 'name');
    value = await storage.read(key: 'value');
    health = await storage.read(key: 'health');
    // newvalue = value.toInt();    
    value = int.parse(value);

    setState(() {
    });
  }

  void longpress(){
    value = value +1;
    print('$value');
    Timer(Duration(milliseconds: 400), (){
      if(longpressup !=true){
      longpress();
      }
    });
    setState(() {
      
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    get_data();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: new AppBar(
        title: new Text('$name',
          style: new TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w300,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurpleAccent,
      ),

      body: Center(
        child: new Column(
          children: <Widget>[
            new Padding(padding: new EdgeInsets.all(10.0),),
            new Text('$name'),
            new Padding(padding: new EdgeInsets.all(10.0),),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[

                new IconButton(
                  onPressed: (){
                    value = value - 1;
                    if(value <= 7 && value >=0 ){
                      health = 'ACCEPTABLE';
                    }
                    else if(value <=-1){
                      health = 'Sorry, value cannot be in negative';
                      value = 0;
                    }
                    setState(() {
                      
                    });
                  },
                  icon: Icon(LineIcons.minus_circle,
                    color: Colors.black,
                    size: 30,
                  ),
                  color: Colors.black,
                ),

                new Padding(padding: new EdgeInsets.all(10.0),),

                new Text('$value'),

                new Padding(padding: new EdgeInsets.all(10.0),),

                new GestureDetector(

                  onLongPressUp: (){
                    print('this is up');
                    longpressup = true;
                    setState(() {
                      
                    });
                  },

                  onLongPress: (){
                    longpressup = false;
                    longpress();
                  },

                  onTap: (){
                    value = value + 1;
                    setState(() {
                      
                    });
                  },

                  child: Icon(LineIcons.plus_circle,
                    color: Colors.black,
                    size: 30,
                  ),
                ),
                

              ],
            ),

            new Padding(padding: new EdgeInsets.all(10.0),),

            new Container(
              width: 80,
              height: 7.0,
              child: LinearProgressIndicator(
                  backgroundColor: Color.fromRGBO(209, 224, 224, 0.2),
                  value: value/100,
                  valueColor: AlwaysStoppedAnimation(Colors.green),
              ),
            ),

            new Padding(padding: new EdgeInsets.all(10.0),),

            new Text('$health'),
          ],
        ),
      ),
    );
  }
}