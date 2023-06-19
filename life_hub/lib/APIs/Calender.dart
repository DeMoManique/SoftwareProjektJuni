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

Future<List> getLocation() async{
  List list = await getCalendarEvents();
  List locationList = [];

  list.forEach((element) { 
    locationList.add([element[0], element[3]]);
  });

  return locationList;
}