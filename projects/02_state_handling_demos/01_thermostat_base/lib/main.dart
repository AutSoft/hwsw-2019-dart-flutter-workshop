import 'dart:async';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const int MAX_TEMP = 30;
const int MIN_TEMP = 16;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Thermostat',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainPage(title: 'Thermostat'),
    );
  }
}

class MainPage extends StatefulWidget {
  MainPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  static const IDLE_STATUS_COLOR = Colors.transparent;
  
  int _currentTemperature = 22;
  int _targetTemperature = 22;
  Color _status = IDLE_STATUS_COLOR;
  
  Timer _worldTimer;

  void _setWarmer() {
    setState(() {
      if (_targetTemperature < MAX_TEMP) {
        _targetTemperature++;
        _startWorldTimer();
      }
    });
  }

  void _setColder() {
    setState(() {
      if (_targetTemperature > MIN_TEMP) {
        _targetTemperature--;
        _startWorldTimer();
      }
    });
  }

  void _handleWorldTimerEvent(Timer timer) {
    setState(() {
      if (_currentTemperature > _targetTemperature) {
        _currentTemperature--;
        _status = Colors.blue;
      } else if (_currentTemperature < _targetTemperature) {
        _currentTemperature++;
        _status = Colors.red;
      } else {
        timer.cancel();
        _worldTimer = null;
        _status = IDLE_STATUS_COLOR;
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
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Current temperature\n$_currentTemperature °C",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 30),
                ),
                Padding(
                    padding: EdgeInsets.only(top: 40),
                    child: Text(
                      "Target temperature\n$_targetTemperature °C",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 30),
                    )),
                Padding(
                  padding: EdgeInsets.only(top: 40),
                  child: SizedBox(
                    height: 20,
                    width: 120,
                    child: Container(
                      color: _status,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 40),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        FloatingActionButton(
                          onPressed: _setColder,
                          tooltip: 'Colder',
                          child: Icon(Icons.remove),
                        ),
                        SizedBox(
                          width: 40,
                        ),
                        FloatingActionButton(
                          onPressed: _setWarmer,
                          tooltip: 'Warmer',
                          child: Icon(Icons.add),
                        ),
                      ]),
                )
              ],
            )));
  }

  @override
  void dispose() {
    _cancelWorldTimer();
    super.dispose();
  }
}
