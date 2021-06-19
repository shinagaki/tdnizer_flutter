import 'package:flutter/material.dart';
import 'screens/home.dart';
import 'screens/search.dart';

void main() {
  runApp(Tdnizer());
}

class Tdnizer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'tdnizer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => Home(),
        '/search': (context) => Search(),
      },
    );
  }
}
