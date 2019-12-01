import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'Todos.dart';

void main() => runApp(LocalizationDemoApp());

class LocalizationDemoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HWSW19 JSON Parsing Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(title: 'JSON Parsing Demo'),
    );
  }
}

class HomePage extends StatelessWidget {

  final String title;

  HomePage({Key key, @required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: FutureBuilder(
            future: rootBundle.loadString("assets/json/todos.json"),
            initialData: "",
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasError)
                return Center(child: Text("Error while loading JSON!"));
              final todos = Todos.fromJson(jsonDecode(snapshot.data)).todos;
              return ListView.builder(
                itemCount: todos.length,
                itemBuilder: (context, position) {
                  final todo = todos[position];
                  return ListTile(
                    trailing: Checkbox(
                        value: todo.completed,
                        onChanged: (value) {}),
                    title: Text(todo.title),
                    subtitle: Text(todo.dueDate),
                  );
                },
              );
            }));
  }
}

Future<String> loadJson() async {
  return await rootBundle.loadString("assets/json/todos.json");
}
