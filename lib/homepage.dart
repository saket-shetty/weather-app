import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'dashboard.dart';
import 'landingpage.dart';
import 'contact.dart';

class mainhomepage extends StatefulWidget {
  @override
  _mainhomepageState createState() => _mainhomepageState();
}

class _mainhomepageState extends State<mainhomepage> {

  var _onTapIndex=0;
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
              icon: Icon(LineIcons.book),
              title: new Text('Library'),
            ),
          ],
        ),

        body: _bodyUI,
      ),
    );
  }
}