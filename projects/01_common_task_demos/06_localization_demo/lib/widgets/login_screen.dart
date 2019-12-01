import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.android,
                color: Colors.green,
                size: 60,
              ),
              Icon(
                Icons.announcement,
                color: Colors.blueAccent,
                size: 60,
              )
            ],
          ),
          TextField(
            decoration: InputDecoration(
                alignLabelWithHint: true, labelText: FlutterI18n.translate(context, "email_address")),
            keyboardType: TextInputType.emailAddress,
          ),
          TextField(
            decoration: InputDecoration(
                alignLabelWithHint: true, labelText: FlutterI18n.translate(context, "password")),
            keyboardType: TextInputType.visiblePassword,
            obscureText: true,
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: ButtonTheme(
              minWidth: 200.0,
              child: RaisedButton(
                onPressed: () {
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                          FlutterI18n.translate(context, "login_unsuccessful")),
                    ),
                  );
                },
                child: Text(FlutterI18n.translate(context, "login_button").toUpperCase()),
              ),
            ),
          )
        ],
      ),
    );
  }
}
