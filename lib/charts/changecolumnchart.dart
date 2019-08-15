import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:line_icons/line_icons.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:sensegrass/data/columnchartdata.dart';
import 'package:csv/csv.dart';


class changecolumnchart extends StatefulWidget {
  @override
  _changecolumnchartState createState() => _changecolumnchartState();
}

class _changecolumnchartState extends State<changecolumnchart> {

    List allchemical = [];

  int _healthColor;

  bool show_diff_page = false;

  List<List<dynamic>> data = [];

  var allvaluechemical=[];

  var allvaluehigh = [];
  var allvaluelow = [];

  var name, value, health, high, low;

  double newvalue;

  final storage = new FlutterSecureStorage();

  // int _healthColor;

  final DatabaseReference ref = FirebaseDatabase.instance.reference();

  List<columnchartdata> allData = [];

  bool longpressup = false;

  Color fontcolor = Colors.black;

  Future get_data() async{
    name = await storage.read(key: 'name');
    value = await storage.read(key: 'value');
    health = await storage.read(key: 'health');
    high = await storage.read(key: 'high-value');
    low = await storage.read(key: 'low-value');
    // newvalue = value.toInt();
    newvalue = double.parse(value);
    high = double.parse(high);
    low = double.parse(low);

    setState(() {
    });
  }

  void longpress(){
    newvalue = newvalue +1;
    print('$newvalue');
    Timer(Duration(milliseconds: 300), (){
      if(longpressup !=true){
        longpress();
      }
    });
    setState(() {
      
    });
  }


  loadAsset() async {
    final myData = await rootBundle.loadString("asset/dataset.csv");
    List<List<dynamic>> csvTable = CsvToListConverter().convert(myData);

    data = csvTable;
    print('${data[1].length}');

    print('Data : ${data[0][2]}');


  int z=1;

  for(var x=1; x<data[1].length; x++){
    num total = 0;
    num highnumber = data[x][z];
    num lownumber = data[x][z];
    for(var y=1; y<280; y++){
      if(highnumber < data[y][x]){
        highnumber = data[y][x];
      }
      else if(lownumber > data[y][x]){
        lownumber = data[y][x];
        print('lower :$lownumber');
      }
      // print('${data[y][x]}');
      total = total + data[y][x];
    }
    z++;
    total = total/280;
    allvaluechemical.add(total.toStringAsFixed(2));
    allvaluehigh.add(highnumber.toStringAsFixed(2));
    allvaluelow.add(lownumber.toStringAsFixed(2));

  }


    for( var x=1; x<data[1].length; x++){
      allchemical.add(data[0][x].toString());
    }
    setState(() {
      
    });

  }

  @override
  void initState() {
    // TODO: implement initState
    get_data();
    loadAsset();
    super.initState();
  }

