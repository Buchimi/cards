import 'package:cards/pages/deck_page.dart';
import 'package:cards/pages/home.dart';
import 'package:cards/services/local_store.dart';
import 'package:flutter/material.dart';
import 'package:cards/models/card.dart' as card_model;

late LocalStore store;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  store = await LocalStore.create();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Home page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<card_model.Card> cards = [];
  int index = 0;

  Widget choosePage(int index) {
    switch (index) {
      case 0:
        return const HomePage();
      case 1:
        return const DeckPage();
      default:
        return const HomePage();
    }
  }

  @override
  Widget build(BuildContext context) {
    //floatingActionButton: FloatingActionButton(onPressed: () {}),
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: "Home"),
          NavigationDestination(icon: Icon(Icons.shelves), label: "Decks")
        ],
        onDestinationSelected: (value) {
          setState(() {
            index = value;
            print(index);
          });
        },
      ),
      body: choosePage(index),
      appBar: AppBar(
        title: const Text("Home page"),
      ),
    );
  }
}
