import 'package:flutter/material.dart';

import 'widgets/login_screen.dart';

void main() => runApp(UiNavigationShowcaseApp());

class UiNavigationShowcaseApp extends StatelessWidget {
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

class HomePage extends StatelessWidget {
  final colors = [Colors.red, Colors.blue, Colors.green, Colors.amber];

  final String title;

  HomePage({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: loginScreen(),
//      body: grid(colors),
//      body: buttons(),
//      body: scrolling(),
    );
//    return collapsingToolbar(title, context);
  }
}
