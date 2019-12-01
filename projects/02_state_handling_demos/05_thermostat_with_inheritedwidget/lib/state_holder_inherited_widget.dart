import 'package:flutter/widgets.dart';

import 'thermostat_state.dart';

class StateHolderInheritedWidget extends InheritedWidget {
  final ThermostatState state;

  StateHolderInheritedWidget({
    Key key,
    this.state,
    @required Widget child
  }): super(key: key, child: child);

  static StateHolderInheritedWidget of(BuildContext context){
    return context.inheritFromWidgetOfExactType(StateHolderInheritedWidget);
  }

  @override
  bool updateShouldNotify(StateHolderInheritedWidget oldWidget) {
    return state.currentTemperature != oldWidget.state.currentTemperature &&
        state.targetTemperature != oldWidget.state.targetTemperature &&
        state.actionInProgress != oldWidget.state.actionInProgress;
  }


}
