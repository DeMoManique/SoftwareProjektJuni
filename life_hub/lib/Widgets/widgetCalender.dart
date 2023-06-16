import 'package:flutter/material.dart';
import 'package:life_hub/Widgets/widgetSetup.dart';
import 'package:life_hub/Widgets/widgetShapes.dart';

@override
Widget calenderWidget(BuildContext context) {

  List list = ['Tandlæge', 'læge', 'hej'];

  return Square(
    context,
    child: Center(
      child: ListView.builder(
        itemCount: list.length,
        itemBuilder: ((context, index) {
          final item = list[index];
    
          return Container(
            margin: const EdgeInsets.all(5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: getWidth(context) * 0.01,
                  height: getWidth(context) * 0.05,
                  child: const DecoratedBox(
                    decoration:  BoxDecoration(
                    color: Colors.red
                  )
                )
               ),
               const SizedBox(width: 6, height: 20,),
               Text(item)
              ]
            ),
          );
        })
        ),
    ),
  );
}
