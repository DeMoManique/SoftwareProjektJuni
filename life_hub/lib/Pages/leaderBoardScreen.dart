import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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

  @override
  void initState() {
    getSpeeds = getSpeed();
    super.initState();
  }

  /*
   query on the database to retrive topspeeds in descending order limited to only 50 documents
  */
  Future getSpeed() async {
    await FirebaseFirestore.instance
        .collection('users')
        .orderBy('topSpeed', descending: true)
        .limit(50)
        .get()
        .then((value) => value.docs.forEach((element) {
              // saving the refIds in the speeds list
              speeds.add(element.reference.id);
            }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Color.fromRGBO(67, 176, 176, 1),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(20.0),
          child: Container(
            height: 50,
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
      body: FutureBuilder(
        future: getSpeeds,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            return ListView.builder(
              itemBuilder: (context, index) =>
                  loadLeaderBoardData(speeds[index], index),
              itemCount: speeds.length,
            );
          }
        },
      ),
    );
  }

  Widget buildLeaderboard(BuildContext context, int index) {
    //placement starting from 1st
    int placement = index + 1;

    if (placement == 1) {
      return myLeaderBoardCard(
          pos: placement.toString(),
          Color: Color.fromARGB(255, 220, 194, 20),
          name: data!['name'].toString(),
          padding: 35,
          speed: data!['topSpeed'].toStringAsFixed(2) + ' km/h');
    } else if (placement == 2) {
      return myLeaderBoardCard(
          pos: placement.toString(),
          Color: const Color.fromARGB(255, 190, 190, 190),
          name: data!['name'].toString(),
          padding: 28.0,
          speed: data!['topSpeed'].toStringAsFixed(2) + ' km/h');
    } else if (placement == 3) {
      return myLeaderBoardCard(
          pos: placement.toString(),
          Color: Color.fromARGB(255, 182, 103, 70),
          name: data!['name'].toString(),
          padding: 20.0,
          speed: data!['topSpeed'].toStringAsFixed(2) + ' km/h');
    } else {
      return myLeaderBoardCard(
          pos: placement.toString(),
          Color: Colors.white,
          name: data!['name'].toString(),
          padding: 15.0,
          speed: data!['topSpeed'].toStringAsFixed(2) + ' km/h');
    }
  }

  Widget loadLeaderBoardData(String documentID, int index) {
    // ref to the collection
    CollectionReference topSpeeds =
        FirebaseFirestore.instance.collection('users');

    return FutureBuilder<DocumentSnapshot>(
      // getting the specified document
      future: topSpeeds.doc(documentID).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          //loading the data into a map and building the UI
          data = snapshot.data!.data() as Map<String, dynamic>;
          return buildLeaderboard(context, index);
        } else {
          //showing a progressbar while loading the data
          return const LinearProgressIndicator(
              minHeight: 1, color: Color.fromRGBO(67, 176, 176, 1));
        }
      },
    );
  }
}
