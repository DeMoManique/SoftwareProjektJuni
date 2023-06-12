import 'package:flutter/material.dart';
import 'package:life_hub/APIs/Weather.dart' as weather;
import 'package:life_hub/Widgets/widgetSetup.dart';
import 'package:life_hub/Widgets/widgetShapes.dart';

@override
Widget weatherWidget(BuildContext context) {
  return Square(
    context,
    color: Colors.amber[200],
    child: getWeather(),
    function: weatherScreen,
  );
}

getWeather() {
  late Future<weather.Weather> futureWeather = weather.fetchWeather();

  return FutureBuilder<weather.Weather>(
    future: futureWeather,
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        //Variables ----------
        String location = snapshot.data!.location;
        if (location.length >= 10) {
          location = '${location.substring(0, 7)}...';
        }
        String temperature = snapshot.data!.temperature.toString();
        String feelsLike = snapshot.data!.temperatureFeel.toString();
        String windSpeed = (snapshot.data!.windSpeed / 3.6).toStringAsFixed(2);
        String uv = snapshot.data!.uv.toString();
        String imageURL = 'https:${snapshot.data!.imageURL}';
        //---------------------------------------
        return Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(0),
                child: Text(
                  location,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //Temperature
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: EdgeInsets.all(0),
                        child: Text(
                          '$temperature C°',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                    //Temperature feels like
                    Align(
                        alignment: Alignment.topLeft,
                        child: Text('$feelsLike C°')),
                    //Windspeed
                    Align(
                        alignment: Alignment.topLeft,
                        child: Text('$windSpeed m/s')),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Image(
                          image: NetworkImage(imageURL),
                          height: 75,
                        ),
                      ),
                      Text('$uv UV'),
                    ],
                  ),
                )
              ],
            )
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

void weatherScreen() {}
