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
        return Square(
          context,
          color: Color.fromARGB(255, 169, 216, 235),
          child: Stack(
            
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${now.hour}:$minute',
                    style: const TextStyle(
                      fontFamily: 'MoiraiOne',
                      fontSize: 53,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0,0,0,50),
                    child: Text(
                      '$second',
                      style: const TextStyle(
                        fontFamily: 'MoiraiOne',
                        fontSize: 15,
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
