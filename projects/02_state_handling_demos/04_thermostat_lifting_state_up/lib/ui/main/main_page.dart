import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:thermostat_lifting_state_up/themostat_state.dart';

const int MAX_TEMP = 30;
const int MIN_TEMP = 16;
const IDLE_STATUS_COLOR = Colors.transparent;

class MainPage extends StatelessWidget {
  final String title;

  final ThermostatState appState;

  final Function setWarmer;

  final Function setColder;

  MainPage({Key key, this.title, this.appState, this.setWarmer, this.setColder})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: _buildBody(appState));
  }

  Widget _buildBody(ThermostatState appState) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _buildCurrentTemperature(appState),
          _buildTargetTemperature(appState),
          _buildActionIndicator(appState),
          _buildControls(setWarmer, setColder),
        ],
      ),
    );
  }

  Widget _buildControls(Function setWarmer, Function setColder) {
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

  Widget _buildActionIndicator(ThermostatState appState) {
    Color color;
    String text;

    switch (appState.actionInProgress) {
      case ActionInProgress.IDLE:
        color = Colors.transparent;
        text = "";
        break;
      case ActionInProgress.COOLING:
        color = Colors.blue;
        text = "Cooling";
        break;
      case ActionInProgress.WARMING:
        color = Colors.red;
        text = "Warming";
        break;
    }

    return Padding(
      padding: EdgeInsets.only(top: 40),
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              height: 20,
              width: 120,
              child: Container(
                color: color,
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              "${text.toUpperCase()}",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildTargetTemperature(ThermostatState appState) {
    return Padding(
      padding: EdgeInsets.only(top: 40),
      child: Text(
        "Target temperature\n${appState.targetTemperature} °C",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 30),
      ),
    );
  }

  Widget _buildCurrentTemperature(ThermostatState appState) {
    return Text(
      "Current temperature\n${appState.currentTemperature} °C",
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 30),
    );
  }
}
