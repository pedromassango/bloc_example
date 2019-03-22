import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc_example/src/pages/home_page.dart';


class MyBlocDelegate extends BlocDelegate {

  @override
  void onTransition(Transition transition) {
    print(transition);
  }
}

void main() {
  // Start observing BLoC's state and events's transitions
  BlocSupervisor().delegate = MyBlocDelegate();

  runApp(MyApp());
}

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