import 'package:flutter/material.dart';
import 'package:life_hub/Widgets/widgetSquare.dart';

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
            square(context, "geh"),
            square(context, "hgey")
          ],
        )
      ),
    );
  }
}
