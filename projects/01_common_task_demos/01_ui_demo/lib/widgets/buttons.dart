import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

Widget buttons() {
  return Center(
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
          onPressed: () {},
          child: Text("The cake is a lie".toUpperCase()),
        )
      ],
    ),
  );
}
