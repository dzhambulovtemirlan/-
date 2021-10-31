import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      body: Crossing(),
    ),
  ));
}

class Crossing extends StatefulWidget {
  @override
  _CrossingState createState() => _CrossingState();
}

class _CrossingState extends State<Crossing> {
  TrafficStatus trafficStatus = TrafficStatus.go;

  void onPedestrianLightPressed() {
    changeToStopIfSafe();
  }

  void changeToStopIfSafe() {
    setState(() {
      trafficStatus = TrafficStatus.stopIfSafe;
    });

    Timer(Duration(seconds: 2), changeToStop);
  }

  void changeToStop() {
    setState(() {
      trafficStatus = TrafficStatus.stop;
    });

    Timer(Duration(seconds: 5), changeToPrepareToGo);
  }

  void changeToPrepareToGo() {
    setState(() {
      trafficStatus = TrafficStatus.prepareToGo;
    });

    Timer(Duration(seconds: 1), changeToGo);
  }

  void changeToGo() {
    setState(() {
      trafficStatus = TrafficStatus.go;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(children: [
          Container(
            child: TrafficLight(trafficStatus),
          ),
            Container(
              margin: EdgeInsets.only(right: 80),
              child: 
          PedestrianLight(
              
            trafficStatus == TrafficStatus.stop,
            onPedestrianLightPressed,
            )
          ),
        ])
      ],
    );
  }
}

class PedestrianLight extends StatelessWidget {
  PedestrianLight(this.isSafeToCross, this.onPressed);

  final bool isSafeToCross;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(left: 80),
          child: RaisedButton(
            onPressed: onPressed,
            child: Text('Нажми'),
          ),
        ),
      ],
    );
  }
}

class TrafficLight extends StatelessWidget {
  TrafficLight(this.trafficStatus);

  final TrafficStatus trafficStatus;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 150),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.black,
          ),
          child: Column(
            children: <Widget>[
              Container(
                height: 70,
                width: 70,
                margin: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: trafficStatus == TrafficStatus.stop ||
                          trafficStatus == TrafficStatus.prepareToGo
                      ? Colors.red
                      : Colors.grey,
                  shape: BoxShape.circle,
                ),
              ),
              Container(
                height: 70,
                width: 70,
                margin: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: trafficStatus == TrafficStatus.prepareToGo ||
                          trafficStatus == TrafficStatus.stopIfSafe
                      ? Colors.amber
                      : Colors.grey,
                  shape: BoxShape.circle,
                ),
              ),
              Container(
                height: 70,
                width: 70,
                margin: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: trafficStatus == TrafficStatus.go
                      ? Colors.green
                      : Colors.grey,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 80,
          width: 10,
          color: Colors.grey,
          margin: EdgeInsets.only(),
        ),
        Container(
          height: 5,
          width: 70,
          color: Colors.black,
          margin: EdgeInsets.only(),
        ),
      ],
    );
  }
}

enum TrafficStatus {
  stop,
  prepareToGo,
  go,
  stopIfSafe,
}
