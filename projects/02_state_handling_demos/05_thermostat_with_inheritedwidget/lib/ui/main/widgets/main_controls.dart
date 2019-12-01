import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MainControls extends StatelessWidget {
  final Function setColder;

  final Function setWarmer;

  MainControls({Key key, this.setColder, this.setWarmer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FloatingActionButton(
            onPressed: setColder,
            tooltip: 'Colder',
            child: Icon(Icons.remove),
          ),
          SizedBox(
            width: 40,
          ),
          FloatingActionButton(
            onPressed: setWarmer,
            tooltip: 'Warmer',
            child: Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
