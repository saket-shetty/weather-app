import 'package:flutter/material.dart';
import 'package:weather/weather.dart';
import 'package:sensegrass/data/temperature.dart';


class templist extends StatefulWidget {
  @override
  _templistState createState() => _templistState();
}

class _templistState extends State<templist> {

  List<tempdata> allData = [];

  Future getweather() async{
    WeatherStation weatherStation = new WeatherStation('d114a0ec1308a2466249008d46419b6c');
    Weather weather = await weatherStation.currentWeather();
    var celsius = weather.weatherMain;
    // print(celsius);
    List<Weather> forecasts = await weatherStation.fiveDayForecast();
    for(var list in forecasts){
      
      var temperature = list.temperature.celsius.floorToDouble();

      var weather_main = list.weatherMain;
      var allday = list.date.day;
      var allmonth = list.date.month;
      var allyear = list.date.year;

      var all_date = allday.toString()+':'+allmonth.toString()+':'+allyear.toString();

      tempdata temp = new tempdata(temperature,all_date,weather_main);
      allData.add(temp);
      setState(() {});
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    getweather();
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Container(
      child: allData.length == 0 ? CircularProgressIndicator() :
       Expanded(
        child: new ListView.builder(
          itemCount: allData.length,
          itemBuilder: (_, index) {
          return dashui(allData[index].date, allData[index].temp_celcius, allData[index].weather);
          },
        ),
      ),
    );
  }

    Widget dashui(var date_value, var temp_value, var weather){
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Card(
        child: Container(
          color: Colors.deepPurpleAccent,
          child: new Row(
            children: <Widget>[
              new Padding(padding: new EdgeInsets.all(10.0),),
              new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Padding(padding: new EdgeInsets.all(10.0),),
                  new Text('Date :'+date_value.toString(),
                  style: new TextStyle(
                    fontSize: 17.0,
                    ),
                  ),
                  new Padding(padding: new EdgeInsets.all(5.0),),
                  new Text('Temperature : '+temp_value.toString()+'\u02DA'+'C',
                  style: new TextStyle(
                    fontSize: 17.0,
                    ),
                  ),
                  new Padding(padding: new EdgeInsets.all(10.0),),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}