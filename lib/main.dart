import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'login/login.dart';

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

  @override
  void initState() {
    // TODO: implement initState

    // It is the splash screen
    // This is the screen which will call as the app starts everytime
    // After 2 seconds it will redirect to the login page
    Timer(Duration(seconds: 2), (){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>loginpage()));
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Stack(
        fit: StackFit.expand,
        children: <Widget>[

          // Background Image which in this case is some space image (as in the website)
          new Container(
            decoration: new BoxDecoration(
              image: new DecorationImage(image: AssetImage('asset/background2.jpg'),
              fit: BoxFit.fitHeight,
              )
            ),
            child: new BackdropFilter(
              filter: new ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
              child: new Container(
                decoration: new BoxDecoration(color: Colors.white.withOpacity(0.0)),
              ),
            ),
          ),
          new Column(
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
                  style: new TextStyle(color: Colors.white,
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
                          color: Colors.white),
                    )
                  ],
                ),
              ),
            ],
          )
        ],
      )
    );
  }
}
