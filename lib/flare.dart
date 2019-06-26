import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';

class flare extends StatefulWidget {
  @override
  _flareState createState() => _flareState();
}

class _flareState extends State<flare> {
  String yolo = 'ANIM';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
              height: 100,
              width: 100,
              child: FlareActor(
                "asset/anim.flr",
                alignment: Alignment.center,
                fit: BoxFit.contain,
                animation: yolo,
              ),
            ),
    );
  }
}