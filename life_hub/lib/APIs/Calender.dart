import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:googleapis/calendar/v3.dart' as googleCalendar;
import 'package:googleapis/servicemanagement/v1.dart';
import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:googleapis_auth/googleapis_auth.dart';
import 'package:http/io_client.dart';
import 'package:http/http.dart';
import 'package:extension_google_sign_in_as_googleapis_auth/extension_google_sign_in_as_googleapis_auth.dart';
import '../services/googleSignIn.dart';


final GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: [googleCalendar.CalendarApi.calendarReadonlyScope]
);



Future<List> getCalendarEvents() async{

  GoogleSignInAccount? googleSignIn = await _googleSignIn.signIn();



  final api = googleCalendar.CalendarApi((await _googleSignIn.authenticatedClient()) as http.Client);
  print("HEj");
  List eventsList = [];

  googleCalendar.Events eventsFromAPI = await api.events.list('primary', timeMin: DateTime.now());
  eventsFromAPI.items!.forEach((event) {
      print(event.summary);
      if(event.location == null){
        eventsList.add([event.start, event.end, event.description, "No Location", event.summary]);
      } else if (event.location != null){
        eventsList.add([event.start, event.end, event.description, event.location, event.summary]);
      }
});

  return eventsList;
}

//   Future<List> getCalendarEvents() async {
//       final GoogleSignInAccount? googleUser = _googleSignIn.currentUser;
      
//       final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

//       AuthCredential credentials = GoogleAuthProvider.credential(
//         idToken: googleAuth?.idToken,
//         accessToken: googleAuth?.accessToken
//       );

//       print(googleAuth?.idToken);
//       print(googleAuth?.accessToken);

//       final UserCredential user = await FirebaseAuth.instance.signInWithCredential(credentials);

//       print(user.user?.displayName);

//       Future<Client> authClient = _googleSignIn.authenticatedClient() as Future<Client>;

     


//     //final calendar = CalendarApi(authClient);


//     //assert(getAuthClient() != null, "Client non existent");
    
//     final api = googleCalendar.CalendarApi(await authClient);
//     //assert(api != null, "Api non existent");
    
//     //assert(api.events.list('primary', timeMin: DateTime.now()) != null , "Faulty");

//     List eventsList = [];
   
//    googleCalendar.Events events = await api.events.list('primary', timeMin: DateTime.now());
//     events.items!.forEach((event) {
//       //print(event.summary);
//       if(event.location == null){
//         eventsList.add([event.start, event.end, event.description, "No Location", event.summary]);
//       } else if (event.location != null){
//         eventsList.add([event.start, event.end, event.description, event.location, event.summary]);
//       }
//     });

//     List getLocation(){
//       List locationList = [];
//       events.items!.forEach((event) { 
//         if(event.location == null){
//           locationList.add("No Location");
//       } else if (event.location != null){
//           locationList.add(event.location);
//       }
//       });
//       return locationList;
//     }
    
//     return eventsList;
//   }




// // void main() async{
// //   WidgetsFlutterBinding.ensureInitialized();
// //   await Firebase.initializeApp();
// //   LoginPage lp = LoginPage();
// //   lp.signInWithGoogle();
// // }