import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'widgets/action_indicator.dart';
import 'widgets/current_temperature.dart';
import 'widgets/main_controls.dart';
import 'widgets/target_temperature.dart';

class MainPage extends StatelessWidget {
  final String title;

  MainPage({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: _buildBody());
  }

  Widget _buildBody() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CurrentTemperature(),
          TargetTemperature(),
          ActionIndicator(),
          MainControls(),
        ],
      ),
    );
  }
}
