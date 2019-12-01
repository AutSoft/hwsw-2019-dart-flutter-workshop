import 'package:flutter/widgets.dart';
import '../state_holder_inherited_widget.dart';

class CurrentTemperature extends StatelessWidget {
  CurrentTemperature({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = StateHolderInheritedWidget.of(context).bloc;

    return StreamBuilder<int>(
        initialData: 22,
        stream: bloc.currentTemperature,
        builder:
            (BuildContext context, AsyncSnapshot<int> snapshot) {
          return Text(
            "Current temperature\n${snapshot.data} °C",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 30),
          );
        });
  }
}
