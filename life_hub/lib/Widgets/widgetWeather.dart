import 'package:flutter/material.dart';
import 'package:life_hub/APIs/Weather.dart' as weather;
import 'package:life_hub/Widgets/widgetSetup.dart';
import 'package:life_hub/Widgets/widgetShapes.dart';

@override
Widget weatherWidget(BuildContext context) {
  return Card(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: SizedBox(
          width: getWidth(context) * 0.47,
          height: getWidth(context) * 0.47,
          child:
              Padding(padding: const EdgeInsets.all(10), child: getWeather())));
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
        //-------
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
                  children: [
                    //Temperature
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: EdgeInsets.all(6.0),
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
                          image: NetworkImage(
                              'https://cdn.weatherapi.com/weather/64x64/day/116.png'),
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
