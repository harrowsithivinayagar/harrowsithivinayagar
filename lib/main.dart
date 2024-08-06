import 'package:flutter/material.dart';
import 'package:harrowsithivinayagar/initialScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Harrowsithi Vinayagar Temple',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: const InitialScreen(),
    );
  }
}
