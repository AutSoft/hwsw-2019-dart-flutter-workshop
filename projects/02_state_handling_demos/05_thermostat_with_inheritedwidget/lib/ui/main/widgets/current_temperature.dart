import 'package:flutter/widgets.dart';

import '../../../state_holder_inherited_widget.dart';

class CurrentTemperature extends StatelessWidget {
  CurrentTemperature({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = StateHolderInheritedWidget.of(context).state;

    return Text(
      "Current temperature\n${state.currentTemperature} °C",
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 30),
    );
  }
}
