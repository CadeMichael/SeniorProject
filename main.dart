import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'key_list.dart';
import 'personal_key.dart';
import 'crypt.dart';
import 'package:the_crypt/contact_key.dart';

void main() async {
  // instatiating hive 
  await Hive.initFlutter();
  Hive.registerAdapter(ContactKeyAdapter());
  runApp(const MyApp());
}

const Color cyan = Color(0xFF8be9fd);
const Color lightPurp = Color(0xFFbd93f9);
const Color darkBlue = Color(0xFF44475a);
const Color darkBG = Color(0xFF282a36);
const Color green = Color(0xFF50fa7b);

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        canvasColor: darkBG,
        cardColor: darkBlue,
        brightness: Brightness.dark,
      ),
      home: const MyHomePage(title: 'The Crypt 💀️'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  /// determine body widget ie page to be rendered
  int _pageIndex = 0;

  /// list of body widgets
  static const List<Widget> _pageOption = [
    KeyList(), //index 0
    PersonalKey(), //index 1
    Crypt(), //index 2
  ];

  /// [index] tells body of scaffold what widget to render
  void _changePage(int index) {
    setState(() {
      _pageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: const TextStyle(color: cyan),
        ),
      ),
      body: Center(
        child: _pageOption.elementAt(_pageIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false, //hide icon labels
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.vpn_key,
              size: 44,
            ),
            label: 'Keys',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.lock,
              size: 44,
            ),
            label: 'Pairs',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.message,
              size: 44,
            ),
            label: 'Encrypt',
          ),
        ],
        // need to add index logic to change page
        currentIndex: _pageIndex,
        selectedItemColor: lightPurp,
        onTap: _changePage,
        backgroundColor: darkBlue,
      ),
    );
  }
}
