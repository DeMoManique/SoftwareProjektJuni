import 'dart:async';

import 'package:flutter/material.dart';
import 'package:life_hub/Widgets/widgetAnalogClock.dart';
import 'package:life_hub/Widgets/widgetCalender.dart';
import 'package:life_hub/Widgets/widgetAd.dart';
import 'package:life_hub/Widgets/widgetSetup.dart';
import 'package:life_hub/Widgets/widgetShapes.dart';
import 'package:life_hub/Widgets/widgetRejseplan.dart';
import 'package:life_hub/Widgets/widgetShopList.dart';
import 'package:life_hub/Widgets/widgetWeather.dart';

import 'Widgets/widgetClock.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ShoppingWidget shoppingWidget = ShoppingWidget();
    ShoppingListScreen shopScreen =
        ShoppingListScreen(parentWidget: shoppingWidget);
    TODOWidget todoWidget = TODOWidget();
    TodoListScreen todoScreen = TodoListScreen(parentWidget: todoWidget);

    HomeScreen homeScreen = HomeScreen(
      shoppingWidget: shoppingWidget,
      todoWidget: todoWidget,
    );

    return MaterialApp(
      initialRoute: '/',
      routes: {
        //Add screens here
        '/': (context) => homeScreen,
        '/ShoppingScreen': (context) => shopScreen,
        '/TODOScreen': (context) => todoScreen,
      },
    );
  }
}

void test() {
  print('object');
}

class HomeScreen extends StatefulWidget {
  final ShoppingWidget shoppingWidget;
  final TODOWidget todoWidget;
  HomeScreen(
      {super.key, required this.shoppingWidget, required this.todoWidget});

  @override
  State<HomeScreen> createState() =>
      _HomeScreenState(shoppingWidget, todoWidget);
}

class _HomeScreenState extends State<HomeScreen> {
  final ShoppingWidget shoppingWidget;
  final TODOWidget todoWidget;

  _HomeScreenState(this.shoppingWidget, this.todoWidget);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    children: [weatherWidget(context), shoppingWidget],
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
                          clockWidget(context),
                          todoWidget,
                        ],
                      ),
                      Column(
                        children: [VertRectangle(context)],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      analogClockWidget(context),
                      calenderWidget(context),
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
        }));
  }

  refresh() {
    setState(() {});
  }
}
