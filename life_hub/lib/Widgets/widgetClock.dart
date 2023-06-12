import 'dart:async';
import 'package:flutter/material.dart';
import 'package:life_hub/Widgets/widgetShapes.dart';


  late DateTime now = DateTime.now();
  late Timer timer;

  @override
  void initState() {
    timer = Timer.periodic(
        Duration(seconds: 1),
        (Timer t) => (() {
              now = DateTime.now();
            }));
  }

  @override
  Widget clockWidget(BuildContext context) {
    return Square(
      context,
      child: setClock(),
    );
  }


setClock() {
  return  Text("${now.hour}:${now.minute}:${now.second}");
}