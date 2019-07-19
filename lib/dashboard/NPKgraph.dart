import 'package:flutter/material.dart';
import 'package:sensegrass/charts/lineargraph.dart';
// import 'package:sensegrass/charts/piechart.dart';
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
    dropdownValue = 'PieChart';
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
              DropdownButton<String>(
                    value: dropdownValue,
                    onChanged: (String newValue) {
                      setState(() {
                        dropdownValue = newValue;
                        if(newValue == 'LinearGraph'){
                          this._graphpage = lineargraph();
                        }
                        else{
                          // this._graphpage = piechart();
                          this._graphpage = columnchart();
                        }
                      });
                    },
                items: <String>['LinearGraph', 'PieChart']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
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

