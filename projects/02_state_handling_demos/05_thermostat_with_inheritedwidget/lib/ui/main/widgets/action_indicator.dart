import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../state_holder_inherited_widget.dart';
import '../../../thermostat_state.dart';

class ActionIndicator extends StatelessWidget {
  const ActionIndicator({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color color;
    String text;

    final state = StateHolderInheritedWidget.of(context).state;

    switch (state.actionInProgress) {
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
}
