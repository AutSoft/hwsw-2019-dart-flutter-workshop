# Ad hoc architecture

[Thermostat app](./projects/state_handling_demos/01_thermostat_base) has a considerable amount of state variables even on the scale of a simple app. In `_MainPageState` there's the current temperature, the target temperature, and the status color. There is also a `Timer` for simulation purposes. When adding more and more complexity to a screen, the number of variables and objects to maintain can get out of hand quickly.

For example, add a text representation of what's happening in the heating system and display this text over the existing colored representation:

```dart
int _currentTemperature = 22;
int _targetTemperature = 22;
Color _status = IDLE_STATUS_COLOR;
String _actionInProgress = "";
```

You also have to modify the UI ...

```dart
@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text(widget.title),
    ),
    body: Padding(
      padding: EdgeInsets.all(8),
      child: Column(
        // ...
          Padding(
            padding: EdgeInsets.only(top: 40),
            child: Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    height: 20,
                    width: 120,
                    child: Container(
                      color: _status,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "${_actionInProgress.toUpperCase()}",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
          ),
          // ...
        ],
      ),
    ),
  );
}
```

... and don't forget to update the value of the new property when an action is taking place.

```DART
void _handleWorldTimerEvent(Timer timer) {
  setState(() {
    if (_currentTemperature > _targetTemperature) {
      _currentTemperature--;
      _status = Colors.blue;
      _actionInProgress = "Cooling";
    } else if (_currentTemperature < _targetTemperature) {
      _currentTemperature++;
      _status = Colors.red;
      _actionInProgress = "Warming";
    } else {
      timer.cancel();
      _worldTimer = null;
      _status = IDLE_STATUS_COLOR;
      _actionInProgress = "";
    }
  });
}
```

By doing this, the view code becomes a bit more complex and it even has more business logic implemented in it.

This material covers a few methods which you can utilize to tame state handling in Flutter. 

But first, refactor the UI code to be more maintainable and reader-friendly. Move the widget codes to their respective functions and call those functions in the UI building logic.

```dart
Widget _buildBody() {
  return Padding(
    padding: EdgeInsets.all(8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _buildCurrentTemperature(),
        _buildTargetTemperature(),
        _buildActionIndicator(),
        _buildControls(),
      ],
    ),
  );
}
Widget _buildControls() {
  return Padding(
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
      ],
    ),
  );
}
Widget _buildActionIndicator() {
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
              color: _status,
            ),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Text(
            "${_actionInProgress.toUpperCase()}",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white),
          ),
        )
      ],
    ),
  );
}
Widget _buildTargetTemperature() {
  return Padding(
    padding: EdgeInsets.only(top: 40),
    child: Text(
      "Target temperature\n$_targetTemperature °C",
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 30),
    ),
  );
}
Widget _buildCurrentTemperature() {
  return Text(
    "Current temperature\n$_currentTemperature °C",
    textAlign: TextAlign.center,
    style: TextStyle(fontSize: 30),
  );
}
```

> Also, move the UI code to it's respective package structure under _lib/ui/main_ as a separate file. This method of organizing code is beneficial on the long run in a larger project with loads of screens.

`_MainPageState`'s `build` method is now reduced to this small snippet:

```dart
@override
Widget build(BuildContext context) {
  return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: _buildBody());
}
```

Taking a closer look at what you have now, you can see that there is a fundamental problem in the logic of how the app is built. *A view is handling all of the app's state, it is the state holder and it manipulates it's own state.*

Next up is the  [InheritedWidget stage](04_InheritedWidget.md).