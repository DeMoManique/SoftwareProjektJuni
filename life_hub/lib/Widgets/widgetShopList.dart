import 'package:flutter/material.dart';
import 'package:life_hub/Widgets/widgetShapes.dart';

@override
Widget ShopWidget(BuildContext context) {
  return Square(
    context,
    color: Colors.yellow[700],
    child: ListView(
      children: StringListToTextList(getShoppingList()),
    ),
  );
}

List<Widget> StringListToTextList(List<String>? ShoppingList) {
  List<Widget> result = [];
  for (String element in ShoppingList!) {
    result.add(Text(element));
  }
  return result;
}

List<String> getShoppingList() {
  return [
    'mel',
    'æg',
    'vanilje',
    'pølser',
    'gulerødder',
    'Christopher',
    'hvide drenge',
    'brød',
    'olie',
    'mælk',
    'en hel gris',
  ];
}
