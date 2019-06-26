import 'package:flutter/material.dart';
import 'temperaturelist.dart';
import 'NPKgraph.dart';

class dashboard extends StatefulWidget {
  @override
  _dashboardState createState() => _dashboardState();
}

class _dashboardState extends State<dashboard> {

  int _NPKcolor = 0xFFffffff , _TEMPcolor = 0xFFffffff , _GRAPHcolor = 0xFFffffff;
  var _page;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _NPKcolor = 0xFF000000;

    _page = npkgraph();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          new Container(
            width: MediaQuery.of(context).size.width,
            height: 30.0,
            color: Colors.deepPurpleAccent,
            child: Padding(
              padding: const EdgeInsets.only(left:10.0, right: 10.0),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  GestureDetector(
                    onTap: (){
                      print('yo');
                      setState(() {
                        _NPKcolor = 0xFF000000;
                        _TEMPcolor = 0xFFffffff;
                        _GRAPHcolor = 0xFFffffff;
                        _page = npkgraph();
                      });
                    },
                    child: new Text('NPK',
                      style: new TextStyle(
                        fontSize: 15.0,
                        color: Color(_NPKcolor),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      print('yo');
                      setState(() {
                        _NPKcolor = 0xFFffffff;
                        _TEMPcolor = 0xFF000000;
                        _GRAPHcolor = 0xFFffffff;
                        _page = templist();
                      });
                    },
                    child: new Text('TEMPERATURE',
                      style: new TextStyle(
                        fontSize: 15.0,
                        color: Color(_TEMPcolor),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      print('yo');
                      setState(() {
                        _NPKcolor = 0xFFffffff;
                        _TEMPcolor = 0xFFffffff;
                        _GRAPHcolor = 0xFF000000;
                      });
                    },
                    child: new Text('GRAPH',
                      style: new TextStyle(
                        fontSize: 15.0,
                        color: Color(_GRAPHcolor),
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