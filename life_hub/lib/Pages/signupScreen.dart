import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:life_hub/Widgets/widgetComponents.dart';
import 'package:life_hub/Widgets/widgetList.dart';
import 'package:life_hub/main.dart';

import 'package:life_hub/Widgets/widgetWeather.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _userNameTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final double? widthOfDevice = MediaQuery.of(context).size.width;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color.fromRGBO(36, 94, 94, 1.0)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Sign Up",
          style: TextStyle(
              color: Color.fromRGBO(36, 94, 94, 1.0),
              fontSize: 24,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 60,
          ),
          Container(
              alignment: Alignment.centerRight,
              width: widthOfDevice,
              child: Image(
                image: AssetImage('assets/images/lifehub.png'),
                height: 200,
              )),
          const SizedBox(
            height: 30,
          ),
          MyTextField(
            controller: _userNameTextController,
            hintText: "Username",
            obscureText: false,
          ),
          const SizedBox(
            height: 20,
          ),
          MyTextField(
            controller: _emailTextController,
            hintText: "Email",
            obscureText: false,
          ),
          const SizedBox(
            height: 20,
          ),
          MyTextField(
            controller: _passwordTextController,
            hintText: "Enter Password",
            obscureText: true,
          ),
          const SizedBox(
            height: 20,
          ),
          MyButton(
              title: "Sign Up",
              onTap: () {
                signUp();
              })
        ],
      ),
    );
  }

  void signUp() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: _emailTextController.text.trim(),
              password: _passwordTextController.text.trim());

      User? user = userCredential.user;
      if (user != null) {
        await user.updateDisplayName(_userNameTextController.text.trim());

        print("Created New Account");
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => HomeScreen(
                      shoppingWidget: ShoppingWidget(color: Colors.red),
                      todoWidget: TODOWidget(color: Colors.blue),
                      weatherScreen: WeatherScreen(),
                    )));
      }
    } catch (e) {
      if (e is FirebaseAuthException) {
        if (e.code == 'invalid-email') {
          print('Invalid email format');
        } else {
          print('Authentication error: ${e.code}');
        }
      } else {
        print('Error: $e');
      }
    }
  }
}
