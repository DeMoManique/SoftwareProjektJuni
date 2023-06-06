
import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Namer App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
   return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Align(
          alignment: Alignment.centerLeft,
          child: Text('Hej Lucas'),
        ),
        backgroundColor: Color.fromARGB(255, 28, 89, 92), 
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child:Align(
        alignment: Alignment.topLeft,
        child: _SquareField("Jeg er din mor")
      ),
    ),
      backgroundColor: Color.fromARGB(223, 254, 254, 254),
    );
  }
}

class _SquareField extends StatelessWidget{
  String? cardText;
  _SquareField(String text){
    cardText = text;
  }
  @override
  Widget build(BuildContext context){
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20))
      ),
      child: SizedBox(
        width: 210,
        height: 210,
        child: Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              '$cardText',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
            )
          )
        ),
      ), 
    );
  }
}
