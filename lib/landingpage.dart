import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather/weather.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';
import 'package:geocoder/geocoder.dart';
import 'package:flutter_sparkline/flutter_sparkline.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class landing extends StatefulWidget {
  @override
  final Widget child;

  landing({Key key, this.child}) : super(key: key);
  _landingState createState() => _landingState();
}

class _landingState extends State<landing> {

  Completer<GoogleMapController> _completer = Completer();
  

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

  List<double> Maxdata = [];
  List<double> Mindata = [];
  List<double> _graphdata;
  var dropdownValue= 'MaxTemp';

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

  // Future<void> _goToTheLake() async {
  //   final GoogleMapController controller = await _completer.future;
  //   controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(37.43296265331129,-122.08832357078792))));
  // }

  // static final CameraPosition _kLake = CameraPosition(
  //     bearing: 192.8334901395799,
  //     target: LatLng(37.43296265331129, -122.08832357078792),
  //     tilt: 59.440717697143555,
  //     zoom: 19.151926040649414);

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

    final coordinates = new Coordinates(weather.latitude, weather.longitude);
    addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
    first = addresses.first;

    List<Weather> forecasts = await weatherStation.fiveDayForecast();

    for(var x in forecasts){
      Maxdata.add(await x.tempMax.celsius.ceilToDouble());
      if(Maxdata.length == 20){
        break;
      }
    }    

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

  Future get_date() async{
    format_date = new DateFormat.yMMMMd("en_US").format(now);
    hour = now.hour;
    minute = now.minute;
    setState((){});
  }

  Future get_time() async{
    var timeOfDay = now.hour;
    if(timeOfDay >= 0 && timeOfDay < 12){
        //morning      
        _categoryindex = 0;
    }else if(timeOfDay >= 12 && timeOfDay < 16){
        //afternon
        _categoryindex = 0;
    }else if(timeOfDay >= 16 && timeOfDay < 21){
        //evening
        _categoryindex = 1;
    }else if(timeOfDay >= 21 && timeOfDay < 24){
        //night
        _categoryindex = 2;
    }
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getweather();
    get_date();
    get_time();
    // geolocation();
    _graphdata = Maxdata;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Column(
        children: <Widget>[
          new Card(
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
                  Expanded(
                    child: new Icon(_categories[_categoryindex]['icon'],
                    size: 50.0,
                    color: Colors.yellow,
                    ),
                  ),
                ],
              ),
          ),
          new Card(
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
                    pointSize: 8.0,
                    pointColor: Colors.amber,
                    lineColor: Colors.red,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
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
