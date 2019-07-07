import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:sensegrass/data/graphdata.dart';
import 'package:sensegrass/charts/lineargraph.dart';
import 'package:sensegrass/charts/piechart.dart';


class npkgraph extends StatefulWidget {
  @override
  final Widget child;
  npkgraph({Key key, this.child}) : super(key: key);
  _npkgraphState createState() => _npkgraphState();
}

class _npkgraphState extends State<npkgraph> {

  static List<charts.Series<Task, String>> _seriesPieData;

  var dropdownValue;
  var _graphpage;

  _generateData() {
  final piedata = [
    new Task('Soil PH', 7, Color(0xff3366cc)),
    new Task('NITROGEN', 10.3, Color(0xff990099)),
    new Task('Temperature', 5.8, Color(0xff109618)),
    new Task('Soil Humidity', 30.6, Color(0xfffdbe19)),
    new Task('NDVI', 20.2, Color(0xffff9900)),
    new Task('Water Stress', 10.3, Color(0xffdc3912)),
  ];

   _seriesPieData.add(
      charts.Series(
        domainFn: (Task task, _) => task.task,
        measureFn: (Task task, _) => task.taskvalue,
        colorFn: (Task task, _) =>
            charts.ColorUtil.fromDartColor(task.colorval),
        id: 'Air Pollution',
        data: piedata,
         labelAccessorFn: (Task task, _) => '${task.taskvalue}',
      ),
    );

    return [
      new charts.Series<Task, String>(
        id: 'Sales',
        domainFn: (Task sales, _) => sales.task,
        measureFn: (Task sales, _) => sales.taskvalue,
        data: piedata,
        
        // Set a label accessor to control the text of the bar label.
        labelAccessorFn: (Task sales, _) =>
            '${sales.task}',
      ),
    ];
  }

  @override
  void initState() {
    // TODO: implement initState
    _seriesPieData = List<charts.Series<Task, String>>();
    _generateData();
    this._graphpage = lineargraph();
    dropdownValue = 'LinearGraph';
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
                          this._graphpage = piechart();
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

