import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:weather/weather.dart';


class windspeed extends StatefulWidget {
  @override
  _windspeedState createState() => _windspeedState();
}

class _windspeedState extends State<windspeed> {


  final Color barColor = Colors.deepPurple;
  final Color barBackgroundColor = Colors.deepPurple[50];
  final double width = 22;

  var count = 0;

  static List weatherdata = [];
  List days=[];

  List<BarChartGroupData> rawBarGroups;
  List<BarChartGroupData> showingBarGroups;

  StreamController<BarTouchResponse> barTouchedResultStreamController;

  int touchedGroupIndex;

    Future data_weather() async{

      WeatherStation weatherStation = new WeatherStation('d114a0ec1308a2466249008d46419b6c');
      List<Weather> weather = await weatherStation.fiveDayForecast();

      var now = DateTime.now();
      var formated_day = DateTime.utc(now.year, now.month, now.day);
      var day = formated_day.weekday;
      print('is this todays date :'+ formated_day.weekday.toString());

      for(var y=0 ; y<=9 ; y++){
        if(day+y == 8){
          days.add(1);
        }else if(day+y == 9){
          days.add(2);
        }else if(day+y == 10){
          days.add(3);
        }else if(day+y == 11){
          days.add(4);
        }else if(day+y == 12){
          days.add(5);
        }else if(day+y == 13){
          days.add(6);
        }else{
        days.add(day+y);
        }
      }

      for(var x in weather){
       weatherdata.add(x.windSpeed);
        if(count==9){
          break;
        }
       setState((){});
      }



    final item = [];

      for(var x=0; x<=6; x++){
        item.add(makeGroupData_windspeed(days[x], weatherdata[x]));
      }

    print('this is data baby'+weatherdata[0].toString());
    count++;

    rawBarGroups = item.cast<BarChartGroupData>();

    showingBarGroups = rawBarGroups;

    barTouchedResultStreamController = StreamController();
    barTouchedResultStreamController.stream.distinct().listen((BarTouchResponse response) {
      if (response == null) {
        return;
      }

      if (response.spot == null) {
        setState(() {
          touchedGroupIndex = -1;
          showingBarGroups = List.of(rawBarGroups);
        });
        return;
      }

      touchedGroupIndex = showingBarGroups.indexOf(response.spot.touchedBarGroup);

      setState(() {
        if (response.touchInput is FlLongPressEnd) {
          touchedGroupIndex = -1;
          showingBarGroups = List.of(rawBarGroups);
        } else {
          showingBarGroups = List.of(rawBarGroups);
          if (touchedGroupIndex != -1) {
            showingBarGroups[touchedGroupIndex] = showingBarGroups[touchedGroupIndex].copyWith(
              barRods: showingBarGroups[touchedGroupIndex].barRods.map((rod) {
                return rod.copyWith(color: Colors.yellow, y: rod.y + 1);
              }).toList(),
            );
          }
        }
      });
      }
    );
  }

  @override
  void initState() {
    data_weather();
    super.initState();
    // print(weatherdata[1]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text('Wind Speed',
          style: new TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w300,
          ),
        ),
        backgroundColor: Colors.deepPurpleAccent,
        centerTitle: true,
      ),

      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Text(
                "Wind Speed (m/s)",
                style: TextStyle(
                  color: Color(0xff0f4a3c), fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 4,
              ),
              Text(
                "Current along with the next 5 days data",
                style: TextStyle(
                  color: Color(0xff379982), fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Tap and hold on the bar to get the reading",
                style: TextStyle(
                  color: Color(0xff379982), fontSize: 15, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 28,
              ),
              new Container(
               child: weatherdata.length == 0 ? new Text('Wait a Minute') :
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 1.0),
                  child: FlChart(
                    chart: BarChart(BarChartData(

                      barTouchData: BarTouchData(
                        touchTooltipData: TouchTooltipData(
                          tooltipBgColor: Colors.blueGrey,
                          getTooltipItems: (touchedSpots) {
                            return touchedSpots.map((touchedSpot) {
                              String weekDay;
                              switch (touchedSpot.spot.x.toInt()) {
                                case 1:
                                 weekDay = 'Monday'; break;
                                case 2: weekDay = 'Tuesday'; break;
                                case 3: weekDay = 'Wednesday'; break;
                                case 4: weekDay = 'Thursday'; break;
                                case 5: weekDay = 'Friday'; break;
                                case 6: weekDay = 'Saturday'; break;
                                case 7: weekDay = 'Sunday'; break;
                              }
                              return TooltipItem(weekDay + '\n' + touchedSpot.spot.y.toDouble().toString(), TextStyle(color: Colors.yellow));
                            }).toList();
                          }
                        ),
                      ),

                      titlesData: FlTitlesData(
                        show: true,
                        showHorizontalTitles: true,
                        showVerticalTitles: true,
                        
                        horizontalTitlesTextStyle: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
                        horizontalTitleMargin: 16,
                        ),
                      borderData: FlBorderData(
                        show: false,
                      ),
                      barGroups: showingBarGroups,
                    )),
                  ),
                ),
              ),
              ),
              SizedBox(
                height: 12,
              ),
            ],
          ),
        ),
      ),

    );
  }

  BarChartGroupData makeGroupData_windspeed(int x, double y) {
    var backgroundBarChartRodData = BackgroundBarChartRodData(
          show: true,
          color: barBackgroundColor,
          y: 10,
        );
    return BarChartGroupData(x: x, barRods: [
      BarChartRodData(
        y: y,
        color: barColor,
        width: width,
        isRound: true,
        backDrawRodData: backgroundBarChartRodData,
      ),
    ]);
  }

}

// class OrdinalSales {
//   final String year;
//   final int sales;

//   OrdinalSales(this.year, this.sales);
// }
