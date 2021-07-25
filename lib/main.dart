import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:task_app/Screens/Screen1.dart';
import 'package:task_app/Screens/Screen2.dart';
import 'package:task_app/Screens/SignIn.dart';

import 'Screens/HomePage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FutureBuilder(
          future: _initialization,
          builder: (context, snapshot) {
            return snapshot.hasError
                ? Container(
                    child: Text('Something went wrong!'),
                  )
                : snapshot.connectionState == ConnectionState.done
                    ? SignIn()
                    : Center(child: CircularProgressIndicator());
          }),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  GlobalKey bottomNavigationKey = GlobalKey();
  int _page = 0;
  final screens = [MyHomePage(title: 'Data Screen'), Screen1(), Screen2()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _page,
        key: bottomNavigationKey,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today), label: 'Screen 1'),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today), label: 'Screen 2')
        ],
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
      ),
      body: screens[_page],
    );
  }
}
