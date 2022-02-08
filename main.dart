import 'package:flutter/material.dart';

void main() {
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
      home: const MyHomePage(title: '💀️ The Crypt 💀️'),
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
  int _pageIndex = 0;
  static const List<Widget> _pageOption = [
    Text("Contacts"),
    Text("personal keys"),
    Text("Encrypt/ decrypt"),
  ];
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
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: FloatingActionButton(
        onPressed: null,
        backgroundColor: green,
        splashColor: cyan,
        hoverColor: cyan,
        tooltip: 'add',
        child: const Icon(Icons.add),
      ),
      // Allows button to be over the Appbar
      // NAV BAR
      // colors should be dark blue with three icons
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
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
