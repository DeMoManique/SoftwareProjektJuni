import 'package:flutter/material.dart';
import 'package:life_hub/Widgets/widgetSetup.dart';
import 'package:life_hub/Widgets/widgetShapes.dart';

class ListWidget extends StatefulWidget {
  final Function list;
  final String screenName;
  final _ListWidgetState _listWidgetState;
  final Color color;
  ListWidget(
      {super.key,
      required this.screenName,
      required this.list,
      required this.color})
      : _listWidgetState =
            _ListWidgetState(list: list, screenName: screenName, color: color);

  @override
  State<ListWidget> createState() => _listWidgetState;
}

class _ListWidgetState extends State<ListWidget> {
  final Function list;
  final String screenName;
  final Color color;

  _ListWidgetState(
      {required this.list, required this.screenName, required this.color});
  refresh() {
    setState(() {});
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Square(
      context,
      color: color,
      child: ListView(
        children: StringListToTextList(list()),
      ),
      function: () {
        Navigator.pushNamed(context, '$screenName');
      },
    );
  }

  List<Widget> StringListToTextList(List<String>? list) {
    List<Widget> result = [];
    for (String element in list!) {
      result.add(Text(
        '• $element',
        style: TextStyle(fontSize: 24),
      ));
    }
    return result;
  }
}

class ListWidgetScreen extends StatefulWidget {
  final String name;
  final Function list;
  final ListWidget parentWidget;
  ListWidgetScreen(
      {super.key,
      required this.name,
      required this.list,
      required this.parentWidget});
  @override
  State<ListWidgetScreen> createState() =>
      _ListWidgetScreenState(name, list, parentWidget);
}

class _ListWidgetScreenState extends State<ListWidgetScreen> {
  final String name;
  final Function list;
  final ListWidget parentWidget;
  _ListWidgetScreenState(this.name, this.list, this.parentWidget);

  refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            parentWidget._listWidgetState.refresh();
            Navigator.of(context).pop();
          },
        ),
        title: Text(name),
      ),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: StringListToTextListForScreen(list(), context, refresh),
        ),
      )),
      floatingActionButton: ElevatedButton.icon(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) =>
                  _buildPopupDialog(context, refresh, list),
            );
          },
          icon: Icon(Icons.add),
          label: Text('add')),
    );
  }

  List<Widget> StringListToTextListForScreen(
      List<String>? list, BuildContext context, Function function) {
    List<Widget> result = [];
    for (String element in list!) {
      result.add(GestureDetector(
        onTap: () {
          list.remove(element);
          refresh();
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
}

Widget _buildPopupDialog(
    BuildContext context, Function function, Function list) {
  final TextEditingController controller = TextEditingController();
  return AlertDialog(
    title: const Text('Add element to list'),
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
          list().add(controller.text);
          function();
          Navigator.of(context).pop();
        },
        child: const Text('Add'),
      ),
      ElevatedButton(
        onPressed: () {
          function();
          Navigator.of(context).pop();
        },
        child: const Text('Cancel'),
      ),
    ],
  );
}

class ShoppingWidget extends ListWidget {
  ShoppingWidget(
      {super.key,
      super.screenName = '/ShoppingScreen',
      super.list = getShoppingList,
      required super.color});
}

class TODOWidget extends ListWidget {
  TODOWidget(
      {super.key,
      super.screenName = '/TODOScreen',
      super.list = getTODOList,
      required super.color});
}

class ShoppingListScreen extends ListWidgetScreen {
  ShoppingListScreen(
      {super.name = 'Shopping List',
      super.list = getShoppingList,
      required super.parentWidget});
}

class TodoListScreen extends ListWidgetScreen {
  TodoListScreen(
      {super.name = 'TODO list',
      super.list = getTODOList,
      required super.parentWidget});
}
