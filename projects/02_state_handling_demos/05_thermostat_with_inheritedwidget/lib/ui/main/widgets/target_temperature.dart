import 'package:flutter/widgets.dart';
import 'package:thermostat_lifting_state_up/state_holder_inherited_widget.dart';

class TargetTemperature extends StatelessWidget {
  const TargetTemperature({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final state = StateHolderInheritedWidget.of(context).state;

    return Padding(
      padding: EdgeInsets.only(top: 40),
      child: Text(
        "Target temperature\n${state.targetTemperature} °C",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 30),
      ),
    );
  }
}