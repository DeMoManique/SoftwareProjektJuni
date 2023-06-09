import "dart:convert";
import 'package:http/http.dart' as http;

String key = '486495597ff0499394a202301230606';
String location = '55.673185, 12.563980';
String URL = 'https://api.weatherapi.com/v1/current.json?q=$location&key=$key';

class weather {
  final String? location;
  final double? temperature;
  final double? temperatureFeel;
  final String? condition;
  final int? conditionCode;
  final double? windSpeed;
  final double? windDegree;
  final double? precip;
  final int? uv;

  const weather(
      {required this.location,
      required this.temperature,
      required this.temperatureFeel,
      required this.condition,
      required this.conditionCode,
      required this.windSpeed,
      required this.windDegree,
      required this.precip,
      required this.uv});

  factory weather.fromJson(Map<String, dynamic> json) {
    return weather(
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
