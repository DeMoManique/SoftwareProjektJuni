import 'package:flutter/material.dart';
import 'package:life_hub/Widgets/widgetSetup.dart';



  @override
  Widget square(BuildContext context, String cardText){
    return Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20))
      ),
      child: SizedBox(
        width: getWidth(context) * 0.47,
        height: getWidth(context) * 0.47,
        child: Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              '$cardText',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
            )
          )
        ),
      ), 
    );
  }