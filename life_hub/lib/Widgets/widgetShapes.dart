import 'package:flutter/material.dart';
import 'package:life_hub/Widgets/widgetSetup.dart';

@override
Widget square(BuildContext context) {
  return Card(
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20))),
    child: SizedBox(
      width: getWidth(context) * 0.47,
      height: getWidth(context) * 0.47,
    ),
  );
}

@override
Widget Rectangle(BuildContext context) {
  return Card(
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20))),
    child: SizedBox(
      width: getWidth(context) * 0.47 * 2,
      height: getWidth(context) * 0.47,
    ),
  );
}

class Square extends Card {
  const Square({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: SizedBox(
        width: getWidth(context) * 0.47,
        height: getWidth(context) * 0.47,
      ),
    );
  }
}
