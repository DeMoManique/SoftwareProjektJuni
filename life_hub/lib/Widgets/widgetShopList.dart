import 'package:flutter/material.dart';
import 'package:life_hub/Widgets/widgetSetup.dart';
import 'package:life_hub/Widgets/widgetShapes.dart';

@override
Widget ShopWidget(BuildContext context) {
  return Square(
    context,
    color: Colors.yellow[700],
    child: ListView(
      children: StringListToTextList(getShoppingList()),
    ),
    function: () {
      Navigator.pushNamed(context, '/ShoppingScreen');
    },
  );
}

List<Widget> StringListToTextList(List<String>? ShoppingList) {
  List<Widget> result = [];
  for (String element in ShoppingList!) {
    result.add(Text(element));
  }
  return result;
}

class ShoppingScreen extends StatelessWidget {
  const ShoppingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ShoppingList'),
      ),
      body: Center(
        child: ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Go Back!')),
      ),
    );
  }
}
