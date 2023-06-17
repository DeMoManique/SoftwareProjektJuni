import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:life_hub/Widgets/widgetComponents.dart';

void main() => runApp(MaterialApp(home: LeaderboardScreen()));

class LeaderboardScreen extends StatefulWidget {
  const LeaderboardScreen({super.key});

  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
  Map<String, String> speeds = {};
  Future getSpeeds() async {
    await FirebaseFirestore.instance
        .collection('users')
        .get()
        .then((snapshot) => snapshot.docs.forEach((element) {
              print(element.reference);
            }));
  }

  @override
  void initState() {
    getSpeeds();
    super.initState();
  }

  List<String> names = [
    "1",
    "2",
    "3",
    "4",
    "1",
    "2",
    "3",
    "4",
    "1",
    "2",
    "3",
    "4",
    "1",
    "2",
    "3",
    "4",
    "1",
    "2",
    "3",
    "4",
    "1",
    "2",
    "3",
    "4",
    "1",
    "2",
    "3",
    "4",
    "1",
    "2",
    "3",
    "4"
  ];
  List<String> litems = [
    "1",
    "2",
    "3",
    "4",
    "1",
    "2",
    "3",
    "4",
    "1",
    "2",
    "3",
    "4",
    "1",
    "2",
    "3",
    "4",
    "1",
    "2",
    "3",
    "4",
    "1",
    "2",
    "3",
    "4",
    "1",
    "2",
    "3",
    "4",
    "1",
    "2",
    "3",
    "4"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: Color.fromRGBO(67, 176, 176, 1),
            pinned: true,
            snap: false,
            floating: false,
            expandedHeight: 200.0,
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
                                color: Colors.grey[200],
                                fontWeight: FontWeight.bold,
                                fontSize: 20)),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 25, 0),
                          child: Text(
                            "Name",
                            style: TextStyle(
                                color: Colors.grey[200],
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                        ),
                        Text(
                          "Score",
                          style: TextStyle(
                              color: Colors.grey[200],
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                color: Color.fromRGBO(67, 176, 176, 1),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 100.0),
                      child: Text(
                        "Top speeds by rank",
                        style: TextStyle(
                            fontSize: 30,
                            color: Colors.grey[200],
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverList(
              delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) => buildList(context, index),
            childCount: litems.length,
          ))
        ],
      ),
    );
  }

  Widget buildList(BuildContext txt, int index) {
    int ind = index + 1;
    final pos = litems[index];
    final name = names[index];

    Widget listItem;

    if (ind == 1) {
      listItem = myLeaderBoardCard(
          pos: ind.toString(),
          Color: Color(0xFFD0B13E),
          name: "test",
          padding: 35.0,
          speed: "10.0");
    } else if (ind == 2) {
      listItem = myLeaderBoardCard(
          pos: ind.toString(),
          Color: const Color.fromARGB(255, 190, 190, 190),
          name: name,
          padding: 28.0,
          speed: "10.0");
    } else if (ind == 3) {
      listItem = myLeaderBoardCard(
          pos: ind.toString(),
          Color: Color(0xFFA45735),
          name: name,
          padding: 20.0,
          speed: "10.0");
    } else {
      listItem = myLeaderBoardCard(
          pos: ind.toString(),
          Color: Colors.white,
          name: name,
          padding: 15.0,
          speed: "10.0");
    }

    return Stack(
      children: [
        Container(
          color: Colors.grey[200],
          child: listItem,
        ),
      ],
    );
  }
}
