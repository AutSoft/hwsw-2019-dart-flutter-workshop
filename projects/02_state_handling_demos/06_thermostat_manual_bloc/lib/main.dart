import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'ui/main/main_bloc.dart';
import 'ui/main/main_page.dart';
import 'ui/main/state_holder_inherited_widget.dart';

void main() => runApp(ThermostatApp());

class ThermostatApp extends StatefulWidget {
  @override
  _ThermostatAppState createState() => _ThermostatAppState();
}

class _ThermostatAppState extends State<ThermostatApp> {
  final MainBloc mainBloc = MainBloc();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Thermostat',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StateHolderInheritedWidget(
        bloc: mainBloc,
        child: MainPage(
          title: 'Thermostat',
        ),
      ),
    );
  }

  @override
  void dispose() {
    mainBloc.dispose();
    super.dispose();
  }
}
