import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:life_hub/Widgets/widgetComponents.dart';

class LeaderboardScreen extends StatefulWidget {
  const LeaderboardScreen({super.key});

  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
  Map<String, dynamic>? data;
  List<String> speeds = [];
  late final Future? getSpeeds;
  void initState() {
    getSpeeds = getSpeed();
    super.initState();
  }

  Future getSpeed() async {
    await FirebaseFirestore.instance
        .collection('users')
        .orderBy('topSpeed', descending: true)
        .limit(50)
        .get()
        .then((value) => value.docs.forEach((element) {
              speeds.add(element.reference.id);
            }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Color.fromRGBO(67, 176, 176, 1),
            pinned: true,
            snap: false,
            floating: false,
            expandedHeight: 100.0,
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(4.0),
              child: Container(
                height: 50,
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Postion",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20)),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 25, 0),
                          child: Text(
                            "Name",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                        ),
                        Text(
                          "Speed",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          FutureBuilder(
            future: getSpeeds,
            builder: (context, snapshot) {
              return SliverList(
                  delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) => Tile(speeds[index], index),
                childCount: speeds.length,
              ));
            },
          )
        ],
      ),
    );
  }

  Widget buildLeaderboard(BuildContext txt, int index) {
    int ind = index + 1;

    Widget listItem;

    if (ind == 1) {
      listItem = myLeaderBoardCard(
          pos: ind.toString(),
          Color: Color.fromARGB(255, 232, 203, 17),
          name: data!['name'].toString(),
          padding: 35,
          speed: data!['topSpeed'].toStringAsFixed(2) + ' km/h');
    } else if (ind == 2) {
      listItem = myLeaderBoardCard(
          pos: ind.toString(),
          Color: const Color.fromARGB(255, 190, 190, 190),
          name: data!['name'].toString(),
          padding: 28.0,
          speed: data!['topSpeed'].toStringAsFixed(2) + ' km/h');
    } else if (ind == 3) {
      listItem = myLeaderBoardCard(
          pos: ind.toString(),
          Color: Color(0xFFA45735),
          name: data!['name'].toString(),
          padding: 20.0,
          speed: data!['topSpeed'].toStringAsFixed(2) + ' km/h');
    } else {
      listItem = myLeaderBoardCard(
          pos: ind.toString(),
          Color: Colors.white,
          name: data!['name'].toString(),
          padding: 15.0,
          speed: data!['topSpeed'].toStringAsFixed(2) + ' km/h');
    }

    return Stack(
      children: [
        Container(
          child: listItem,
        ),
      ],
    );
  }

  Widget Tile(String documentID, int index) {
    CollectionReference topSpeeds =
        FirebaseFirestore.instance.collection('users');

    return FutureBuilder<DocumentSnapshot>(
      future: topSpeeds.doc(documentID).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          data = snapshot.data!.data() as Map<String, dynamic>;

          return buildLeaderboard(context, index);
        } else {
          return LinearProgressIndicator(
              color: Color.fromRGBO(67, 176, 176, 1));
        }
      },
    );
  }
}
