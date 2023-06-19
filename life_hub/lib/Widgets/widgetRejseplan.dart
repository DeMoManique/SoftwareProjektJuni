import 'dart:math';

import 'package:flutter/material.dart';
import 'package:life_hub/APIs/maps.dart' as route;
import 'package:life_hub/Widgets/widgetSetup.dart';
import 'package:life_hub/APIs/Calender.dart';
import 'package:life_hub/APIs/Calender.dart';

@override
Widget rejseplanWidget(BuildContext context) {
  return Card(
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20))),
    child: SizedBox(
      width: getWidth(context) * 0.97,
      height: getWidth(context) * 0.47,
      child: Align(
          alignment: Alignment.topCenter,
          child:
              Padding(padding: const EdgeInsets.all(10), child: getRoutes())),
    ),
  );
}

String pmTo24h(String timepm) {
  String time24h = timepm.substring(0, timepm.length - 2);
  if (timepm.contains('PM') && timepm.split(":")[0] != '12') {
    int timeHours = int.parse(time24h.split(":")[0]);
    timeHours += 12;
    time24h = "$timeHours:${time24h.split(":")[1]}";
  }
  return time24h;
}

List<String> locationName(List<String> location) {
  List<String> locationName = [];
  if (location.length > 3) {
    locationName.add(location[0]);
    locationName.add(location[2]);
  } else {
    locationName.add(location[0]);
    locationName.add(location[1]);
  }

  return locationName;
}

Widget toLine(double timeInMin, double length, Color color) {
  return Transform.translate(
      offset: Offset(0, 0),
      child: Container(
        height: 6,
        width: length,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
      ));
}

double strToMin(String time) {
  double timeInMin = 0;
  time = time.replaceFirst('hour', 'h');
  time = time.replaceFirst('mins', 'min');

  if (time.contains('h')) {
    timeInMin += double.parse(time.split('h')[0]) * 60;
    timeInMin += double.parse(time.split('h')[1].split('min')[0]);
  } else {
    timeInMin += double.parse(time.split('min')[0]);
  }

  return timeInMin;
}

getRoutes() {
  late Future<route.Route> futureRoute = route.fetchRoutes();

  return FutureBuilder<route.Route>(
    future: futureRoute,
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        // from am and pm to 24h at departure time
        String departureTime = pmTo24h(snapshot.data!.departureTime);
        String arrivalTime = pmTo24h(snapshot.data!.arrivalTime);
        String travelTime = snapshot.data!.travelTime;
        List<String> origin = locationName(snapshot.data!.origin.split(","));
        List<String> destination =
            locationName(snapshot.data!.destination.split(","));

        List steps = snapshot.data!.lines;

        double timeInMin = strToMin(travelTime);

        double fullWidth = getWidth(context) * 0.87;

        // List<double> lengthAll = [];
        List<Widget> stepsWidget = [];
        for (int i = 0; i < steps.length; i++) {
          double stepTimeInMin = strToMin(steps[i]['duration']['text']);
          double length = stepTimeInMin / timeInMin * fullWidth;

          if (steps[i]['travel_mode'] == 'WALKING') {
            stepsWidget.add(toLine(stepTimeInMin, length, Colors.grey));
          } else if (steps[i]['transit_details']['line']['vehicle']['name'] == 'Bus') {
            // This is a BUS
            String shortName = steps[i]['transit_details']['line']['short_name'];
            if (shortName.contains('E')) {
              stepsWidget.add(toLine(stepTimeInMin, length, Colors.green.shade700));
            } else if (shortName.contains('S')){
              stepsWidget.add(toLine(stepTimeInMin, length, Colors.blue.shade700));
            } else {
              stepsWidget.add(toLine(stepTimeInMin, length, Colors.yellow.shade600));
            }
          } else if (steps[i]['transit_details']['line']['vehicle']['name'] == 'Commuter train') {
            // This is a TRAIN
            String colorX = '0xFF'+ steps[i]['transit_details']['line']['color'].split('#')[1];

            stepsWidget.add(toLine(stepTimeInMin, length, Color(int.parse(colorX))));
          } else {
            // This is a METRO
            stepsWidget.add(toLine(stepTimeInMin, length, Colors.black26));
          }



        }

        return Stack(children: [
          // Origin
          Positioned(
              top: 9,
              left: 9,
              child: Text(
                origin[0],
                textAlign: TextAlign.left,
                style: TextStyle(
                    overflow: TextOverflow.ellipsis, fontSize: 20, height: 1),
              )),
          Positioned(
              top: 39,
              left: 9,
              child: Text(
                origin[1],
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 12, height: 1),
              )),
          Positioned(
              top: 9,
              right: 9,
              child: Text(
                destination[0],
                textAlign: TextAlign.right,
                style: TextStyle(
                    overflow: TextOverflow.ellipsis, fontSize: 20, height: 1),
              )),
          Positioned(
              top: 39,
              right: 9,
              child: Text(
                destination[1],
                textAlign: TextAlign.right,
                style: TextStyle(fontSize: 12, height: 1),
              )),

          Positioned(
              top: 87,
              left: 12,
              child: Text(
                departureTime,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, height: 1),
              )),
          Positioned(
              top: 86,
              right: 12,
              child: Text(
                arrivalTime,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, height: 1),
              )),
          Positioned(
              top: 50,
              left: 0,
              right: 0,
              child: Text(
                travelTime,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, height: 1),
              )),

          Positioned(
              top: 130,
              left: 0,
              right: 0,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: stepsWidget)),
          
          // Positioned(
          //     top: 90,
          //     left: 0,
          //     right: 0,
          //     // insert picture here schedule.png
          //     child: AssetImage('assets/images/schedulepng.png'),
          //     )
        ]);

        // Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        //   Text(snapshot.data!.origin.split(",")[0]),
        //   Text(snapshot.data!.destination.split(",")[0])
        // ]),
      } else if (snapshot.hasError) {
        print('failure');
        return Text('${snapshot.error}');
      }

      // By default, show a loading spinner.
      return const CircularProgressIndicator();
    },
  );
}
