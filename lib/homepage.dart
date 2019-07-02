import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:sensegrass/login/login.dart';
import 'dashboard/dashboard.dart';
import 'landingpage.dart';
import 'contact.dart';
import 'profile/profile.dart';

class mainhomepage extends StatefulWidget {
  @override
  _mainhomepageState createState() => _mainhomepageState();
}

class _mainhomepageState extends State<mainhomepage> {

  // this will indicate to which icon of the bottom navigation bar is been tapped
  var _onTapIndex=0;
  // this will only change the main body part of the app according to the page is been selected
  var _bodyUI;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bodyUI = landing();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
        appBar: new AppBar(
          backgroundColor: Colors.deepPurpleAccent,
          title: new Text('SenseGrass',
          style: new TextStyle(fontSize: 18.0,
            fontWeight: FontWeight.w300,
            ),
          ),
          centerTitle: true,
          elevation: 0.0,
          iconTheme: IconThemeData(
            opacity: 0.0
          ),
        ),

        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton:FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>contact()));
          },
          icon: Icon(Icons.mail),
          label: Text("Expert"),
          backgroundColor: Colors.deepPurpleAccent,
        ),

        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _onTapIndex,
          onTap: (int index){
            setState(() {
              _onTapIndex = index;
              if(index == 0){
                  _bodyUI = landing();
              }
              else if (index == 1) {
                setState(() {
                  _onTapIndex = 1;
                  _bodyUI = dashboard();

                });
              } else if (index == 2) {
                setState(() {
                  _onTapIndex = 2;
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>profile()));
                });
              }
            });
          },
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(LineIcons.home), 
              title: new Text('Home'),
            ),
            BottomNavigationBarItem(
              icon: Icon(LineIcons.dashboard),
              title: new Text('Dashboard'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: new Text('Profile'),
            ),
          ],
        ),
        body: _bodyUI,
      ),
    );
  }
}