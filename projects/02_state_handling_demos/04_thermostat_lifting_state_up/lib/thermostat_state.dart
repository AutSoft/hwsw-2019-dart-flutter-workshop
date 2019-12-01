import 'package:flutter/foundation.dart';

enum ActionInProgress { IDLE, COOLING, WARMING }

@immutable
class ThermostatState {
  final int currentTemperature;
  final int targetTemperature;
  final ActionInProgress actionInProgress;

  ThermostatState(
      {this.currentTemperature = 22,
      this.targetTemperature = 22,
      this.actionInProgress = ActionInProgress.IDLE});
}
