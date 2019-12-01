import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:html_unescape/html_unescape.dart';

import 'network/api/stack_overflow_api.dart';
import 'network/model/questions_response.dart';

void main() => runApp(LocalizationDemoApp());

class LocalizationDemoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HWSW19 Network Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(title: 'Network Demo'),
    );
  }
}

class HomePage extends StatelessWidget {
  final String title;

  HomePage({Key key, @required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final htmlUnescape = HtmlUnescape();

    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: FutureBuilder(
            future: stackOverflowApi.getQuestions(),
            initialData: null,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasError)
                return Center(child: Text("Error while loading questions!"));
              if (snapshot.data == null) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              final questions = snapshot.data.items;
              return ListView.builder(
                itemCount: questions.length,
                itemBuilder: (context, position) {
                  final question = questions[position];
                  return ListTile(
                    title: Text(htmlUnescape.convert(question.title)),
                    subtitle:
                        Text(htmlUnescape.convert(question.owner.displayName)),
                  );
                },
              );
            }));
  }
}
