import 'package:flutter/material.dart';
import 'package:life_hub/APIs/maps.dart' as route;
import 'package:life_hub/Widgets/widgetSetup.dart';
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

getRoutes() {
  late Future<route.Route> futureRoute = route.fetchRoutes();

  return FutureBuilder<route.Route>(
    future: futureRoute,
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        return Stack(children: [
        

          // Origin
          Positioned(
              top: 9,
              left: 9,
              child: Text(
                snapshot.data!.origin.split(",")[0],
                textAlign: TextAlign.left,
                style: TextStyle(
                    overflow: TextOverflow.ellipsis, fontSize: 20, height: 1),
              )),
          Positioned(
              top: 39,
              left: 9,
              child: Text(
                snapshot.data!.origin.split(",")[2],
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 12, height: 1),
              )),
          Positioned(
              top: 9,
              right: 9,
              child: Text(
                snapshot.data!.destination.split(",")[0],
                textAlign: TextAlign.right,
                style: TextStyle(
                    overflow: TextOverflow.ellipsis, fontSize: 20, height: 1),
              )),
          Positioned(
              top: 39,
              right: 9,
              child: Text(
                snapshot.data!.destination.split(",")[1],
                textAlign: TextAlign.right,
                style: TextStyle(fontSize: 12, height: 1),
              )),

          Positioned(
              top: 87,
              left: 12,
              child: Text(
                snapshot.data!.departureTime, 
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, height: 1),
              )),
          Positioned(
              top: 86,
              right: 12,
              child: Text(
                '8:20',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, height: 1),
              )),
          Positioned(
              top: 50,
              left: 0,
              right: 0,
              child: Text(
                '1 t 10 min',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, height: 1),
              )),
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
