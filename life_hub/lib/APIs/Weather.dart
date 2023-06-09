import "dart:convert";
import 'package:http/http.dart' as http;

String key = '486495597ff0499394a202301230606';
String location = '55.673185, 12.563980';
String URL = 'https://api.weatherapi.com/v1/current.json?q=$location&key=$key';
