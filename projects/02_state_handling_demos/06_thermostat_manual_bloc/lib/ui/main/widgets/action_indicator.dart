import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../main_bloc.dart';
import '../state_holder_inherited_widget.dart';

class ActionIndicator extends StatelessWidget {
  const ActionIndicator({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = StateHolderInheritedWidget.of(context).bloc;

    return StreamBuilder<ActionInProgress>(
        initialData: ActionInProgress.IDLE,
        stream: bloc.actionInProgress,
        builder:
            (BuildContext context, AsyncSnapshot<ActionInProgress> snapshot) {
          Color color;
          String text;

          switch (snapshot.data) {
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
        });
  }
}
