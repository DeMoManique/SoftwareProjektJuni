import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:life_hub/Widgets/widgetShapes.dart';

@override
Widget widgetRun(BuildContext context) {
  return HoriRectangle(
    context,
    color: const Color.fromARGB(255, 28, 52, 150),
    child: const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "IShowSpeed",
          style: TextStyle(
              fontSize: 50, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ],
    ),
    function: () {
      Navigator.pushNamed(context, '/speedPage');
    },
  );
}

class SpeedPage extends StatefulWidget {
  @override
  State<SpeedPage> createState() => _SpeedPage();
  const SpeedPage({super.key});
}

class _SpeedPage extends State<SpeedPage> {
  bool showSpeed = false;
  bool ifStopIsClicked = false;
  String _speedKph = "";

  @override
  void initState() {
    super.initState();
    _getLocation();
    showSpeed = false;
  }

  String text = "Start";
  int time = 3;
  List<double> speeds = [];
  double topSpeed = 0;

  void startTimer() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (time > 0) {
          text = time.toString();
          time--;
        } else {
          showSpeed = true;
          text = "Stop";
          timer.cancel();
        }
      });
    });
  }

  void _getLocation() async {
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Handle the case where the user has denied location permission
    } else if (permission == LocationPermission.deniedForever) {
      // Handle the case where the user has permanently denied location permission
    } else {
      // Location permission has been granted, start receiving location updates
      Geolocator.getPositionStream(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.best,
          distanceFilter: 10,
        ),
      ).listen((position) {
        double speedKph =
            position.speed * 3.6; // This is your speed in kilometers per hour
        if (speedKph > topSpeed) {
          topSpeed = speedKph;
        }
        setState(() {
          _speedKph = speedKph.toStringAsFixed(2);
        });
      });
    }
  }

  void stopRecordingSpeed() {
    setState(() {
      _speedKph = '0';
      text = "Start";
      showSpeed = false;
      time = 3;
    });
  }

  @override
  build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(67, 176, 176, 1),
      appBar: AppBar(forceMaterialTransparency: true, actions: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
          child: GestureDetector(
            onTap: () {},
            child: Icon(Icons.leaderboard),
          ),
        )
      ]),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: GestureDetector(
              child: Circle(text: text),
              onTap: () {
                if (text == "Start") {
                  startTimer();
                }
                if (text == "Stop") {
                  stopRecordingSpeed();
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Top Speed'),
                      content: Text(
                          'Your top speed was: ${topSpeed.toStringAsFixed(2)} km/h'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            topSpeed = 0;
                          },
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
          ),
          if (showSpeed)
            Text(
              '$_speedKph km/h',
              style: const TextStyle(fontSize: 48.0),
            ),
        ],
      ),
    );
  }
}
