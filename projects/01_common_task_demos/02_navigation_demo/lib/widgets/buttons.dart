import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Buttons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image(
              image: NetworkImage(
                  "https://i.kym-cdn.com/photos/images/newsfeed/000/115/357/portal-cake.jpg?1318992465"),
            ),
            FlatButton(
              onPressed: () {},
              child: Text(
                "Go for the cake".toUpperCase(),
                style: TextStyle(color: Colors.red),
              ),
            ),
            RaisedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("The cake is a lie".toUpperCase()),
            )
          ],
        ),
      ),
    );
  }
}
