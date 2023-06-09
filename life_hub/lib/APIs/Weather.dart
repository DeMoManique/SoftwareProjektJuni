import "dart:convert";
import 'package:http/http.dart' as http;

String key = '486495597ff0499394a202301230606';  // API key
// TODO: Change location to user location
String location = '55.673185, 12.563980'; // location 
String URL = 'https://api.weatherapi.com/v1/current.json?q=$location&key=$key';

Future<Weather> fetchWeather() async {
  final response = await http.get(Uri.parse(URL));
  print(response.statusCode);
  if (response.statusCode == 200) {
    return Weather.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to create');
  }
}

main() async {
  var weathernow = await fetchWeather();
  // ignore: avoid_print
  print(weathernow.location +
      " " +
      weathernow.temperature.toString() +
      " C°, " +
      weathernow.condition);
}


class Weather {
  final String location;
  final double temperature;
  final double temperatureFeel;
  final String condition;
  final int conditionCode;
  final double windSpeed;
  final int windDegree;
  final double precip;
  final double uv;

  const Weather(
      {required this.location,
      required this.temperature,
      required this.temperatureFeel,
      required this.condition,
      required this.conditionCode,
      required this.windSpeed,
      required this.windDegree,
      required this.precip,
      required this.uv});

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      location: json['location']['name'],
      temperature: json['current']['temp_c'],
      temperatureFeel: json['current']['feelslike_c'],
      condition: json['current']['condition']['text'],
      conditionCode: json['current']['condition']['code'],
      windSpeed: json['current']['wind_kph'],
      windDegree: json['current']['wind_degree'],
      precip: json['current']['precip_mm'],
      uv: json['current']['uv']);
  }
}
