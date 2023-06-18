import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
      Navigator.pushNamed(context, '/speedScreen');
    },
  );
}

class SpeedScreen extends StatefulWidget {
  @override
  State<SpeedScreen> createState() => _SpeedScreen();
  const SpeedScreen({super.key});
}

class _SpeedScreen extends State<SpeedScreen> {
  bool showSpeed = false;
  bool ifStopIsClicked = false;
  String _speedKph = "0.0";

  @override
  void initState() {
    super.initState();
    _getLocation();
    showSpeed = false;
  }

  Future<void> saveUserTopSpeed() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final userRef =
            FirebaseFirestore.instance.collection('users').doc(user.uid);
        final userData = await userRef.get();

        if (userData.exists && userData.get('topSpeed') < topSpeed) {
          if (topSpeed >= 50.0) {
          } else {
            // User already exists, update their topSpeed field
            await userRef.update({'topSpeed': topSpeed});
          }
        } else if (!userData.exists) {
          // User doesn't exist, create a new user document in firebase
          await userRef.set({'name': user.displayName, 'topSpeed': topSpeed});
        }
      }
    } catch (e) {}
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
    } else if (permission == LocationPermission.deniedForever) {
    } else {
      //permission granted
      Geolocator.getPositionStream(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.best,
          distanceFilter: 10,
        ),
      ).listen((position) {
        // speed in kph
        double speedKph = position.speed * 3.6;
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
      if (topSpeed >= 50.0) {}
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
            onTap: () {
              Navigator.of(context).pushNamed('/leaderboardScreen');
            },
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
                  saveUserTopSpeed();
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Top Speed'),
                      content: verifySpeed(),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            topSpeed = 0.0;
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

  Widget verifySpeed() {
    if (topSpeed >= 50.0) {
      topSpeed = 0;
      return Text('Your speed was sus');
    }
    if (topSpeed <= 50.0) {
      return Text('Your top speed was: ${topSpeed.toStringAsFixed(2)} km/h');
    } else {
      return Text('');
    }
  }
}
