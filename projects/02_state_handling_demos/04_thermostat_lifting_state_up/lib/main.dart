import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'ui/main/main_page.dart';
import 'thermostat_state.dart';

void main() => runApp(ThermostatApp());

class ThermostatApp extends StatefulWidget {
  @override
  _ThermostatAppState createState() => _ThermostatAppState();
}

class _ThermostatAppState extends State<ThermostatApp> {
  var state = ThermostatState();

  Timer _worldTimer;

  void _handleWorldTimerEvent(Timer timer) {
    setState(() {
      if (state.currentTemperature > state.targetTemperature) {
        state = ThermostatState(
            currentTemperature: state.currentTemperature - 1,
            targetTemperature: state.targetTemperature,
            actionInProgress: ActionInProgress.COOLING);
      } else if (state.currentTemperature < state.targetTemperature) {
        state = ThermostatState(
            currentTemperature: state.currentTemperature + 1,
            targetTemperature: state.targetTemperature,
            actionInProgress: ActionInProgress.WARMING);
      } else {
        timer.cancel();
        _worldTimer = null;
        state = ThermostatState(
            currentTemperature: state.currentTemperature,
            targetTemperature: state.targetTemperature,
            actionInProgress: ActionInProgress.IDLE);
      }
    });
  }

  void _setWarmer() {
    setState(() {
      if (state.targetTemperature < MAX_TEMP) {
        state = ThermostatState(
            currentTemperature: state.currentTemperature,
            targetTemperature: state.targetTemperature + 1,
            actionInProgress: state.actionInProgress);
        _startWorldTimer();
      }
    });
  }

  void _setColder() {
    setState(() {
      if (state.targetTemperature > MIN_TEMP) {
        state = ThermostatState(
            currentTemperature: state.currentTemperature,
            targetTemperature: state.targetTemperature - 1,
            actionInProgress: state.actionInProgress);
        _startWorldTimer();
      }
    });
  }

  void _cancelWorldTimer() {
    if (_worldTimer != null) {
      _worldTimer.cancel();
      _worldTimer = null;
    }
  }

  void _startWorldTimer() {
    if (_worldTimer == null) {
      _worldTimer =
          Timer.periodic(Duration(seconds: 1), _handleWorldTimerEvent);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Thermostat',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainPage(
        title: 'Thermostat',
        appState: state,
        setWarmer: _setWarmer,
        setColder: _setColder,
      ),
    );
  }

  @override
  void dispose() {
    _cancelWorldTimer();
    super.dispose();
  }
}
