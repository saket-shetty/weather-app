import 'package:flutter/material.dart';
import 'package:sensegrass/charts/columnchart.dart';



class npkgraph extends StatefulWidget {
  @override
  final Widget child;
  npkgraph({Key key, this.child}) : super(key: key);
  _npkgraphState createState() => _npkgraphState();
}

class _npkgraphState extends State<npkgraph> {

  var dropdownValue;
  var _graphpage;

  @override
  void initState() {
    // TODO: implement initState
    this._graphpage = columnchart();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
          child: Column(
            children: <Widget>[
              new Expanded(
                child: _graphpage,
              )
            ],
          ),
        ),
      ),
    );
  }
}

