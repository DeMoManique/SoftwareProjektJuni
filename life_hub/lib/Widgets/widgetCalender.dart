import 'package:flutter/material.dart';
import 'package:life_hub/Widgets/widgetSetup.dart';
import 'package:life_hub/Widgets/widgetShapes.dart';
import 'package:life_hub/APIs/Calender.dart';

@override
Widget calenderWidget(BuildContext context) {
  return Square(context, child: getList());
}

getList() {
  late Future<List> futureEvents = signInWithGoogle();

  return FutureBuilder<List>(
    future: futureEvents,
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        return Center(
          child: ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: ((context, index) {
                final start = snapshot.data?[index][0];
                final end = snapshot.data?[index][1];
                final desc = snapshot.data?[index][2];
                final location = snapshot.data?[index][3];
                final title = snapshot.data?[index][4];

                print(title);
                return Container(
                  margin: const EdgeInsets.all(5),
                  child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                        width: getWidth(context) * 0.01,
                        height: getWidth(context) * 0.07,
                        child: const DecoratedBox(
                            decoration: BoxDecoration(color: Colors.red))),
                    SizedBox(
                      width: getWidth(context) * 0.01,
                      height: getWidth(context) * 0.07,
                    ),
                    Flexible(
                      child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          location,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: const TextStyle(fontSize: 10),
                        )
                      ],
                    ))
                  ])
                );
              })),
        );
      } else if (snapshot.hasError) {
        print('failure');
        return Text('${snapshot.error}');
      }

      return const CircularProgressIndicator();
    },
  );
}
