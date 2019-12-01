import 'package:flutter/widgets.dart';
import '../state_holder_inherited_widget.dart';

class TargetTemperature extends StatelessWidget {
  const TargetTemperature({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = StateHolderInheritedWidget.of(context).bloc;

    return StreamBuilder<int>(
        initialData: 22,
        stream: bloc.targetTemperature,
        builder:
            (BuildContext context, AsyncSnapshot<int> snapshot) {
          return Padding(
            padding: EdgeInsets.only(top: 40),
            child: Text(
              "Target temperature\n${snapshot.data} °C",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 30),
            ),
          );
        });
  }
}
