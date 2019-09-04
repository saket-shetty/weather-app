import 'dart:async';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';


class profile_sensor_data extends StatefulWidget {
  @override
  _profile_sensor_dataState createState() => _profile_sensor_dataState();
}

class _profile_sensor_dataState extends State<profile_sensor_data> {

  final storage = new FlutterSecureStorage();
  Completer<WebViewController> _controller = Completer<WebViewController>();

  String url = 'https://apps.sentinel-hub.com/sentinel-playground/';

  var lat,long;

  

  @override
  void initState() {
    // TODO: implement initState
    print('profile crops');
    get_lat_long();
    super.initState();
  }

  Future get_lat_long() async{
    lat = await storage.read(key: 'lat');
    long = await storage.read(key: 'long');

    url = 'https://apps.sentinel-hub.com/sentinel-playground/';
    print('url $url');
    setState(() {});
  }
  
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: Padding(
        padding: new EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: WebView(
          initialUrl: '$url',
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
              _controller.complete(webViewController);
            },
          ),
        ),
      ),
    );
  }
}