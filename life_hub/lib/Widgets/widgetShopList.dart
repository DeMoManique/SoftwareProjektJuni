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
    result.add(Text(
      '• $element',
      style: TextStyle(fontSize: 24),
    ));
  }
  return result;
}

class ShoppingScreen extends StatefulWidget {
  const ShoppingScreen({super.key});

  @override
  State<ShoppingScreen> createState() => _ShoppingScreenState();
}

class _ShoppingScreenState extends State<ShoppingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ShoppingList'),
      ),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: StringListToTextListForScreen(
              getShoppingList(), context, refresh),
        ),
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) =>
                _buildPopupDialog(context, refresh),
          );
        },
        child: Text('data'),
      ),
    );
  }

  refresh() {
    setState(() {});
  }
}

List<Widget> StringListToTextListForScreen(
    List<String>? ShoppingList, BuildContext context, Function function) {
  List<Widget> result = [];
  for (String element in ShoppingList!) {
    result.add(GestureDetector(
      onTap: () {
        ShoppingList.remove(element);
        print(ShoppingList);
        function();
      },
      child: Text(
        '• $element',
        style: TextStyle(fontSize: 24),
      ),
    ));
  }
  return result;
}

Widget _buildPopupDialog(BuildContext context, Function function) {
  final TextEditingController controller = TextEditingController();

  return AlertDialog(
    title: const Text('Add element to shopping list'),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TextField(
          controller: controller,
        )
      ],
    ),
    actions: <Widget>[
      ElevatedButton(
        onPressed: () {
          getShoppingList().add(controller.text);
          print(controller.text);
          function();
          Navigator.of(context).pop();
        },
        child: const Text('add'),
      ),
      ElevatedButton(
        onPressed: () {
          function();
          Navigator.of(context).pop();
        },
        child: const Text('Close'),
      ),
    ],
  );
}
