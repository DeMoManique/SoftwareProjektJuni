import 'package:flutter/material.dart';
import 'package:life_hub/APIs/maps.dart' as route;
import 'package:life_hub/Widgets/widgetSetup.dart';

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
        return Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text(snapshot.data!.origin.split(",")[0]),
              Text(snapshot.data!.destination.split(",")[0])
            ]),
          ],
        );
      } else if (snapshot.hasError) {
        print('failure');
        return Text('${snapshot.error}');
      }

      // By default, show a loading spinner.
      return const CircularProgressIndicator();
    },
  );
}
