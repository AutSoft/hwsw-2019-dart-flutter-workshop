import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:thermostat_lifting_state_up/state_holder_inherited_widget.dart';
import 'package:thermostat_lifting_state_up/thermostat_state.dart';
import 'package:thermostat_lifting_state_up/ui/main/widgets/main_controls.dart';

import 'widgets/action_indicator.dart';
import 'widgets/current_temperature.dart';
import 'widgets/target_temperature.dart';

class MainPage extends StatelessWidget {
  final String title;

  final Function setWarmer;

  final Function setColder;

  MainPage({Key key, this.title, this.setWarmer, this.setColder})
      : super(key: key);

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
          MainControls(setColder: setColder, setWarmer: setWarmer),
        ],
      ),
    );
  }
}
