import 'package:flutter/material.dart';
import 'package:life_hub/APIs/Weather.dart' as weather;
import 'package:life_hub/Widgets/widgetSetup.dart';
import 'package:life_hub/Widgets/widgetShapes.dart';

@override
Widget weatherWidget(BuildContext context, WeatherScreen weatherScreen) {
  return Square(
    context,
    color: Colors.amber[200],
    child: getWeather(),
    function: () {
      //TODO Gives an exception
      //Navigator.pushNamed(context, '/WeatherScreen');
    },
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
        return Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(imageURL), fit: BoxFit.contain)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$temperature C°',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                Text(
                  '$feelsLike C°',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w300),
                ),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Wind: $windSpeed m/s'),
                        Text('UV: $uv'),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
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

class WeatherScreen extends StatefulWidget {
  WeatherScreen({super.key});
  _WeatherScreenState _weatherScreenState = _WeatherScreenState();

  @override
  State<WeatherScreen> createState() => _weatherScreenState;
}

class _WeatherScreenState extends State<WeatherScreen> {
  refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather'),
      ),
      body: updateWeather(),
    );
  }

  updateWeather() {
    late Future<weather.Weather> futureWeather = weather.fetchWeather();

    return FutureBuilder(
        future: futureWeather,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            String location = snapshot.data!.location;
            String temperature = snapshot.data!.temperature.toString();
            String feelsLike = snapshot.data!.temperatureFeel.toString();
            String windSpeed =
                (snapshot.data!.windSpeed / 3.6).toStringAsFixed(2);
            String uv = snapshot.data!.uv.toString();
            String imageURL = 'https:${snapshot.data!.imageURL}';
            return Center(
              child: Column(
                children: [
                  Text(location),
                  Text(temperature),
                  Text(feelsLike),
                  Text(windSpeed),
                  Text(uv),
                  Image(image: NetworkImage(imageURL))
                ],
              ),
            );
          } else if (snapshot.hasError) {
            print('failure');
            return Text('${snapshot.error}');
          }
          return const CircularProgressIndicator();
        });
  }
}
