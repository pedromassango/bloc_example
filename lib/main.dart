import 'package:flutter/material.dart';
import 'package:flutter_bloc_example/src/pages/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "BLoC Pattern",
      theme: ThemeData(
          primarySwatch: Colors.amber
      ),
      home: HomePage(),
    );
  }
}