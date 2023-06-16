import 'dart:async';
import 'package:flutter/material.dart';
import 'package:life_hub/Widgets/AnalogClockArm.dart';
import 'package:life_hub/Widgets/widgetSetup.dart';

//Klokken lige nu
DateTime now = DateTime.now();

@override
Widget analogClockWidget(BuildContext context) {
  List<Widget> clocklines = [];
  for (var i = 0; i < 13; i++) {
    clocklines.add(analogClockNumbersWidget(context, i));
  }
  return StreamBuilder(
      stream: Stream.periodic(const Duration(seconds: 1)),
      builder: ((context, snapshot) {
        now = DateTime.now();
        String minute = now.minute.toString();
        String second = now.second.toString();
        if (second.length == 1) {
          // make so it is 12.00 instead of 12.0
          second = '0$second';
        }
        if (minute.length == 1) {
          // make so it is 12.00 instead of 12.0
          minute = '0$minute';
        }
        return Container(
          height: getWidth(context) * 0.47,
          width: getWidth(context) * 0.47,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color.fromARGB(255, 0, 0, 0),
          ),
          child: Padding(
              padding: EdgeInsets.all(4),
              child: Container(
                decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromARGB(255, 240, 251, 255)),
                child: Stack(
                  children: [
                    Stack(
                      children: clocklines,
                    ),
                    // Hour hand
                    analogClockArmWidget(context, now, 1),
                    // Minute hand
                    analogClockArmWidget(context, now, 2),
                    // Second hand
                    analogClockArmWidget(context, now, 3),
                    // Center dot
                    Center(
                      child: Container(
                        height: getWidth(context) * 0.015,
                        width: getWidth(context) * 0.015,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color.fromARGB(255, 0, 0, 0)),
                      ),
                    ),
                  ],
                ),
              )),
        );
      }));
}
