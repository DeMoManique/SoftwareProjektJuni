import 'dart:async';
import 'package:flutter/material.dart';
import 'package:life_hub/Widgets/widgetShapes.dart';
import 'package:life_hub/Widgets/widgetSetup.dart';

//Klokken lige nu
DateTime now = DateTime.now();

@override
Widget analogClockWidget(BuildContext context) {
  return StreamBuilder(
      stream: Stream.periodic(const Duration(seconds: 1)),
      builder: ((context, snapshot) {
        now = DateTime.now();
        String minute = now.minute.toString();
        String second = now.second.toString();
        if (second.length == 1) {
          // make so it is 12.00 instead of 12.0
          second = '0' + second;
        }
        if (minute.length == 1) {
          // make so it is 12.00 instead of 12.0
          minute = '0' + minute;
        }
        return Container(
          height: getHeight(context) * 0.47,
          width: getWidth(context) * 0.47,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color.fromARGB(255, 0, 0, 0),
          ),
          child: Padding(
              padding: EdgeInsets.all(4),
              child: Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromARGB(255, 240, 251, 255)),
                    child: RotatedBox(
                      quarterTurns: 3,
                      
                    ),
              )),
              
        );
      }));
}
