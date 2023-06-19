import 'package:extension_google_sign_in_as_googleapis_auth/extension_google_sign_in_as_googleapis_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/calendar/v3.dart';
import 'package:googleapis_auth/src/auth_client.dart';
import 'package:oauth2/oauth2.dart';

class AuthService {

    final GoogleSignIn signIn = GoogleSignIn(
      scopes: [CalendarApi.calendarEventsScope], 
    );

  signInWithGoogle() async {
    GoogleSignInAccount? _gUser = await signIn.signIn();
    GoogleSignInAuthentication gAuth = await _gUser!.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );

    UserCredential authUser = await FirebaseAuth.instance.signInWithCredential(credential);

    return authUser; 
  }

  Future<AuthClient?> getAuthedClient() async{
        return signIn.authenticatedClient();
  }
  
}
