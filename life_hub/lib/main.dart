import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:life_hub/Pages/leaderBoardScreen.dart';
import 'package:life_hub/Pages/signinScreen.dart';
import 'package:flutter/material.dart';
import 'package:life_hub/Widgets/widgetAnalogClock.dart';
import 'package:life_hub/Widgets/widgetCalender.dart';
import 'package:life_hub/Widgets/widgetAd.dart';
import 'package:life_hub/Widgets/widgetSetup.dart';
import 'package:life_hub/Widgets/widgetShapes.dart';
import 'package:life_hub/Widgets/widgetRejseplan.dart';
import 'package:life_hub/Widgets/widgetList.dart';
import 'package:life_hub/Widgets/widgetWeather.dart';
import 'package:life_hub/Widgets/widgetRun.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'Widgets/widgetClock.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ShoppingWidget shoppingWidget = ShoppingWidget(
      color: Colors.red,
    );
    ShoppingListScreen shopScreen =
        ShoppingListScreen(parentWidget: shoppingWidget);
    TODOWidget todoWidget = TODOWidget(color: Colors.blue);
    TodoListScreen todoScreen = TodoListScreen(parentWidget: todoWidget);
    WeatherScreen weatherScreen = WeatherScreen();

    HomeScreen homeScreen = HomeScreen(
      shoppingWidget: shoppingWidget,
      todoWidget: todoWidget,
      weatherScreen: weatherScreen,
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return homeScreen;
            } else {
              return const SignInScreen();
            }
          }),
      routes: {
        //Add screens here
        '/homeScreen': (context) => homeScreen,
        '/ShoppingScreen': (context) => shopScreen,
        '/TODOScreen': (context) => todoScreen,
        '/WeatherScreen': (context) => weatherScreen,
        '/speedScreen': (context) => const SpeedScreen(),
        '/leaderboardScreen': (context) => const LeaderboardScreen(),
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
  final WeatherScreen weatherScreen;
  HomeScreen(
      {super.key,
      required this.shoppingWidget,
      required this.todoWidget,
      required this.weatherScreen});

  @override
  State<HomeScreen> createState() =>
      _HomeScreenState(shoppingWidget, todoWidget, weatherScreen);
}

class _HomeScreenState extends State<HomeScreen> {
  final ShoppingWidget shoppingWidget;
  final TODOWidget todoWidget;
  final WeatherScreen weatherScreen;

  _HomeScreenState(this.shoppingWidget, this.todoWidget, this.weatherScreen);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(67, 176, 176, 1),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        forceMaterialTransparency: true,
        backgroundColor: Color.fromRGBO(48, 125, 125, 1),
        title: Text('Hej ${FirebaseAuth.instance.currentUser?.displayName}'),
        actions: [
          GestureDetector(
              onTap: () async {
                await FirebaseAuth.instance.signOut();
              },
              child: const Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
                child: Icon(Icons.logout),
              ))
        ],
      ),
      body: SingleChildScrollView(
          child: StaggeredGrid.count(
        crossAxisCount: 4,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        children: [
          StaggeredGridTile.count(
              crossAxisCellCount: 2,
              mainAxisCellCount: 2,
              child: weatherWidget(context, weatherScreen)),
          StaggeredGridTile.count(
              crossAxisCellCount: 2,
              mainAxisCellCount: 4,
              child: shoppingWidget),
          StaggeredGridTile.count(
              crossAxisCellCount: 2,
              mainAxisCellCount: 2,
              child: analogClockWidget(context)),
          StaggeredGridTile.count(
              crossAxisCellCount: 4,
              mainAxisCellCount: 2,
              child: rejseplanWidget(context)),
          StaggeredGridTile.count(
              crossAxisCellCount: 2, mainAxisCellCount: 4, child: todoWidget),
          StaggeredGridTile.count(
              crossAxisCellCount: 2,
              mainAxisCellCount: 1,
              child: clockWidget(context)),
          StaggeredGridTile.count(
              crossAxisCellCount: 2,
              mainAxisCellCount: 3,
              child: calenderWidget(context)),
          StaggeredGridTile.count(
              crossAxisCellCount: 4,
              mainAxisCellCount: 2,
              child: widgetRun(context)),
        ],
      )

          // GridView.custom(
          //     gridDelegate: SliverQuiltedGridDelegate(
          //         crossAxisCount: 2,
          //         mainAxisSpacing: 4,
          //         crossAxisSpacing: 4,
          //         repeatPattern: QuiltedGridRepeatPattern.same,
          //         pattern: [
          //           QuiltedGridTile(1, 1),
          //           QuiltedGridTile(1, 1),
          //           QuiltedGridTile(1, 2),
          //         ]),
          //     childrenDelegate: SliverChildListDelegate([
          //       weatherWidget(context, weatherScreen),
          //       shoppingWidget,
          //       rejseplanWidget(context),
          //       clockWidget(context),
          //       todoWidget,
          //       widgetRun(context),
          //       analogClockWidget(context),
          //       calenderWidget(context),
          //     ])

          // Column(
          //   children: [
          //     Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //       children: [
          //         weatherWidget(context, weatherScreen),
          //         shoppingWidget
          //       ],
          //     ),
          //     Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //       children: [rejseplanWidget(context)],
          //     ),
          //     Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //       children: [
          //         Column(
          //           children: [
          //             clockWidget(context),
          //             todoWidget,
          //           ],
          //         ),
          //         Column(
          //           children: [
          //             analogClockWidget(context),
          //             calenderWidget(context),
          //           ],
          //         ),
          //       ],
          //     ),
          //     Column(children: [
          //       widgetRun(context),
          //     ]),
          //   ],
          // ),
          ),
    );
  }

  refresh() {
    setState(() {});
  }
}
