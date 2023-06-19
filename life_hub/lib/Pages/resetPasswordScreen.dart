import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:life_hub/Widgets/widgetComponents.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final TextEditingController _emailTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color.fromRGBO(36, 94, 94, 1.0)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Reset Password",
          style: TextStyle(
              color: Color.fromRGBO(36, 94, 94, 1.0),
              fontSize: 24,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: ListView(
          children: [
            const SizedBox(height: 10),
            MyTextField(
              controller: _emailTextController,
              hintText: "Email",
              obscureText: false,
            ),
            const SizedBox(
              height: 20,
            ),
            MyButton(
                title: "Reset Password",
                onTap: () {
                  FirebaseAuth.instance
                      .sendPasswordResetEmail(email: _emailTextController.text)
                      .then((value) => Navigator.of(context).pop());
                })
          ],
        ),
      ),
    );
  }
}
