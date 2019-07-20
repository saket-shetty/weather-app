import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:line_icons/line_icons.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:sensegrass/data/columnchartdata.dart';


class changecolumnchart extends StatefulWidget {
  @override
  _changecolumnchartState createState() => _changecolumnchartState();
}

class _changecolumnchartState extends State<changecolumnchart> {

  var name, value, health;

  int newvalue;

  final storage = new FlutterSecureStorage();

  int _healthColor;

  final DatabaseReference ref = FirebaseDatabase.instance.reference();

  List<columnchartdata> allData = [];

  bool longpressup = false;

  Future get_data() async{
    name = await storage.read(key: 'name');
    value = await storage.read(key: 'value');
    health = await storage.read(key: 'health');
    // newvalue = value.toInt();    
    value = int.parse(value);

    setState(() {
    });
  }

  void longpress(){
    value = value +1;
    print('$value');
    Timer(Duration(milliseconds: 300), (){
      if(longpressup !=true){
      longpress();
      }
    });
    setState(() {
      
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    get_data();
    super.initState();

    allData.add(columnchartdata('Soil PH', 7, 'ACCEPTABLE'));
    allData.add(columnchartdata('NDVI', 90, 'NOT ACCEPTABLE'));
    allData.add(columnchartdata('NITROGEN', 7, 'ACCEPTABLE'));
    allData.add(columnchartdata('Soil Humidity', 90, 'NOT ACCEPTABLE'));
    allData.add(columnchartdata('Water Stress', 7, 'ACCEPTABLE'));
    allData.add(columnchartdata('Water Stress', 7, 'ACCEPTABLE'));
    allData.add(columnchartdata('Water Stress', 7, 'ACCEPTABLE'));
    allData.add(columnchartdata('Water Stress', 90, 'NOT ACCEPTABLE'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Color.fromRGBO(64, 75, 96, .9),

      appBar: new AppBar(
        title: new Text('$name',
          style: new TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w300,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurpleAccent,
      ),

      body: Center(
        child: new Column(
          children: <Widget>[
            new Padding(padding: new EdgeInsets.all(10.0),),
            new Text('$name',
              style: new TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            new Padding(padding: new EdgeInsets.all(10.0),),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[

                new IconButton(
                  onPressed: (){
                    value = value - 1;
                    if(value <= 7 && value >=0 ){
                      health = 'ACCEPTABLE';
                    }
                    else if(value <=-1){
                      health = 'Sorry, value cannot be in negative';
                      value = 0;
                    }
                    setState(() {
                      
                    });
                  },
                  icon: Icon(LineIcons.minus_circle,
                    color: Colors.white,
                    size: 30,
                  ),
                ),

                new Padding(padding: new EdgeInsets.all(10.0),),

                new Text('$value',
                  style: new TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),

                new Padding(padding: new EdgeInsets.all(10.0),),

                new GestureDetector(

                  onLongPressUp: (){

                    print('this is up');
                    longpressup = true;
                    setState(() {
                      
                    });
                  },

                  onLongPress: (){
                    longpressup = false;
                    health = 'ACCEPTABLE';
                    if(value <= 100){
                      longpress();
                    }
                  },

                  onTap: (){
                    health = 'ACCEPTABLE';

                    if(value <= 100){
                      value = value + 1;
                    }
                    setState(() {
                      
                    });
                  },

                  child: Icon(LineIcons.plus_circle,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
                

              ],
            ),

            new Padding(padding: new EdgeInsets.all(10.0),),

            new Container(
              width: 80,
              height: 7.0,
              child: LinearProgressIndicator(
                  backgroundColor: Color.fromRGBO(209, 224, 224, 0.2),
                  value: value/100,
                  valueColor: AlwaysStoppedAnimation(Colors.green),
              ),
            ),

            new Padding(padding: new EdgeInsets.all(10.0),),

            new Text('$health',
              style: new TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),

            new Padding(padding: new EdgeInsets.all(10.0),),

            new Expanded(
              child: new ListView.builder(
                itemCount: allData.length,
                itemBuilder: (_, index){
                  return UI(

                    allData[index].name,
                    allData[index].value,
                    allData[index].health
                  );
                },
              ),
            ),

          ],
        ),
      ),
    );
  }

  Widget UI(String UIname, int UIvalue, var UIhealth){

    if(UIhealth == 'ACCEPTABLE'){
      _healthColor = 0xff7CFC00;
    }
    else{
      _healthColor = 0xFFFF0000;
    }

    return Card(
        elevation: 8.0,
        child: new Container(
          
          decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.only(right:8.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Text('$UIname',
                        style: new TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                        ),
                      ),

                      new Padding(padding: new EdgeInsets.all(2.0),),


                      new Container(
                        width: 80,
                        height: 7.0,
                        child: LinearProgressIndicator(
                            backgroundColor: Color.fromRGBO(209, 224, 224, 0.2),
                            value: UIvalue/100,
                            valueColor: AlwaysStoppedAnimation(Colors.green),
                        ),
                      ),

                      new Padding(padding: new EdgeInsets.all(2.0),),
                      new Text('Value : $UIvalue',
                        style: new TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w400,
                          color: Colors.white
                        ),
                      ),

                    ],
                  ),
                ),
                
                new Text('$UIhealth',
                  style: new TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w400,
                    color: Color(_healthColor),
                  ),
                ),
                InkWell(
                  onTap: (){
                    // send_data(name, value, health);
                    // Navigator.pop(context);
                    // Navigator.push(context, MaterialPageRoute(builder: (context)=>changecolumnchart()));
                    name = UIname;
                    value = UIvalue;
                    health = UIhealth;

                    if(UIhealth == 'ACCEPTABLE'){
                      _healthColor = 0xff7CFC00;
                    }
                    else{
                      _healthColor = 0xFFFF0000;
                    }

                    setState(() {
                      
                    });

                  },
                  child: new Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }
}