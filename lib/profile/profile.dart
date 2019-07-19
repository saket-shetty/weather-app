import 'dart:async';
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sensegrass/login/login.dart';
import 'package:sensegrass/weather/weather.dart';


class profile extends StatefulWidget {
  @override
  _profileState createState() => _profileState();
}

class _profileState extends State<profile> {

  var user_name, user_profile;
  final storage = new FlutterSecureStorage();
  var _cropcolor = 0xFFF44A4A, _weathercolor = 0xFF00FFFFFF;
  
  final FirebaseAuth _fAuth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = new GoogleSignIn();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    user_detail();
  }

  Future user_detail() async{
    user_name = await storage.read(key: 'user-name');
    user_profile = await storage.read(key: 'user-image');
    setState((){

    });
  }

  Future signout() async {
    googleSignIn.signOut();
    await storage.deleteAll();
    Navigator.push(context, MaterialPageRoute(builder: (context)=>loginpage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(64, 75, 96, .9),
      body: Column(
          children: <Widget>[
            GestureDetector(
              onTap: (){
                signout();
                storage.deleteAll();
              },
              child: Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.only(top:8.0, right: 8.0),
                  child: new Text('Log Out',
                    style: new TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ),
            ),

            user_profile == null ? new CircularProgressIndicator() :
            Center(
              child: new Column(      
                children: <Widget>[

                  new Padding(padding: new EdgeInsets.all(10.0),),
                  Container(
                  width: 120.0,
                  height: 120.0,
                  decoration: BoxDecoration(
                      color: Colors.deepPurpleAccent,
                      image: DecorationImage(
                          image: new CachedNetworkImageProvider(user_profile),
                          fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(75.0)),
                    ),
                  ),
                  new Padding(
                    padding: new EdgeInsets.all(10.0),
                  ),

                  new Text(user_name,
                    style: new TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w300,
                      fontFamily: 'SourceSansPro',
                      color: Colors.white
                    ),
                  ),

                  new Padding(
                    padding: new EdgeInsets.all(10.0),
                  ),

                  new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[

                      GestureDetector(
                        onTap: (){
                          _cropcolor = 0xFFF44A4A;
                          _weathercolor = 0xFF00FFFFFF;

                          setState(() {
                            
                          });
                        },
                        child: new Container(
                          width: 150,
                          height: 50,
                          decoration: new BoxDecoration(
                            borderRadius: BorderRadius.circular(25.0),
                            border: Border.all(color: Colors.redAccent),
                            color: Color(_cropcolor),
                          ),
                          child: new Center(
                            child: new Text('Crops',
                              style: new TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                fontSize: 16.0,
                                fontFamily: 'SourceSansPro'
                              ),
                            ),
                          ),
                        ),
                      ),

                      new Padding(
                        padding: new EdgeInsets.all(10.0),
                      ),

                      GestureDetector(
                        onTap: (){
                          _cropcolor = 0xFF00FFFFFF;
                          _weathercolor = 0xFFF44A4A;
                          Navigator.push(context, MaterialPageRoute( builder: (context) => weather()));
                          setState(() {
                            
                          });
                        },
                        child: new Container(
                          width: 150,
                          height: 50,
                          decoration: new BoxDecoration(
                            borderRadius: BorderRadius.circular(25.0),
                            border: Border.all(color: Colors.redAccent),
                            color: Color(_weathercolor),
                          ),
                          child: new Center(
                            child: new Text('Weather',
                               style: new TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                fontSize: 16.0,
                                fontFamily: 'SourceSansPro'
                              ),
                            ),
                          ),
                        ),
                      ),

                    ],
                  )
                ],
              ),
            ),
          ],
        
      ),

    );
  }
}