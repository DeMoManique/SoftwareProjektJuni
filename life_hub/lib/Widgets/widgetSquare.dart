import 'package:flutter/material.dart';

  @override
  Widget square(BuildContext context, String cardText){
    return Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20))
      ),
      child: SizedBox(
        width: 210,
        height: 210,
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