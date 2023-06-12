import 'package:flutter/material.dart';
import 'package:life_hub/Widgets/widgetCalender.dart';
import 'package:life_hub/Widgets/widgetSetup.dart';
import 'package:life_hub/Widgets/widgetShapes.dart';
import 'package:life_hub/Widgets/widgetRejseplan.dart';
import 'package:life_hub/Widgets/widgetWeather.dart';

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
          backgroundColor: Colors.blueGrey,
          appBar: AppBar(
            backgroundColor: Colors.blue[200],
            title: Text('Hej ${getName()}'),
          ),
          body: LayoutBuilder(builder:
              (BuildContext context, BoxConstraints viewportConstraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints:
                    BoxConstraints(minHeight: viewportConstraints.maxHeight),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        weatherWidget(context),
                        calenderWidget(context, ['hej', 'haahah', 'hej3', 'hej3', 'hej4', 'hej9'])
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [rejseplanWidget(context)],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Square(context,
                                color: Colors.green[300], function: test),
                            Square(context, color: Colors.lime)
                          ],
                        ),
                        Column(
                          children: [
                            VertRectangle(context,
                                color: Colors.red[300], function: test)
                          ],
                        ),
                      ],
                    ),
                    BigSquare(
                      context,
                      color: Colors.pink[400],
                    )
                  ],
                ),
              ),
            );
          })),
    );
  }
}

void test() {
  print('object');
}
