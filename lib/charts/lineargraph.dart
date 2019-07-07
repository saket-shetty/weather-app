import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:sensegrass/data/graphdata.dart';

class lineargraph extends StatefulWidget {
  @override
  _lineargraphState createState() => _lineargraphState();
}

class _lineargraphState extends State<lineargraph> {
  
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: new charts.BarChart(
          _seriesPieData,
          animate: true,
          vertical: false,
          barRendererDecorator: new charts.BarLabelDecorator<String>(),
          behaviors: [
            new charts.DatumLegend(
            outsideJustification: charts.OutsideJustification.endDrawArea,
            horizontalFirst: false,
            desiredMaxRows: 2,
            entryTextStyle: charts.TextStyleSpec(
                color: charts.MaterialPalette.purple.shadeDefault,
                fontFamily: 'Georgia',
                fontSize: 11),
          ),
        ],
      ),
    );
  }
}