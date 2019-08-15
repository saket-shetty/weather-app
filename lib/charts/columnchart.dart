import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:csv/csv.dart';
import 'package:sensegrass/charts/changecolumnchart.dart';
import 'package:sensegrass/weather/airpressure.dart';
import 'package:flutter/services.dart' show rootBundle;


class columnchart extends StatefulWidget {
  @override
  _columnchartState createState() => _columnchartState();
}

class _columnchartState extends State<columnchart> {

  List allchemical = [];

  int _healthColor;

  bool show_diff_page = false;

  List<List<dynamic>> data = [];

  var allvaluechemical=[];

  var allvaluehigh = [];
  var allvaluelow = [];

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

  final storage = new FlutterSecureStorage();

  @override
  void initState() {
    // TODO: implement initState

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
    return Center(
      child: allchemical.length == 0 ? new CircularProgressIndicator() :
      
       new ListView.builder(
        itemCount: 11,
        itemBuilder: (_, index){
          return UI(
            index
            // allchemical[index],
            // allvaluechemical[index],
            // allvaluehigh[index],
            // allvaluelow[index]
          );
        },
      ),
    );
  }
// String name, String value, var high, var low
  Widget UI(int index){



    return  Padding(
      padding: const EdgeInsets.only(top:5.0, bottom: 5.0),
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
      );

  }
}