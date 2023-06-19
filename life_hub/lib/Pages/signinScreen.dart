import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:life_hub/Pages/resetPasswordScreen.dart';
import 'package:life_hub/Pages/signupScreen.dart';
import 'package:life_hub/Widgets/widgetComponents.dart';
import 'package:life_hub/Widgets/widgetList.dart';
import 'package:life_hub/Widgets/widgetWeather.dart';
import 'package:life_hub/main.dart';
import 'package:life_hub/services/auth_services.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final double? widthOfDevice = MediaQuery.of(context).size.width;

    return Scaffold(
      body: ListView(
        children: [
          const SizedBox(
            height: 90,
          ),
          Container(
              alignment: Alignment.centerRight,
              width: widthOfDevice,
              child: const Image(
                image: AssetImage('assets/images/lifehub.png'),
                height: 200,
              )),
          const SizedBox(
            height: 30,
          ),
          MyTextField(
              controller: _emailTextController,
              hintText: "Email",
              obscureText: false),
          const SizedBox(
            height: 20,
          ),
          MyTextField(
              controller: _passwordTextController,
              hintText: "Password",
              obscureText: true),
          const SizedBox(
            height: 5,
          ),
          forgetPassword(),
          MyButton(
              title: "Sign In",
              onTap: () {
                FirebaseAuth.instance
                    .signInWithEmailAndPassword(
                        email: _emailTextController.text,
                        password: _passwordTextController.text)
                    .then((value) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HomeScreen(
                                shoppingWidget:
                                    ShoppingWidget(color: Colors.red),
                                todoWidget: TODOWidget(color: Colors.blue),
                                weatherScreen: WeatherScreen(),
                              )));
                }).onError((error, stackTrace) {
                  print("Error ${error.toString()}");
                });
              }),
          signUpOption()
        ],
      ),
    );
  }

  Widget forgetPassword() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 35,
      alignment: Alignment.bottomRight,
      child: TextButton(
        child: const Text(
          "Forgot Password?",
          style: TextStyle(color: Color.fromRGBO(36, 94, 94, 1.0)),
          textAlign: TextAlign.right,
        ),
        onPressed: () => Navigator.push(context,
            MaterialPageRoute(builder: (context) => const ResetPassword())),
      ),
    );
  }

  Widget signUpOption() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text("Don't have an account?",
                  style: TextStyle(color: Colors.black)),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SignUpScreen()));
                },
                child: const Text(
                  " Register now",
                  style: TextStyle(
                      color: Color.fromRGBO(36, 94, 94, 1.0),
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          const Row(
            children: [
              Expanded(
                child: Divider(
                  thickness: 0.8,
                  color: Color.fromRGBO(36, 94, 94, 1.0),
                ),
              ),
              Text(' Or continue with google '),
              Expanded(
                child: Divider(
                  thickness: 0.8,
                  color: Color.fromRGBO(36, 94, 94, 1.0),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 24,
          ),
          GestureDetector(
            child: Container(
              height: 60,
              child: GestureDetector(
                  onTap: () {
                    AuthService().signInWithGoogle().then((value) {
                      print("duxk duf");
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HomeScreen(
                                shoppingWidget:
                                    ShoppingWidget(color: Colors.red),
                                todoWidget: TODOWidget(color: Colors.blue),
                                weatherScreen: WeatherScreen(),
                              )));
                });
                  },
                  child: Image.asset('assets/images/google.png')),
            ),
          )
        ],
      ),
    );
  }

  void signInWithGoogle() {
    print("I dont do shit");
  }
}
