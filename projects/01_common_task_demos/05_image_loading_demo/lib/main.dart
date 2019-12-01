import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(LocalizationDemoApp());

class LocalizationDemoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HWSW19 Image Loading Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(title: 'Image Loading Demo'),
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
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text("Images from assets"),
              ),
              Image.asset("assets/images/dart.jpg"),
              Image.asset("assets/images/flutter.jpg"),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text("Images from the Internet"),
              ),
              Image.network(
                  "https://images.pexels.com/photos/126407/pexels-photo-126407.jpeg?cs=srgb&dl=animal-cat-cute-126407.jpg"),
              Image.network(
                "https://images.pexels.com/photos/384555/pexels-photo-384555.jpeg?cs=srgb&dl=adorable-animal-cat-384555.jpg",
                loadingBuilder: (context, child, loadingProgress) {
                  if(loadingProgress == null) return child;
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: CircularProgressIndicator(),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
