import 'package:flutter/widgets.dart';

double getWidth(BuildContext context) {
  double width = MediaQuery.of(context).size.width;
  return width;
}

String getName() {
  return 'Lucas';
}

List<String> getShoppingList() {
  //TODO få indkøbsliste fra database?
  return tempShop;
}

List<String> tempShop = [
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
