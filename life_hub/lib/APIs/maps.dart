import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';

Future<Route> fetchRoutes() async {
  //get position from phone
  Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);
  String location = '${position.latitude}, ${position.longitude}'; // location


  String key = '+';// api key fra disc
  String des = '55.7836959, 12.5183346';
  String origin = '55.673185, 12.563980';
  String mode = 'transit';
  String avoid = '';

  final response = await http.get(Uri.parse('https://maps.googleapis.com/maps/api/directions/json?avoid=$avoid&destination=$des&mode=$mode&origin=$location&key=$key'));
  // ignore: avoid_print
  print('https://maps.googleapis.com/maps/api/directions/json?avoid=$avoid&destination=$des&mode=$mode&origin=$location&key=$key');
  if(response.statusCode == 200){
    return Route.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to create');
  }  

}

// main() async{
//   var din = await fetchRoutes();
//   print(din.origin + " <---> " + din.destination + ", " + din.travelTime );
  
//   for(final liner in din.lines){
//     if(liner['transit_details'] == null){
//       print(liner['travel_mode']);
//     } else {
//       print(liner['transit_details']['line']['vehicle']['name']);
//       print( liner['transit_details']['line']['short_name']);
//     }
//   }
// }

class Route {
  final String origin;
  final String destination;
  final String travelTime;
  final String departureTime;
  final String arrivalTime;
  final List lines;

  const Route({required this.origin, required this.destination, required this.travelTime, required this.arrivalTime, required this.departureTime, required this.lines});

  factory Route.fromJson(Map<String, dynamic> json){
    
    
    return Route(
      origin: json['routes'][0]['legs'][0]['start_address'],
      destination: json['routes'][0]['legs'][0]['end_address'],
      travelTime: json['routes'][0]['legs'][0]['duration']['text'],
      arrivalTime: json['routes'][0]['legs'][0]['arrival_time']['text'],
      departureTime: json['routes'][0]['legs'][0]['departure_time']['text'],
      lines: json['routes'][0]['legs'][0]['steps']
    );
  }

}
