import 'package:flutter/material.dart';
import 'package:life_hub/Widgets/widgetSetup.dart';

class Shape extends Card {
  double? height;
  double? width;
  Function function;
  Shape(BuildContext context,
      {super.key,
      super.child,
      super.color,
      this.height,
      this.width,
      required this.function});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {function()},
      child: Card(
          color: color,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: SizedBox(
              width: getWidth(context) * width!,
              height: getWidth(context) * height!,
              child: Padding(padding: const EdgeInsets.all(10), child: child))),
    );
  }
}

class Square extends Shape {
  Square(super.context,
      {super.key,
      super.child,
      super.color,
      super.height = 0.47,
      super.width = 0.47,
      required super.function});
}

class HoriRectangle extends Shape {
  HoriRectangle(super.context,
      {super.key,
      super.child,
      super.color,
      super.height = 0.47,
      super.width = 0.97,
      required super.function});
}

class VertRectangle extends Shape {
  VertRectangle(super.context,
      {super.key,
      super.child,
      super.color,
      super.height = 0.97,
      super.width = 0.47,
      required super.function});
}

class BigSquare extends Square {
  BigSquare(super.context,
      {super.key,
      super.child,
      super.color,
      super.height = 0.97,
      super.width = 0.97,
      required super.function});
}
