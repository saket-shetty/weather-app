import 'dart:async';

import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:sensegrass/data/graphdata.dart';
import 'package:fl_chart/fl_chart.dart';


class piechart extends StatefulWidget {
  @override
  _piechartState createState() => _piechartState();
}

class _piechartState extends State<piechart> {

  List<PieChartSectionData> pieChartRawSections;
  List<PieChartSectionData> showingSections;

  StreamController<PieTouchResponse> pieTouchedResultStreamController;

  // List item = [];

  int touchedIndex;

  Future send_data() async{

    // for(var x=0; x<=5; x++){

    //   item.add(
    //     PieChartSectionData(
    //       color: Color(0xff13d38e),
    //       value: 15,
    //       title: "15%",
    //       radius: 50,
    //       titleStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xffffffff)),
    //     )
    //   );
    // }

    final section1 = PieChartSectionData(
      color: Color(0xff0293ee),
      value: 40,
      title: "40%",
      radius: 50,
      titleStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xffffffff)),
    );

    final section2 = PieChartSectionData(
      color: Color(0xfff8b250),
      value: 30,
      title: "30%",
      radius: 50,
      titleStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xffffffff)),
    );

    final section3 = PieChartSectionData(
      color: Color(0xff845bef),
      value: 15,
      title: "15%",
      radius: 50,
      titleStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xffffffff)),
    );

    final section4 = PieChartSectionData(
      color: Color(0xff13d38e),
      value: 15,
      title: "15%",
      radius: 50,
      titleStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xffffffff)),
    );

    final item = [
      section1,
      section2,
      section3,
      section4,
    ];

    pieChartRawSections = item;
    showingSections = pieChartRawSections;

    pieTouchedResultStreamController = StreamController();
    pieTouchedResultStreamController.stream.distinct().listen((details) {
      print(details);
      if (details == null) {
        return;
      }

      touchedIndex = -1;
      if (details.sectionData != null) {
        touchedIndex = showingSections.indexOf(details.sectionData);
      }

      setState(() {
        if (details.touchInput is FlLongPressEnd) {
          touchedIndex = -1;
          showingSections = List.of(pieChartRawSections);
        } else {
          showingSections = List.of(pieChartRawSections);

          if (touchedIndex != -1) {
            final TextStyle style = showingSections[touchedIndex].titleStyle;
            showingSections[touchedIndex] = showingSections[touchedIndex].copyWith(
              titleStyle: style.copyWith(
                fontSize: 24,
              ),
              radius: 60,
            );
          }
        }
      });
    });
  }




  // .................................................................................................
  

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
        labelAccessorFn: (Task row, _) => '${row.task}',
      ),
    ];
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _seriesPieData = List<charts.Series<Task, String>>();
    send_data();
    _generateData();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child:
      //  Container(
      //   child: FlChart(
      //     chart: PieChart(
      //       PieChartData(
      //         pieTouchData: PieTouchData(
      //           touchResponseStreamSink: pieTouchedResultStreamController.sink
      //         ),
      //         borderData: FlBorderData(
      //           show: false,
      //         ),
      //         sectionsSpace: 0,
      //         centerSpaceRadius: 40,
      //         sections: showingSections),
      //     ),
      //   ),
      // ),
      
       charts.PieChart(
        _seriesPieData,
          animate: true,
          animationDuration: Duration(milliseconds: 1500),
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
        defaultRenderer: new charts.ArcRendererConfig(
          arcRendererDecorators: [new charts.ArcLabelDecorator(
            insideLabelStyleSpec: new charts.TextStyleSpec(
              fontSize: 18,
              color: charts.MaterialPalette.white,
            )
           ),
          ],
        ),
      ),
    );
  }
}