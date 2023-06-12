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
      super.function = nullMethod});
}

class HoriRectangle extends Shape {
  HoriRectangle(super.context,
      {super.key,
      super.child,
      super.color,
      super.height = 0.47,
      super.width = 0.97,
      super.function = nullMethod});
}

class VertRectangle extends Shape {
  VertRectangle(super.context,
      {super.key,
      super.child,
      super.color,
      super.height = 0.97,
      super.width = 0.47,
      super.function = nullMethod});
}

class BigSquare extends Square {
  BigSquare(super.context,
      {super.key,
      super.child,
      super.color,
      super.height = 0.97,
      super.width = 0.97,
      super.function = nullMethod});
}

void nullMethod() {
  print('No Method Defined');
}
