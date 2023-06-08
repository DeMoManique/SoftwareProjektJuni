import 'package:flutter/material.dart';
import 'package:life_hub/Widgets/widgetSquare.dart';
import 'package:life_hub/Widgets/widgetRejseplan.dart';

void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Hej Lucas"),
        ),
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                square(context, "widget1"),
                square(context, "widget2")
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                rejseplanWidget(context)
              ],
            )
          ],
        )
      ),
    );
  }
}

