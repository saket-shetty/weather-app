import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;


class npkgraph extends StatefulWidget {
  @override
  final Widget child;
  npkgraph({Key key, this.child}) : super(key: key);
  _npkgraphState createState() => _npkgraphState();
}

class _npkgraphState extends State<npkgraph> {

  static List<charts.Series<Task, String>> _seriesPieData;
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
    setState(() {
      
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    _seriesPieData = List<charts.Series<Task, String>>();
    _generateData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: new charts.PieChart(
              _seriesPieData,
              animate: false,
              behaviors: [
                new charts.DatumLegend(
                outsideJustification: charts.OutsideJustification.endDrawArea,
                horizontalFirst: false,
                desiredMaxRows: 2,
                cellPadding: new EdgeInsets.only(right: 4.0, bottom: 4.0),
                entryTextStyle: charts.TextStyleSpec(
                    color: charts.MaterialPalette.purple.shadeDefault,
                    fontFamily: 'Georgia',
                    fontSize: 11),
              )
              ],
              defaultRenderer: new charts.ArcRendererConfig(
                arcRendererDecorators: [new charts.ArcLabelDecorator(
                  insideLabelStyleSpec: new charts.TextStyleSpec(                
                    fontSize: 18,
                    color: charts.MaterialPalette.white,
                  ),
                ),
              ]
            ),
          ),
        ),
      ),
    );
  }
}

class Task {
  String task;
  double taskvalue;
  Color colorval;

  Task(this.task, this.taskvalue, this.colorval);
}