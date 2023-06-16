import 'package:flutter/widgets.dart';

double getWidth(BuildContext context) {
  double width = MediaQuery.of(context).size.width;
  return width;
}

double getHeight(BuildContext context) {
  double height = MediaQuery.of(context).size.height;
  return height;
}

String getName() {
  return 'Lucas';
}

List<String> getShoppingList() {
  //TODO få indkøbsliste fra database?
  return tempShop;
}

List<String> tempShop = [];

List<String> getTODOList() {
  //TODO få indkøbsliste fra database?
  return tempTODO;
}

List<String> tempTODO = [];
