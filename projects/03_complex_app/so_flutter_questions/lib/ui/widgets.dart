import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ErrorView extends StatelessWidget {
  final Function retryAction;

  ErrorView({Key key, this.retryAction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Text("There was a problem while loading content!"),
          RaisedButton(
            child: Text("Retry"),
            onPressed: retryAction,
          )
        ],
      ),
    );
  }
}

class LoadingView extends StatelessWidget {
  const LoadingView({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}

class EmptyView extends StatelessWidget {
  final Function retryAction;

  EmptyView({Key key, this.retryAction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Text("Nothing here :("),
          RaisedButton(
            child: Text("Try again"),
            onPressed: retryAction,
          )
        ],
      ),
    );
  }
}
