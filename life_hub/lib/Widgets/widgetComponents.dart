import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final controller;
  final String hintText;
  final bool obscureText;

  const MyTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14.0),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
            enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              borderSide: BorderSide(color: Color.fromRGBO(36, 94, 94, 1.0)),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color.fromRGBO(36, 94, 94, 1.0)),
            ),
            fillColor: Colors.grey.shade200,
            filled: true,
            hintText: hintText,
            hintStyle: TextStyle(color: Color.fromRGBO(36, 94, 94, 1.0))),
      ),
    );
  }
}

class MyButton extends StatelessWidget {
  final Function()? onTap;
  final String title;

  const MyButton({super.key, required this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(25),
        margin: const EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          color: Color.fromRGBO(36, 94, 94, 1.0),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}

class myLeaderBoardCard extends StatelessWidget {
  final String pos;
  final String name;
  final Color;
  final String speed;
  final double padding;
  const myLeaderBoardCard(
      {required this.pos,
      required this.Color,
      required this.name,
      required this.padding,
      required this.speed});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      color: this.Color,
      child: Container(
        padding: EdgeInsets.fromLTRB(20, this.padding, 20, this.padding),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(this.pos,
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold)),
            Text(
              name,
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            Text(
              this.speed,
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
