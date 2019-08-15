import 'package:flutter/material.dart';
// import 'package:flutter_web_view/flutter_web_view.dart';
import 'package:webview_flutter/webview_flutter.dart';

class satellite extends StatefulWidget {
  @override
  _satelliteState createState() => _satelliteState();
}

class _satelliteState extends State<satellite> {

  var _url = 'https://www.cropx.com/';
  final _key = UniqueKey();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  // Future geturl() async{
  //   await _url = 'www.google.com';
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
      body: Container(
        padding: new EdgeInsets.only(top:MediaQuery.of(context).padding.top),
        // width: 50,
        // height: 50,
        child: new WebView(
          debuggingEnabled: true,
          key: _key,
          javascriptMode: JavascriptMode.unrestricted,
          initialUrl: 'http://saketshetty.000webhostapp.com',
        ),  
      ),
    );
  }
}