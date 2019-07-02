import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';


class weather extends StatefulWidget {
  @override
  _weatherState createState() => _weatherState();
}

class _weatherState extends State<weather> {

  var location, date, temperature, time, icon, description;

  final storage = new FlutterSecureStorage();


  @override
  void initState() {
    // TODO: implement initState
    get_weather_location();
    super.initState();
  }

  Future get_weather_location() async{
    location = await storage.read(key: 'location');
    date = await storage.read(key: 'date');
    temperature = await storage.read(key: 'temperature');
    time = await storage.read(key: 'time');
    description = await storage.read(key: 'descrip');
    
    setState((){});
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: new Container(
          child: new Column(
            children: <Widget>[
              new Card(
              color: Colors.blue[200],
                child: Column(
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
                              fontWeight: FontWeight.w400,
                              ),
                            ),
                            new Text('$temperature'+'\u02DA'+'C', 
                            style: new TextStyle(
                              fontSize: 35.0,
                              fontWeight: FontWeight.w400,
                              ),
                            ),
                            new Text('Time $time',
                              style: new TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.w300
                              ),
                            ),
                          ],
                        ),
                        new Spacer(
                          flex: 2,
                        ),
                        new Container(
                          child: new Icon(Icons.mode_edit,
                          size: 50.0,
                          color: Colors.yellow,
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
                          fontSize: 16.0
                        ),
                      ),
                    ),
                    new Padding(
                      padding: new EdgeInsets.all(6.0),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}