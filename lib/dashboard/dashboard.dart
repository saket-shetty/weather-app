import 'package:flutter/material.dart';
import 'NPKgraph.dart';

class dashboard extends StatefulWidget {
  @override
  _dashboardState createState() => _dashboardState();
}

class _dashboardState extends State<dashboard> {

  int _NPKcolor = 0xFFffffff, _GRAPHcolor = 0xFF000000;
  var _page;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _NPKcolor = 0xFFffffff;
    _page = npkgraph();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color.fromRGBO(64, 75, 96, .9),
      backgroundColor: Colors.grey[200],

      body: Column(
        children: <Widget>[
          new Container(
            width: MediaQuery.of(context).size.width,
            height: 30.0,
            color: Colors.green[600],
            child: Padding(
              padding: const EdgeInsets.only(left:00.0, right: 00.0),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  GestureDetector(
                    onTap: (){
                      print('yo');
                      setState(() {
                        _NPKcolor = 0xFFffffff;
                        _GRAPHcolor = 0xFF000000;
                        _page = npkgraph();
                      });
                    },
                    child: new Text('IOT Sensor',
                      style: new TextStyle(
                        fontSize: 17.0,
                        color: Color(_NPKcolor),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          _page,
        ],
      ),
    );
  }

}