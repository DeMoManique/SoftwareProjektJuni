import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/calendar/v3.dart';

class AuthService {

  getSignIn() {
    GoogleSignIn? signIn = GoogleSignIn(
      scopes: [CalendarApi.calendarEventsScope], 
    );
    return signIn;
  }

  signInWithGoogle() async {
    final GoogleSignInAccount? gUser = await getSignIn().signIn();
    final GoogleSignInAuthentication gAuth = await gUser!.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
