import 'dart:async';
import 'package:line_icons/line_icons.dart';
import 'package:sensegrass/data/weatherdata.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:weather/weather.dart';


class weather extends StatefulWidget {
  @override
  _weatherState createState() => _weatherState();
}

class _weatherState extends State<weather> {

  List date_list=[];
  var new_date_list;
  var new_list_length;
  var icon_category;
  IconData card_icon;

  List<weatherdata> allData = [];

  var location, date, temperature, mintemp, maxtemp, time, icon, description;

  final storage = new FlutterSecureStorage();

  Future weather() async{
    WeatherStation weatherStation = new WeatherStation('d114a0ec1308a2466249008d46419b6c');
    List<Weather> weather = await weatherStation.fiveDayForecast();

    List listindex = [0,1,8,16,22];

    var stringmonth;

    for(var x in weather){

      var month = x.date.month;
      if(month == 1){
        stringmonth = 'Jan';
      }
      else if(month == 2){
        stringmonth = 'Feb';
      }
      else if(month == 3){
        stringmonth = 'March';
      }
      else if(month == 4){
        stringmonth = 'April';
      }
      else if(month == 5){
        stringmonth = 'May';
      }
      else if(month == 6){
        stringmonth = 'June';
      }
      else if(month == 7){
        stringmonth = 'July';
      }
      else if(month == 8){
        stringmonth = 'Aug';
      }
      else if(month == 9){
        stringmonth = 'Septh';
      }
      else if(month == 10){
        stringmonth = 'Oct';
      }
      else if(month == 11){
        stringmonth = 'Nov';
      }
      else if(month == 12){
        stringmonth = 'Dec';
      }

      var time = x.date.hour.toString() +':'+ x.date.minute.toString() +':'+ x.date.second.toString();

      if(x.weatherMain == 'Rain'){
        weatherdata data_weather = new weatherdata(x.date.day.toString(), time, stringmonth, x.temperature.celsius.floorToDouble(), x.weatherMain, Icons.wb_cloudy);
        
        allData.add(data_weather);

        print('Rain');
      }
      else if(x.cloudiness >= 70){
        print('cloudy');
        weatherdata data_weather = new weatherdata(x.date.day.toString(), time, x.date.month, x.temperature.celsius.floorToDouble(), x.weatherMain, Icons.wb_cloudy);
        allData.add(data_weather);
      }
      else{
        weatherdata data_weather = new weatherdata(x.date.day.toString(), time, x.date.month,x.temperature.celsius.floorToDouble(), x.weatherMain, Icons.wb_sunny);
        allData.add(data_weather);
      }

      print(x.weatherDescription+':'+x.weatherMain+':'+x.cloudiness.toString()+':');
    }

    if(icon_category == 0){
      card_icon = LineIcons.sun_o;
    }
    else if(icon_category == 1){
      card_icon = LineIcons.cloud;
    }
    else{
      card_icon = LineIcons.moon_o;
    }

    


    setState((){
      
    });

  }

  


  @override
  void initState() {
    // TODO: implement initState
    get_weather_location();
    weather();
    super.initState();
  }

  Future get_weather_location() async{
    location = await storage.read(key: 'location');
    date = await storage.read(key: 'date');
    temperature = await storage.read(key: 'temperature');
    time = await storage.read(key: 'time');
    description = await storage.read(key: 'descrip');
    mintemp = await storage.read(key: 'mintemp');
    maxtemp = await storage.read(key: 'maxtemp');
    icon_category = await storage.read(key: 'icon');
    setState((){});
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text('Weather Forecast',
          style: new TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w300,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurpleAccent
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            new Container(
              child: new Column(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Row(
                        children: <Widget>[
                          new Padding(padding: new EdgeInsets.all(8.0),),
                          new Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              new Padding(padding: new EdgeInsets.all(8.0),),
                              new Text('$location,'+' ${date.toString()}',
                              style: new TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.w500,
                                ),
                              ),
                              new Text('$temperature'+'\u02DA'+'C', 
                              style: new TextStyle(
                                fontSize: 35.0,
                                fontWeight: FontWeight.w400,
                                ),
                              ),
                              new Padding(
                                padding: new EdgeInsets.all(3.0),
                              ),
                              new Text(
                                '$mintemp'+'\u02DA'+'C'+' / '+'$maxtemp'+'\u02DA'+'C',
                                style: new TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              new Padding(
                                padding: new EdgeInsets.all(3.0),
                              ),
                              new Text('Time $time',
                                style: new TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w500
                                ),
                              ),
                            ],
                          ),
                          new Spacer(
                            flex: 2,
                          ),
                          new Container(
                            child: new Icon(card_icon,
                            size: 65.0,
                            color: Colors.blue,
                            ),
                          ),
                          new Spacer(
                            flex: 1,
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left:8.0, right: 8.0),
                        child: new Divider(
                          color: Colors.black38,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left:15.0),
                        child: new Text(description.toString(),
                          textAlign: TextAlign.start,
                          style: new TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w700
                          ),
                        ),
                      ),
                      new Padding(
                        padding: new EdgeInsets.all(3.0),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left:15.0),
                        child: new Text('Today would be a BAD day for APPLYING PESTICIDES',
                          textAlign: TextAlign.start,
                          style: new TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w600
                          ),
                        ),
                      ),
                      new Padding(
                        padding: new EdgeInsets.all(6.0),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left:8.0, right: 8.0),
                        child: new Divider(
                          color: Colors.black38,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            new Text(
              'Next 5 days',
              textAlign: TextAlign.left,
              style: new TextStyle(
                fontSize: 21.0,
              ),
            ),
            new Padding(
              padding: new EdgeInsets.all(5.0),
            ),
            Padding(
              padding: const EdgeInsets.only(left:3.0, right: 3.0),
              child: Container(
                height: 200.0,
                padding: EdgeInsets.only(top: 03.0),
                child: allData.length == 0 ? new CircularProgressIndicator()
                : new ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: allData.length,
                  itemBuilder: (_, index){
                    
                    return UI(allData[index].date,
                              allData[index].time,
                              allData[index].month,
                              allData[index].temperature,
                              allData[index].icondata,
                              allData[index].weatherdescription
                              );
                  }
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget UI(var date, var time, var month, var temp, IconData icon, var descrip){
    return Container(
      color: Colors.grey[200],
      height: 200.0,
      child: Padding(
        padding: const EdgeInsets.only(left:8.0, right: 8.0, top:8.0),
        child: Row(
          children: <Widget>[
            new VerticalDivider(),
            new Column(
              children: <Widget>[
                new Text('$date'+' '+'$month',
                  style: new TextStyle(
                    fontSize: 22.0,
                  ),
                ),
                new Padding(
                  padding: new EdgeInsets.all(4.0),
                ),
                new Text(
                  '$time'
                ),
                new Padding(
                  padding: new EdgeInsets.all(4.0),
                ),
                new Icon(
                  icon,
                  size: 65.0,
                  color: Colors.blue,
                ),
                new Padding(
                  padding: new EdgeInsets.all(5.0),
                ),
                new Text('$temp'+'\u02DA'+'C',
                  style: new TextStyle(
                    fontFamily: 'SourceSansPro',
                    fontSize: 18.0
                  ),
                ),
                new Padding(
                  padding: new EdgeInsets.all(3.0),
                ),
                new Text('$descrip',
                  style: new TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w300,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}