  Future send_data(var name, var value, var health, var high, var low)async{
    await storage.write(key: 'name', value: name.toString());
    await storage.write(key: 'value', value: value.toString());
    await storage.write(key: 'health', value: health.toString());
    await storage.write(key: 'high-value', value: high.toString());
    await storage.write(key: 'low-value', value: low.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      // backgroundColor: Color.fromRGBO(64, 75, 96, .9),

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


            
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                new Column(
                  children: <Widget>[
                    new Text('$name',
                      style: new TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    new Padding(padding: new EdgeInsets.all(5.0),),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[

                        new IconButton(
                          onPressed: (){
                            newvalue = newvalue - 1.00;
                            newvalue.toStringAsExponential(2);
                            // double.parse(newvalue);
                            if(newvalue >= low && newvalue <= high){
                              fontcolor = Colors.green;
                            }
                            else if(newvalue < low || newvalue > high){
                              fontcolor = Colors.red;
                            }
                            else if(newvalue <=-1){
                              health = 'Sorry, value cannot be in negative';
                              newvalue = 0;
                            }
                            setState(() {
                              newvalue.toStringAsExponential(2);
                              
                            });
                          },
                          icon: Icon(LineIcons.minus_circle,
                            color: Colors.black,
                            size: 30,
                          ),
                        ),

                        new Padding(padding: new EdgeInsets.all(10.0),),

                        new Text('${newvalue.toStringAsFixed(2)}',
                          style: new TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: fontcolor,
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
                            if(value <= high){
                              longpress();
                            }
                          },

                          onTap: (){
                            health = 'ACCEPTABLE';
                              newvalue = newvalue + 1.0;

                            if(newvalue <= high && newvalue >= low){
                              fontcolor = Colors.green;
                            }
                            else if(newvalue > high || newvalue < low){
                              fontcolor = Colors.red;
                            }
                            setState(() {
                            });
                          },

                          child: Icon(LineIcons.plus_circle,
                            color: Colors.black,
                            size: 30,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                 new Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Text('${high}',
                      style: new TextStyle(
                        fontSize: 18.0
                      ),
                    ),
                    new Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Icon(
                          Icons.arrow_upward,
                          size: 22.0,
                        ),
                        new Icon(
                          Icons.arrow_downward,
                          size: 22.0,
                        ),
                      ],
                    ),
                    new Text('${low}',
                      style: new TextStyle(
                        fontSize: 18.0
                      ),
                    ),
                  ],
                ),

              ],
            ),

            new Padding(padding: new EdgeInsets.all(05.0),),

            new Expanded(
              child: new ListView.builder(
                itemCount: 11,
                itemBuilder: (_, index){
                  return UI(
                    index
                    // allData[index].name,
                    // allData[index].value,
                    // allData[index].health
                  );
                },
              ),
            ),

          ],
        ),
      ),
    );
  }

  Widget UI(int index){

    // if(UIhealth == 'ACCEPTABLE'){
    //   _healthColor = 0xff7CFC00;
    // }
    // else{
    //   _healthColor = 0xFFFF0000;
    // }

    return Padding(
      padding: const EdgeInsets.only(left:5.0,top:5.0, bottom: 5.0),
      child: Center(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            new Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
                    onTap: (){
                      send_data(allchemical[index].toString(), allvaluechemical[index], allvaluehigh[index].toString(), allvaluehigh[index].toString(), allvaluelow[index].toString());
                      
                      // send_data(allchemical[index].toString(), allvaluechemical[index], allvaluehigh[index].toString());
                      Navigator.pop(context, MaterialPageRoute(builder: (context)=>changecolumnchart()));
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>changecolumnchart()));
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width/2-15,
                      height: MediaQuery.of(context).size.width/2-30,
                      decoration: new BoxDecoration(
                        boxShadow: [
                          new BoxShadow(
                            color: Colors.grey[400],
                            blurRadius: 10.0,
                          ),
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      ),

                      child: Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            new Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                new Text('${allchemical[index]}',
                                  style: new TextStyle(
                                    fontSize: MediaQuery.of(context).size.width/15,
                                    fontWeight: FontWeight.w500
                                  )
                                ),
                                new Padding(
                                  padding: new EdgeInsets.all(5.0),
                                ),
                                new Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    new Text('${allvaluechemical[index]}'+' Unit',
                                      style: new TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.w700
                                      ),
                                    ),
                                    new Padding(
                                      padding: new EdgeInsets.all(5.0)
                                    ),
                                    
                                    new Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        new Text('${allvaluehigh[index]}'),
                                        new Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            new Icon(
                                              Icons.arrow_upward,
                                              size: 20.0,
                                            ),
                                            new Icon(
                                              Icons.arrow_downward,
                                              size: 20.0,
                                            ),
                                          ],
                                        ),
                                        new Text('${allvaluelow[index]}'),
                                      ],
                                    ),

                                  ],
                                ),
                                new Padding(
                                  padding: new EdgeInsets.all(10.0)
                                ),
                              ],
                            ),

                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),


              new Padding(
                padding: new EdgeInsets.all(5.0),
              ),

              new Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
                    onTap: (){
                      send_data(allchemical[index+11].toString(), allvaluechemical[index+11], allvaluehigh[index+11].toString(), allvaluehigh[index+11].toString(), allvaluelow[index+11].toString());

                      // send_data(allchemical[index+11].toString(), allvaluechemical[index+11], allvaluehigh[index+11].toString());
                      Navigator.pop(context, MaterialPageRoute(builder: (context)=>changecolumnchart()));                      
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>changecolumnchart()));
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width/2-15,
                      height: MediaQuery.of(context).size.width/2-30,
                      decoration: new BoxDecoration(

                        boxShadow: [
                          new BoxShadow(
                            color: Colors.grey[400],
                            blurRadius: 10.0,
                          ),
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      ),

                      child: Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            new Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                new Text('${allchemical[index+11]}',
                                  style: new TextStyle(
                                    fontSize: MediaQuery.of(context).size.width/15,
                                    fontWeight: FontWeight.w500
                                  )
                                ),
                                new Padding(
                                  padding: new EdgeInsets.all(5.0),
                                ),
                                new Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    new Text('${allvaluechemical[index+11]}'+' Unit',
                                      style: new TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.w700
                                      ),
                                    ),
                                    new Padding(
                                      padding: new EdgeInsets.all(5.0)
                                    ),
                                    
                                    new Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        new Text('${allvaluehigh[index+11]}'),
                                        new Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            new Icon(
                                              Icons.arrow_upward,
                                              size: 20.0,
                                            ),
                                            new Icon(
                                              Icons.arrow_downward,
                                              size: 20.0,
                                            ),
                                          ],
                                        ),
                                        new Text('${allvaluelow[index+11]}'),
                                      ],
                                    ),

                                  ],
                                ),
                                new Padding(
                                  padding: new EdgeInsets.all(10.0)
                                ),
                              ],
                            ),

                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),



              
            ],
          ),
      ),
      );
  }
}