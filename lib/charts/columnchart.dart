import 'package:flutter/material.dart';
import 'package:sensegrass/charts/changecolumnchart.dart';
import 'package:sensegrass/data/columnchartdata.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class columnchart extends StatefulWidget {
  @override
  _columnchartState createState() => _columnchartState();
}

class _columnchartState extends State<columnchart> {

  List<columnchartdata> allData = [];

  int _healthColor;

  bool show_diff_page = false;

  final storage = new FlutterSecureStorage();

  @override
  void initState() {
    // TODO: implement initState

    allData.add(columnchartdata('Soil PH', 7, 'ACCEPTABLE'));
    allData.add(columnchartdata('NDVI', 90, 'NOT ACCEPTABLE'));
    allData.add(columnchartdata('NITROGEN', 7, 'ACCEPTABLE'));
    allData.add(columnchartdata('Soil Humidity', 90, 'NOT ACCEPTABLE'));
    allData.add(columnchartdata('Water Stress', 7, 'ACCEPTABLE'));
    allData.add(columnchartdata('Water Stress', 7, 'ACCEPTABLE'));
    allData.add(columnchartdata('Water Stress', 7, 'ACCEPTABLE'));
    allData.add(columnchartdata('Water Stress', 90, 'NOT ACCEPTABLE'));

    super.initState();
  }

  Future send_data(var name, int value, var health)async{
    await storage.write(key: 'name', value: name.toString());
    await storage.write(key: 'value', value: value.toString());
    await storage.write(key: 'health', value: health.toString());
  }


  @override
  Widget build(BuildContext context) {
    return allData.length == 0 ? new CircularProgressIndicator() :
    
     new ListView.builder(
      itemCount: allData.length,
      itemBuilder: (_, index){
        return UI(

          allData[index].name,
          allData[index].value,
          allData[index].health
        );
      },
    );
    
  }

  Widget UI(String name, int value, var health){

    if(health == 'ACCEPTABLE'){
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
                      new Text('$name',
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
                            value: value/100,
                            valueColor: AlwaysStoppedAnimation(Colors.green),
                        ),
                      ),

                      new Padding(padding: new EdgeInsets.all(2.0),),
                      new Text('Value : $value',
                        style: new TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w400,
                          color: Colors.white
                        ),
                      ),

                    ],
                  ),
                ),
                
                new Text('$health',
                  style: new TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w400,
                    color: Color(_healthColor),
                  ),
                ),
                InkWell(
                  onTap: (){
                    send_data(name, value, health);
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>changecolumnchart()));
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