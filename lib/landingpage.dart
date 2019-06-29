import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather/weather.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';
import 'package:geocoder/geocoder.dart';
import 'package:flutter_sparkline/flutter_sparkline.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class landing extends StatefulWidget {
  @override
  final Widget child;

  landing({Key key, this.child}) : super(key: key);
  _landingState createState() => _landingState();
}

class _landingState extends State<landing> {

  Completer<GoogleMapController> _completer = Completer();
  

  //Default camera position of the google map
  //once the user allows the app to use location it will update to the users position
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

 
  var celsius;
  var now = new DateTime.now();
  var hour,minute,format_date;
  var _categoryindex;
  var _onTapIndex;
  var _area;
  var air_pressure;
  var humidity;
  var wind_speed;
  var predicted_temp;

  List<double> Maxdata = [];
  List<double> Mindata = [];
  List<double> _graphdata;

  var dropdownValue= 'MaxTemp';


  //list of different icons which will change after the right time it inclued:
  // sun, cloud, moon
  List <Map<String, IconData>> _categories = [
    {
      'icon': LineIcons.sun_o,
    },
    {
      'icon': LineIcons.cloud,
    },
    {
      'icon': LineIcons.moon_o,
    },
  ];

  // getweather() function will retrieve the data such as:
  // current temperature
  // current location
  // air_pressure, humidity, wind_speed
  // Max_temperature, Min_temperature
  // co-ordinates (Lat & Lang)
  Future getweather() async{
    WeatherStation weatherStation = new WeatherStation('d114a0ec1308a2466249008d46419b6c');
    Weather weather = await weatherStation.currentWeather();
    celsius = weather.temperature.celsius.roundToDouble();
    this.celsius = celsius;

    final query = "1600 Amphiteatre Parkway, Mountain View";
    var addresses = await Geocoder.local.findAddressesFromQuery(query);
    var first = addresses.first;

    final GoogleMapController controller = await _completer.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        target: LatLng(weather.latitude,weather.longitude),
        zoom: 15.0,
        )));

    //Location of the user Using GeoCoder Api
    final coordinates = new Coordinates(weather.latitude, weather.longitude);
    addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
    first = addresses.first;

    air_pressure = weather.pressure;
    humidity = weather.humidity;
    wind_speed = weather.windSpeed;

    print('airpressure :$air_pressure');
    print('humidity :$humidity');
    print('windspeed :${wind_speed}');

    List<Weather> forecasts = await weatherStation.fiveDayForecast();


    //Max Temp of previous 20 days and will be ploted in line graph
    for(var x in forecasts){
      Maxdata.add(await x.tempMax.celsius.ceilToDouble());
      if(Maxdata.length == 20){
        break;
      }
    }

    int temp_count = 0;
    for(var temp in forecasts){
      predicted_temp = temp.temperature.celsius.floorToDouble();
      print('temp :$predicted_temp');
      temp_count++;
      if(temp_count == 2){
        break;
      }
    }

    //Min Temp of previous 20 days and will be ploted in line graph
    for(var y in forecasts){
      Mindata.add(await y.temperature.fahrenheit.floorToDouble());
      if(Mindata.length == 15){
        break;
      }
    }   

    this._area = first.subAdminArea;
    setState((){
      this.celsius = celsius;
      this._area = first.subAdminArea;
    });
  }

  // Formated date (Month Date Year)
  Future get_date() async{
    format_date = new DateFormat.yMMMMd("en_US").format(now);
    hour = now.hour;
    minute = now.minute;
    setState((){});
  }

  // current time
  // so that the icons will change according to the time.
  Future get_time() async{
    var timeOfDay = now.hour;
    if(timeOfDay >= 0 && timeOfDay < 15){
        //morning      
        _categoryindex = 0;
    }else if(timeOfDay >= 15 && timeOfDay < 19){
        //afternon
        _categoryindex = 0;
    }else if(timeOfDay >= 19 && timeOfDay < 21){
        //evening
        _categoryindex = 2;
    }else if(timeOfDay >= 21 && timeOfDay < 24){
        //night
        _categoryindex = 2;
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getweather();
    get_date();
    get_time();
    _graphdata = Maxdata;
    // print(MediaQuery.of(context).size.width);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new ListView(
        children: <Widget>[
          new Card(
            color: Colors.blue[200],
              child: new Row(
                children: <Widget>[
                  new Padding(padding: new EdgeInsets.all(8.0),),
                  new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Padding(padding: new EdgeInsets.all(8.0),),
                      new Text('$_area,'+' ${format_date.toString()}',
                      style: new TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w400,
                        ),
                      ),
                      new Text('$celsius'+'\u02DA'+'C', 
                      style: new TextStyle(
                        fontSize: 35.0,
                        fontWeight: FontWeight.w400,
                        ),
                      ),
                      new Text('Time $hour:$minute',
                        style: new TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w300
                        ),
                      ),
                      new Padding(
                        padding: new EdgeInsets.all(10.0),
                      )
                    ],
                  ),
                  new Spacer(
                    flex: 1,
                  ),
                  new Container(
                    child: new Icon(_categories[_categoryindex]['icon'],
                    size: 50.0,
                    color: Colors.yellow,
                    ),
                  ),
                  new Spacer(
                    flex: 1,
                  ),
                ],
              ),
          ),
          new Card(
            color: Colors.pink[200],
            child: Column(
              children: <Widget>[
                DropdownButton<String>(
                  value: dropdownValue,
                  onChanged: (String newValue) {
                    setState(() {
                      dropdownValue = newValue;
                      if(newValue == 'MinTemp'){
                        _graphdata = Mindata;
                      }
                      else{
                        _graphdata = Maxdata;
                      }
                    });
                  },
                  items: <String>['MaxTemp', 'MinTemp']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: _graphdata.length == 0 ? new CircularProgressIndicator() : 
                  new Sparkline(
                    data: _graphdata,
                    pointsMode: PointsMode.all,
                    pointSize: 12.0,
                    pointColor: Colors.white70,
                    lineColor: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          new Row(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width/2,
                child: new Card(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: new Column(
                      children: <Widget>[
                        new Text('Air Pressure',
                          style: new TextStyle(
                            fontSize: MediaQuery.of(context).size.width/20,
                          )
                        ),
                        new Padding(
                          padding: new EdgeInsets.all(10),
                        ),
                        new Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            new Text('$air_pressure',
                              style: new TextStyle(
                                fontSize: 32.0,
                              ),
                            ),
                            new Icon(MdiIcons.weatherWindy,size: MediaQuery.of(context).size.width/10,),
                          ],
                        ),
                        new Padding(
                          padding: new EdgeInsets.all(10.0)
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width/2,
                child: new Card(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: new Column(
                      children: <Widget>[
                        new Text('Humidity',
                          style: new TextStyle(
                            fontSize: MediaQuery.of(context).size.width/20,
                          )
                        ),
                        new Padding(
                          padding: new EdgeInsets.all(10),
                        ),
                        new Row(  
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            new Text('$humidity',
                              style: new TextStyle(
                                fontSize: 32.0,
                              ),
                            ),
                            new Icon(LineIcons.tachometer,size: MediaQuery.of(context).size.width/10,),
                          ],
                        ),
                        new Padding(
                          padding: new EdgeInsets.all(10.0)
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          new Row(
            children: <Widget>[
              new Container(
                width: MediaQuery.of(context).size.width/2,
                child: new Card(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: new Column(
                      children: <Widget>[
                        new Text('Wind Speed',
                          style: new TextStyle(
                            fontSize: MediaQuery.of(context).size.width/20,
                          )
                        ),
                        new Padding(
                          padding: new EdgeInsets.all(10),
                        ),
                        new Row(  
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            new Text('$wind_speed',
                              style: new TextStyle(
                                fontSize: 32.0,
                              ),
                            ),
                            GestureDetector(
                              onTap: (){
                                print(MediaQuery.of(context).size.width/10);
                              },
                              child: new Icon(MdiIcons.weatherWindy,size: MediaQuery.of(context).size.width/10,)),
                          ],
                        ),
                        new Padding(
                          padding: new EdgeInsets.all(10.0)
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              new Container(
                width: MediaQuery.of(context).size.width/2,
                child: new Card(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: new Column(
                      children: <Widget>[
                        new Text('Predicted Temperature',
                          style: new TextStyle(
                            fontSize: MediaQuery.of(context).size.width/20,
                          )
                        ),
                        new Padding(
                          padding: new EdgeInsets.all(10),
                        ),
                        new Row(  
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            new Text('$predicted_temp',
                              style: new TextStyle(
                                fontSize: 32.0,
                              ),
                            ),
                            GestureDetector(
                              onTap: (){
                                print(MediaQuery.of(context).size.width/10);
                              },
                              child: new Icon(MdiIcons.thermometer,size: MediaQuery.of(context).size.width/10,)),
                          ],
                        ),
                        new Padding(
                          padding: new EdgeInsets.all(10.0)
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          new Container(
            width: MediaQuery.of(context).size.width,
            height: 200,
            child: Card(
              child: GoogleMap(
                mapType: MapType.hybrid,
                initialCameraPosition: _kGooglePlex,
                onMapCreated: (GoogleMapController controller) {
                  _completer.complete(controller);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
