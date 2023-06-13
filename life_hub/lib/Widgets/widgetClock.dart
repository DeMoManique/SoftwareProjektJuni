import 'dart:async';
import 'package:flutter/material.dart';
import 'package:life_hub/Widgets/widgetShapes.dart';

DateTime now = DateTime.now();
late Timer timer;

@override
Widget clockWidget(BuildContext context) {
  return StreamBuilder(
      stream: Stream.periodic(const Duration(seconds: 1)),
      builder: ((context, snapshot) {
        now = DateTime.now();
        return Square(
          context,
          color: Color.fromARGB(255, 169, 216, 235),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Text(
                    '${now.hour}:${now.minute}',
                    style: TextStyle(
                      fontSize: 70,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0,35,0,0),
                    child: Text(
                      '${now.second}',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      }));
}

// class WidgetClock extends StatelessWidget {
//   const WidgetClock({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder(
//         stream: Stream.periodic(Duration(seconds: 1)),
//         builder: (context, snapshot) {
          
//         });
//   }
// }
