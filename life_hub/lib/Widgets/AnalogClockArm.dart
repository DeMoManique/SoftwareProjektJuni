import 'package:flutter/material.dart';
import 'package:life_hub/Widgets/widgetSetup.dart';

Widget analogClockArmWidget(BuildContext context, DateTime now, int type) {
  late double hourlength;
  late double angles;
  late Color color;

  if (type == 1) {
    // Hour hand
    angles = 2 * 3.14 * now.hour / 12 + 2 * 3.14 * now.minute / 720;
    hourlength = getWidth(context) * 0.06;
    color = Color.fromARGB(255, 0, 0, 0);
  } else if (type == 2) {
    // Minute hand
    angles = 2 * 3.14 * now.minute / 60 + 2 * 3.14 * now.second / 3600;
    hourlength = getWidth(context) * 0.1;
    color = Color.fromARGB(255, 0, 0, 0);
  } else {
    // Second hand
    angles = 2 * 3.14 * now.second / 60;
    hourlength = getWidth(context) * 0.18;
    color = Color.fromARGB(255, 34, 182, 113);
  }

  return RotatedBox(
      // it is 2 so when it is 12 it is vertical
      quarterTurns: 2,
      child: Transform.rotate(
        angle: angles,
        child: Transform.translate(
          offset: Offset(0, hourlength / 2),
          child: Center(
            child: Container(
              height: hourlength,
              width: 4,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.all(Radius.circular(4)),
              ),
            ),
          ),
        ),
      ));
}

Widget analogClockNumbersWidget(BuildContext context, int i) {
  late double hourlength;
  late double offset;
  if (i % 3 == 0) {
    hourlength = getWidth(context) * 0.04;
    offset = getWidth(context) * 0.2;
  } else {
    hourlength = getWidth(context) * 0.02;
    offset = getWidth(context) * 0.21;
  }
  late double angles = 2 * 3.14 * i / 12;
  Color color = Color.fromARGB(255, 0, 0, 0);

  return RotatedBox(
      // it is 2 so when it is 12 it is vertical
      quarterTurns: 2,
      child: Transform.rotate(
        angle: angles,
        child: Transform.translate(
          offset: Offset(0, offset),
          child: Center(
            child: Container(
              height: hourlength,
              width: 3,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.all(Radius.circular(4)),
              ),
            ),
          ),
        ),
      ));
}
