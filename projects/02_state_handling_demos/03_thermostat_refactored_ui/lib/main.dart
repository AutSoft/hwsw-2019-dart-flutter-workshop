import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'ui/main/main_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Thermostat',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainPage(title: 'Thermostat'),
    );
  }
}
