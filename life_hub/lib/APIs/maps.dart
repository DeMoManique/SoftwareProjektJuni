import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:life_hub/APIs/Calender.dart';

Future<Route> fetchRoutes() async {
  //get position from phone
  Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);
  String location = '${position.latitude}, ${position.longitude}'; // location
  String avoid = "";
  String key = 'AIzaSyBBqzjnUpxLRN4jHKKyDxQ3oXPTmWqlEC8'; // api key fra disc
  String mode = 'transit';
  List locations = await getLocation();
  String des = "55.783704, 12.518376";
  int arrival = 0;
  if(locations.isNotEmpty && locations[0][1] != "No Location"){
    des = await locations[0][1];
    arrival = DateTime.parse(locations[0][0].dateTime.toString()).add(const Duration(hours: 2)).microsecondsSinceEpoch;
  }

  print("https://maps.googleapis.com/maps/api/directions/json?avoid=$avoid&destination=$des&mode=$mode&origin=$location&departure_time=$arrival&key=$key");

  final response = await http.get(Uri.parse(
      'https://maps.googleapis.com/maps/api/directions/json?avoid=$avoid&destination=$des&arrivalTime=$arrival&mode=$mode&origin=$location&key=$key'));
  if (response.statusCode == 200) {
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

  const Route(
      {required this.origin,
      required this.destination,
      required this.travelTime,
      required this.arrivalTime,
      required this.departureTime,
      required this.lines});

  factory Route.fromJson(Map<String, dynamic> json) {
    return Route(
        origin: json['routes'][0]['legs'][0]['start_address'],
        destination: json['routes'][0]['legs'][0]['end_address'],
        travelTime: json['routes'][0]['legs'][0]['duration']['text'],
        arrivalTime: json['routes'][0]['legs'][0]['arrival_time']['text'],
        departureTime: json['routes'][0]['legs'][0]['departure_time']['text'],
        lines: json['routes'][0]['legs'][0]['steps']);
  }
}
