import 'dart:async';

import 'package:flutter/material.dart';
import 'package:life_hub/Widgets/widgetCalender.dart';
import 'package:life_hub/Widgets/widgetAd.dart';
import 'package:life_hub/Widgets/widgetSetup.dart';
import 'package:life_hub/Widgets/widgetShapes.dart';
import 'package:life_hub/Widgets/widgetRejseplan.dart';
import 'package:life_hub/Widgets/widgetShopList.dart';
import 'package:life_hub/Widgets/widgetTODO.dart';
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
    HomeScreen homeScreen = HomeScreen();
    return MaterialApp(
      initialRoute: '/',
      routes: {
        //Add screens here
        '/': (context) => homeScreen,
        '/ShoppingScreen': (context) => ShoppingScreen(homeScreen: homeScreen),
      },
    );
  }

}


void test() {
  print('object');
}

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});
  final ShopWidget shopWidget = ShopWidget();

  @override
  State<HomeScreen> createState() => _HomeScreenState(shopWidget);
}

class _HomeScreenState extends State<HomeScreen> {
  ShopWidget shopWidget;
  _HomeScreenState(this.shopWidget);

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
                    children: [weatherWidget(context), shopWidget],
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
                          AdWidget(context),
                        ],
                      ),
                      Column(
                        children: [TODOWidget(context)],
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
        }));
  }

  refresh() {
    setState(() {});
  }
}
