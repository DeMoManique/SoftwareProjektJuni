import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:googleapis/calendar/v3.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:googleapis_auth/googleapis_auth.dart';
import 'package:http/io_client.dart';
import 'package:http/http.dart';
import 'package:extension_google_sign_in_as_googleapis_auth/extension_google_sign_in_as_googleapis_auth.dart';
import 'package:life_hub/Pages/signinScreen.dart';


  getAuthClient() async{
    GoogleSignIn? googleSignIn = GoogleSignIn(
      scopes: [CalendarApi.calendarEventsScope],

    );
  
    GoogleSignInAccount? googleUser = await googleSignIn.signIn();

    GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );


    UserCredential? userCredential  = await FirebaseAuth.instance.signInWithCredential(credential);

    print(userCredential.user?.displayName);


    AuthClient? authenticateClient = await googleSignIn.authenticatedClient();
    return authenticateClient;
  }


  Future<List> signInWithGoogle() async {

    assert(getAuthClient() != null, "Client non existent");

    final api = CalendarApi(await getAuthClient()!);
    assert(api != null, "Api non existent");
    
    assert(api.events.list('primary', timeMin: DateTime.now()) != null , "Faulty");

    List eventsList = [];
   
   Events events = await api.events.list('primary', timeMin: DateTime.now());
    events.items!.forEach((event) {
      //print(event.summary);
      if(event.location == null){
        eventsList.add([event.start, event.end, event.description, "No Location", event.summary]);
      } else if (event.location != null){
        eventsList.add([event.start, event.end, event.description, event.location, event.summary]);
      }
    });

    List getLocation(){
      List locationList = [];
      events.items!.forEach((event) { 
        if(event.location == null){
          locationList.add("No Location");
      } else if (event.location != null){
          locationList.add(event.location);
      }
      });
      return locationList;
    }
    
    return eventsList;
  }




// void main() async{
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   LoginPage lp = LoginPage();
//   lp.signInWithGoogle();
// }