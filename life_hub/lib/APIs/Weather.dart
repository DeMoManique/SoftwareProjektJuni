import "dart:convert";
import 'package:http/http.dart' as http;

String key = '486495597ff0499394a202301230606';
String location = '55.673185, 12.563980';
String URL = 'https://api.weatherapi.com/v1/current.json?q=$location&key=$key';

class weather {
  String? location;
  double? temperature;
  double? temperatureFeel;
  String? condition;
  int? conditionCode;
  double? windSpeed;
  double? windDegree;
  double? precip;
  int? uv;

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

  factory weather.fromJson(Map<String, dynamic> json) {}
}
