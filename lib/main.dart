import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'homepage.dart';
import 'login/login.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:firebase_database/firebase_database.dart';

void main() => runApp(new MaterialApp(
  home: homepage(),
  showSemanticsDebugger: false,
  debugShowCheckedModeBanner: false,
  title: 'Sensegrass',
  ),
);

class homepage extends StatefulWidget {
  @override
  _homepageState createState() => _homepageState();
}

class _homepageState extends State<homepage> {

  final storage = new FlutterSecureStorage();
  var token = '122';
  var email;

  final DatabaseReference reference = FirebaseDatabase.instance.reference();

  void logintime(var newemail){
    var time = DateTime.now();
    reference.child('user').child('$newemail').child('Day').set('${time.day}');
    reference.child('user').child('$newemail').child('Time').set('${time.hour}');
  }

  Future get_token() async{
    token = await storage.read(key: 'session-key');
    email = await storage.read(key: 'user-name');

    print('this is token :$token');

    if(token != null){
    Timer(Duration(seconds: 2), (){
      Navigator.push(context, MaterialPageRoute(builder: (context)=> mainhomepage()));
      logintime(email);
    });
    }
    else if(token == null){
    Timer(Duration(seconds: 2), (){
      Navigator.push(context, MaterialPageRoute(builder: (context)=> loginpage()));
    });
    }
  }

  @override
  void initState() {
    // TODO: implement initState

    // It is the splash screen
    // This is the screen which will call as the app starts everytime
    // After 2 seconds it will redirect to the login page
    get_token();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      body: new Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          new Padding(padding: new EdgeInsets.all(60),
          ),

          // Companies logo (Sensegrass)

          new Center(
            child: new Image.asset('asset/logo.png',
            width: 300,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left:20.0),
            child: new Text(
              'Machine Intelligence for smart and sustainable agriculture',
              style: new TextStyle(color: Colors.black,
              fontSize: 20.0,
              fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircularProgressIndicator(),
                Padding(
                  padding: EdgeInsets.only(top: 20.0),
                ),
                Text(
                  'app will start in a second',
                  softWrap: true,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                      color: Colors.black),
                )
              ],
            ),
          ),
        ],
      )
    );
  }
}
