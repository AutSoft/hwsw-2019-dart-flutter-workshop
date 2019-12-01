# Lifting State Up

It's time to refactor the screen to have more restraints on how its state is handled. First of all, wrap the state variables into an immutable [PODO](http://maxhorstmann.net/blog/2013/09/22/plain-old-dart-objects/):

```dart
@immutable
class ThermostatState {
  final int currentTemperature;
  final int targetTemperature;
  final ActionInProgress actionInProgress;

  ThermostatState(
      {this.currentTemperature = 22,
      this.targetTemperature = 22,
      this.actionInProgress = ActionInProgress.IDLE});
}
```

Notice that your replaced the `status` and `actionInProgress` properties with one single `actionInProgress` property of the newly created `ActionInProgress` enum type. This way the model only holds information on what state the heating system is in and you can handle the actual representation of this state in the `MainPage` widget.

> A copy method on the `ThermostatModel `class would be nice to have when you have to update state with an immutable class. As of version 2.6.1 - unlike Kotlin and much like Swift - Dart only allows constant values as default values for method parameters. This leaves only one option: you need to call the fully parameterized constructor even when you want to copy only a part of the state.

Right now, `MainPage` is a `StatefulWidget` that is responsible for taking care of its state and state changes. The goal is to make `MainPage` behave like a simple view, so it should only *receive* the state it has to render. This is the point where *lifting state up* comes into play.

Lifting the state up will take multiple-steps, but it's worth the trouble.

Notice that there's another widget in the project called `ThermostatApp` which represents the application itself. Right now its only responsibility is to set the title and theme of the application and display the `MainPage` widget as the home screen. Make it a `StatefulWidget` and lift the state and the state handling logic up from `MainPage`.

```dart
class ThermostatApp extends StatefulWidget {
  @override
  _ThermostatAppState createState() => _ThermostatAppState();
}
```

You have to create the class representing the state of the `ThermostatApp` widget. 

```dart
class _ThermostatAppState extends State<ThermostatApp> {
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
```

At first, this code will do the exact same thing as before, you just modified `ThermostatApp` to be a working `StatefulWidget`.

Next up, you'll change `MainPage` to be a `StatelessWidget`, which only receives the state it has to render in its constructor, along with some callback functions which were its state's own methods before.

```dart
class MainPage extends StatelessWidget {
  final String title;

  final ThermostatState appState;

  final Function setWarmer;

  final Function setColder;

  MainPage({Key key, this.title, this.appState, this.setWarmer, this.setColder})
      : super(key: key);
    
  // ...
}
```

> As you've seen before, functions are first class citizens in Dart, much like in Kotlin or Swift. The main difference lies within the handling of nullability in Dart. Because any parameter of a function can be null - so as the returned value -,  functions can be represented by *Function* without explicitly declaring the type of the function we're expecting. This seems convenient, but without enough care it can lead to compile time errors.

Move the widget building functions from `_MainPageState` to `MainPage`, including the overridden `build` function:

```dart
class MainPage extends StatelessWidget {
  
  // ...
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: _buildBody());
  }

  Widget _buildBody() { /* ... */ }

  Widget _buildControls() { /* ... */ }

  Widget _buildActionIndicator() { /* ... */ }

  Widget _buildTargetTemperature() { /* ... */ }

  Widget _buildCurrentTemperature(ThermostatState appState) { /* ... */ }
```

> Notice that the `AppBar` widget now takes the `title` property of `MainPage` as its title.

You'll do some further refactoring to pass down the state on the widget graph. Let's pass the state to all widget builders as a parameter which need it for displaying their content. These functions are `_buildBody`, `_buildActionIndicator`, `_buildTargetTemperature`, and `_buildCurrentTemperature`. Note that one of the widget builders - `_buildControls` - has no dependency on the state, but it operates with action callbacks which it receives as parameters. For example:

```dart
Widget _buildControls(Function setWarmer, Function setColder) {
  return Padding(
    padding: EdgeInsets.only(top: 40),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        FloatingActionButton(
          onPressed: setColder,
          tooltip: 'Colder',
          child: Icon(Icons.remove),
        ),
        SizedBox(
          width: 40,
        ),
        FloatingActionButton(
          onPressed: setWarmer,
          tooltip: 'Warmer',
          child: Icon(Icons.add),
        ),
      ],
    ),
  );
}

Widget _buildTargetTemperature(ThermostatState appState) {
  return Padding(
    padding: EdgeInsets.only(top: 40),
    child: Text(
      "Target temperature\n${appState.targetTemperature} °C",
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 30),
    ),
  );
}
```

> See the full source code of the modified `MainPage` widget [here](.\projects\state_handling_demos\04_thermostat_lifting_state_up\lib\ui\main\main_page.dart).
>
> While it was not really necessary to pass the state and the callback functions to the widget builder functions, this way they remain loosely coupled to their parent widget, so moving them around in the widget tree, or copying the builder logic somewhere else as a function becomes a breeze.

It's time to get rid of the `_MainPageState` class. Move all the remaining logic from `_MainPageState` to `_ThermostatAppState` so it looks like the following code:

```dart
class _ThermostatAppState extends State<ThermostatApp> {
  var state = ThermostatState();

  Timer _worldTimer;

  void _handleWorldTimerEvent(Timer timer) {
    setState(() {
      if (state.currentTemperature > state.targetTemperature) {
        state = ThermostatState(
            currentTemperature: state.currentTemperature - 1,
            targetTemperature: state.targetTemperature,
            actionInProgress: ActionInProgress.COOLING);
      } else if (state.currentTemperature < state.targetTemperature) {
        state = ThermostatState(
            currentTemperature: state.currentTemperature + 1,
            targetTemperature: state.targetTemperature,
            actionInProgress: ActionInProgress.WARMING);
      } else {
        timer.cancel();
        _worldTimer = null;
        state = ThermostatState(
            currentTemperature: state.currentTemperature,
            targetTemperature: state.targetTemperature,
            actionInProgress: ActionInProgress.IDLE);
      }
    });
  }

  void _setWarmer() {
    setState(() {
      if (state.targetTemperature < MAX_TEMP) {
        state = ThermostatState(
            currentTemperature: state.currentTemperature,
            targetTemperature: state.targetTemperature + 1,
            actionInProgress: state.actionInProgress);
        _startWorldTimer();
      }
    });
  }

  void _setColder() {
    setState(() {
      if (state.targetTemperature > MIN_TEMP) {
        state = ThermostatState(
            currentTemperature: state.currentTemperature,
            targetTemperature: state.targetTemperature - 1,
            actionInProgress: state.actionInProgress);
        _startWorldTimer();
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
    return MaterialApp(
      title: 'Thermostat',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainPage(
        title: 'Thermostat',
        appState: state,
        setWarmer: _setWarmer,
        setColder: _setColder,
      ),
    );
  }

  @override
  void dispose() {
    _cancelWorldTimer();
    super.dispose();
  }
}
```

Now you can safely delete `_MainPageState`.

All that you did was you moved state handling up one level on the widget tree. We started to move towards a form of separation of concerns. Now the app handles the state and the *screen* is only responsible for displaying it.

If there would be another screen which needed the same - or a bit extended - state we could easily implement said screen essentially the same way as we did with `MainPage`.

[There is a neat trick using `InheritedWidget` to solve this problem.](04_InheritedWidget.md) 

