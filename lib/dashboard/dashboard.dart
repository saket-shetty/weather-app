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
      backgroundColor: Color.fromRGBO(64, 75, 96, .9),
      body: Column(
        children: <Widget>[
          new Container(
            width: MediaQuery.of(context).size.width,
            height: 30.0,
            color: Colors.deepPurpleAccent,
            child: Padding(
              padding: const EdgeInsets.only(left:10.0, right: 10.0),
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
                  GestureDetector(
                    onTap: (){
                      print('yo');
                      setState(() {
                        _NPKcolor = 0xFF000000;
                        _GRAPHcolor = 0xFFffffff;
                      });
                    },
                    child: new Text('Satellite',
                      style: new TextStyle(
                        fontSize: 17.0,
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