import 'package:flutter/material.dart';

import 'widgets/buttons.dart';
import 'widgets/login_screen.dart';

void main() => runApp(RouteNavigationShowcaseApp());

class ManualNavigationShowcaseApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HWSW19 UI Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(title: 'UI Demo'),
    );
  }
}

final homeRoute = "/";
final cakeRoute = "/cake";

class RouteNavigationShowcaseApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HWSW19 UI Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: homeRoute,
      routes: {
        homeRoute: (context) => HomePage(title: 'UI Demo'),
        cakeRoute: (context) => Buttons()
      },
//      home:  HomePage(title: 'UI Demo'),
    );
  }
}

class HomePage extends StatelessWidget {
  final colors = [Colors.red, Colors.blue, Colors.green, Colors.amber];

  final String title;

  HomePage({Key key, @required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: LoginScreen(),
    );
  }
}
