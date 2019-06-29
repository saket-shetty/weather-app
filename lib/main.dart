import 'dart:async';
import 'package:flutter/material.dart';
import 'package:weather/weather.dart';
import 'homepage.dart';
import 'login/login.dart';

void main() => runApp(new MaterialApp(
  home: homepage(),
  showSemanticsDebugger: false,
  debugShowCheckedModeBanner: false,
  title: 'Sensegrass',
  )
);

class homepage extends StatefulWidget {
  @override
  _homepageState createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  @override
  void initState() {
    // TODO: implement initState

    // getweather();

    Timer(Duration(seconds: 2), (){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>loginpage()));
    });

    super.initState();
  }

  Future getweather() async{
    WeatherStation weatherStation = new WeatherStation('d114a0ec1308a2466249008d46419b6c');
    Weather weather = await weatherStation.currentWeather();
    double celsius = weather.temperature.celsius;
    print(celsius);
    List<Weather> forecasts = await weatherStation.fiveDayForecast();
    for(var list in forecasts){
      var lol = list.temperature.celsius;
      var olo = list.date;
      print(lol.ceil());
      print(olo);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: new Stack(
      fit: StackFit.expand,
      children: <Widget>[
        new Container(
          decoration: new BoxDecoration(
            image: new DecorationImage(image: AssetImage('asset/background2.jpg'),
            fit: BoxFit.fitHeight,
            )
          ),
        ),
        new Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            new Padding(padding: new EdgeInsets.all(60),
            ),
            new Center(
              child: new Image.asset('asset/logo.png',
              width: 300,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left:20.0),
              child: new Text(
                'Machine Intelligence for smart and sustainable agriculture',
                style: new TextStyle(color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.w500,
                ),
              ),
            ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(),
                    Padding(
                      padding: EdgeInsets.only(top: 20.0),
                    ),
                    Text(
                      'app will start in a second',
                      softWrap: true,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                          color: Colors.white),
                    )
                  ],
                ),
              ),
          ],
        )
      ],
    )
  );
}
}
