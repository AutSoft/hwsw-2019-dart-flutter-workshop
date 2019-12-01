### BLoC

There are a few architectural patterns that are actively used in Android and iOS development nowadays. MVC, MVVM, MVI, just to name some of them. The Flutter community came up with a reactive pattern that uses Dart's built-in streams to manage events and states.

Enter BLoC.

BLoC stands for **B**usiness **Lo**gic **C**omponents and the idea behind it is quite simple. A widget should emit events towards a BLoC, which will mutate the state of the app or other widgets it's responsible for. In other words, widgets emit events that - through BLoCs - cause other widgets to change.

![BLoC](..\assets\BLoC.png)

This pattern, besides the impact on maintainability, is easy to implement manually, as doing so doesn't require any 3rd party libraries at all. Everything needed is given by Dart in the form of *streams*.

In this section you'll see how you can use the BLoC pattern in Thermostat.

As a first step, modify `StateHolderInheritedWidget` to not provide a `ThermostatState`, but a `MainBloc` that you'll be implementing soon. 

```dart
class StateHolderInheritedWidget extends InheritedWidget {
  final MainBloc bloc;

  StateHolderInheritedWidget({
    Key key,
    this.bloc,
    @required Widget child
  }): super(key: key, child: child);

  static StateHolderInheritedWidget of(BuildContext context){
    return context.inheritFromWidgetOfExactType(StateHolderInheritedWidget);
  }

  @override
  bool updateShouldNotify(StateHolderInheritedWidget oldWidget) {
    return bloc != oldWidget.bloc;
  }
}
```

There still has to be a `StatefulWidget` that holds a reference to a BLoC and builds `StateHolderInheritedWidget` with the corresponding widget sub-tree. The difference is that further down the tree widgets will get a reference to a BLoC's *state stream* instead of the state directly. Also, they won't be issuing callbacks as actions. They will send *events* into the BLoC.

Modify `_ThermostatAppState ` so it holds a reference to a `MainBloc` instead of a `ThermostatState`.

```dart
class _ThermostatAppState extends State<ThermostatApp> {

  final MainBloc mainBloc = MainBloc();
    
  // ...
}
```

Adapt `_ThermostatAppState`'s `build` method to the previous change.

```dart
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
          setWarmer: _setWarmer,
          setColder: _setColder,
        ),
      ),
    );
  }
```

For tidying up the file hierarchy, move *thermostat_state.dart* into the *ui/main* package.

Continue by analyzing the current situation in terms of BLoC.

There are two event handling functions in `_ThermostatAppState` - `_setWarmer` and `_setColder`. You will map these to event classes respectively and implement their logic in the BLoC.

You shouldn't stop just here, as there is a `Timer` based UI modifying logic to take care of. Fortunately this is quite easy, only the starting of the `Timer` depends on UI events and then the UI is periodically updated by the logic attached to the `Timer`. This basically means that the `Timer` logic can go right into the BLoC as well, and it will update the state of the UI periodically from there.

Create a Dart file for our UI events called *main_page_events.dart* in the *ui/main* package with a base event and the two concrete events discussed just before this.

```dart
abstract class MainPageEvent {}

class ColderEvent extends MainPageEvent {}

class WarmerEvent extends MainPageEvent {}
```

Instances of `ColderEvent` and `WarmerEvent` will be the events that the UI will send into the BLoC.

Create a Dart file called `main_bloc.dart` in the *ui/main* package and start implementing the BLoC for `MainPage`. This is the point where streams come into play. Create one event stream and three state streams - one for each property defined in `ThermostatState`. You'll decouple said properties from each other, as they feed three different widgets.

```dart
class MainBloc {
  var _currentTemperature = 22;
  var _targetTemperature = 22;
  var _actionInProgress = ActionInProgress.IDLE;

  // Event controller
  StreamController<MainPageEvent> _eventController;
    
  // State controllers
  StreamController<int> _currentTempController;
    
  StreamController<int> _targetTempController;
    
  StreamController<ActionInProgress> _actionInProgressController;
}
```

First of all, move the `ActionInProgress ` enum from *thermostat_state.dart* to *main_bloc.dart* and delete *thermostat_state.dart* as there's no need for them anymore. 

> A quick recap: a BLoC should be able to receive events, modify the state according to what kind of event it received and send the modified state to the UI.

You defined four `StreamController`s, one for events and three to update the state of the UI.  Get a reference for `_eventController`'s `StreamSink` and expose it to the clients of `MainBloc`:

```dart
class MainBloc {
  var _state = ThermostatState();

  // Event controller
  StreamController<MainPageEvent> _eventController;

  Sink<MainPageEvent> get eventSink => _eventController.sink;
    
  StreamSubscription<MainPageEvent> _eventSubscription;
  
  // ...
}
```

The `eventSink` property will be the event input of `MainBloc`. Note that `MainBloc` will store a reference to the `StreamSubscription` object of the event stream, which it will acquire when it subscribing to the stream.

> Stream subscriptions are not cancelled automatically when we close their corresponding streams. The developers have to cancel them manually as soon as they know they won't be needing them anymore. Not doing so can lead to memory leaks.

 Also, implement the internals and the state outputs.

```dart
class MainBloc {

  // ...

  // Current temperature controller
  StreamController<int> _currentTempController;

  Sink<int> get _currentTemperatureSink => _currentTempController.sink;

  Stream<int> get currentTemperature => _currentTempController.stream;

  // Target temperature controller
  StreamController<int> _targetTempController;

  Sink<int> get _targetTemperatureSink => _targetTempController.sink;

  Stream<int> get targetTemperature => _targetTempController.stream;

  // Action in progress controller
  StreamController<ActionInProgress> _actionController;

  Sink<ActionInProgress> get _actionInProgressSink => _actionController.sink;

  Stream<ActionInProgress> get actionInProgress => _actionController.stream;
}
```

You'll use the `_currentTemperatureSink`, `_targetTemperatureSink` and `_actionInProgress` sinks internally for posting new states to the corresponding streams. Expose the streams' output as `currentTemperature`, `targetTemperature`, and `actionInProgress` which the UI can use to *react* to updated states.

Glue the input and output streams together to form the logic of `MainBloc`. Initialize all `StreamController`s in the constructor of  `MainBloc`. Furthermore, start listening for incoming events.

```dart
MainBloc() {
  _eventController = StreamController<MainPageEvent>();
  _currentTempController = StreamController<int>();
  _targetTempController = StreamController<int>();
  _actionController = StreamController<ActionInProgress>();
    
  _eventSubscription = _eventController.stream.listen(_mapEventToState);
}
```

Adhering to the pattern, provide a *reducer* function - `_mapEventToState` -  to implement the actual event-to-state mapping.

```dart
void _mapEventToState(MainPageEvent event) {
  switch (event.runtimeType) {
    case ColderEvent:
      if (_targetTemperature > MIN_TEMP) {
        _targetTemperature -= 1;
        _targetTemperatureSink.add(_targetTemperature);
        _startWorldTimer();
      }
      break;
    case WarmerEvent:
      if (_targetTemperature < MAX_TEMP) {
        _targetTemperature += 1;
        _targetTemperatureSink.add(_targetTemperature);
        _startWorldTimer();
      }
      break;
  }
}
```

Notice that you branch the state modifying behavior in the `switch` statement based on the received event's runtime type. The cooling and heating logic is essentially the same as what you have in `_ThermostatAppState`'s `_setColder` and  `_setWarmer` callback methods, but you simplified it by getting `ThermostatState` out of the picture.

Lift the `MIN_TEMP` and `MAX_TEMP` constants over from *main.dart* to *main_bloc.dart* to correct the remaining errors in `MainBloc`.

It's time to migrate the `Timer` logic from `_ThermostatAppState`  to `MainBloc`. First, create the `Timer` property in `MainBloc`.

```dart
class MainBloc {
  var _state = ThermostatState();

  Timer _worldTimer;
    
  // ...
}
```

Then lift the simulation handling methods over with some adaptation to the new state handling.

```dart
class MainBloc {
    
  // ...

  void _handleWorldTimerEvent(Timer timer) {
    if (_currentTemperature > _targetTemperature) {
      _currentTemperature -= 1;
      _actionInProgress = ActionInProgress.COOLING;
      _currentTemperatureSink.add(_currentTemperature);
      _actionInProgressSink.add(_actionInProgress);
    } else if (_currentTemperature < _targetTemperature) {
      _currentTemperature += 1;
      _actionInProgress = ActionInProgress.WARMING;
      _currentTemperatureSink.add(_currentTemperature);
      _actionInProgressSink.add(_actionInProgress);
    } else {
      timer.cancel();
      _worldTimer = null;
      _actionInProgress = ActionInProgress.IDLE;
      _actionInProgressSink.add(_actionInProgress);
    }
  }
}
```

You're almost done with `MainBloc`. There's one last thing to do with it, and that's preventing memory leaks. For this, you can write a conveniently named `dispose` method, which will cancel the `Timer` and close both the event and the state streams.

```dart
class MainBloc {
    
  // ...
  void dispose() {
    _cancelWorldTimer();
    _eventController.close();
    _eventSubscription.cancel();
    _currentTempController.close();
    _targetTempController.close();
    _actionController.close();
  }
}
```

It's time to clean up `_ThermostatAppState`. You can remove everything that's `Timer` related along with the two callback methods, `_setColder` and `setWarmer`. You shouldn't forget to call `mainBloc.dispose()` in `_ThermostatAppState`'s `dispose` method.

`_ThermostatAppState` now looks like this after the maintenance:

```dart
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
```

Notice that you no longer pass any callbacks to `MainPage` as it's now `MainBloc`'s responsibility to handle UI events.

Your final task is to adapt `MainPage`, `CurrentTemperature`, `TargetTemperature`, `ActionIndicator`, and `MainControls` to their new environment.

`MainPage` should look like this after the modifications:

```dart
class MainPage extends StatelessWidget {
  final String title;

  MainPage({Key key, this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: _buildBody());
  }

  Widget _buildBody() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CurrentTemperature(),
          TargetTemperature(),
          ActionIndicator(),
          MainControls(),
        ],
      ),
    );
  }
}
```

You just removed the callback properties altogether, as you won't be needing them anymore.

Next up is the `CurrentTemperature` widget's `build` method. Instead of the state itself, you can get a reference to `MainBloc` from `StateHolderInheritedWidget`. Now the UI has to work with a stream of values, so you'll wrap the existing `Text` widget into a `StreamBuilder`.

```dart
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
```

> [`StreamBuilder`](https://api.flutter.dev/flutter/widgets/StreamBuilder-class.html) is a widget that can handle incoming values from a given stream and rebuild a widget sub-tree accordingly.

Do the same thing with the `TargetTemperature` widget.

```dart
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
```

Don't forget about `ActionIndicator`, where there is some extra work to do:

```dart
@override
Widget build(BuildContext context) {
  final bloc = StateHolderInheritedWidget.of(context).bloc;
    
  return StreamBuilder(
      initialData: ThermostatState(),
      stream: bloc.state,
      builder:
          (BuildContext context, AsyncSnapshot<ThermostatState> snapshot) {
        Color color;
        String text;
        switch (snapshot.data.actionInProgress) {
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
```

> Besides getting a reference to `MainBloc`, you moved the `switch` statement that produces the actual state of the sub-widgets to the body of the `StreamBuilder`'s builder function.

There's only one thing left to do. Modify`MainControls` so that it doesn't use callbacks anymore, instead it will send `MainPageEvent`s to `MainBloc`. In order to not make this example more complex, you'll send the events by using anonymous functions that take the place of the previous callback functions.

```dart
class MainControls extends StatelessWidget {
  
  MainControls({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = StateHolderInheritedWidget.of(context).bloc;
    
    return Padding(
      padding: EdgeInsets.only(top: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FloatingActionButton(
            onPressed: () => bloc.eventSink.add(ColderEvent()),
            tooltip: 'Colder',
            child: Icon(Icons.remove),
          ),
          SizedBox(
            width: 40,
          ),
          FloatingActionButton(
            onPressed: () => bloc.eventSink.add(WarmerEvent()),
            tooltip: 'Warmer',
            child: Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
```

That was a handful of work, but you've done it! Thermostat is now a fully fledged reactive Flutter app.

But isn't that a bit too much of work to do? you may ask. You have to maintain at least a `StatefulWidget`, an `InheritedWidget`, a BLoC with multiple streams, and the binding of all of these.

What if I told you that there's a library for all of this? 

It's called [Bloc](https://pub.dev/packages/bloc).

There is not much left. You can check out the [complex project](..\05_complex_project\01_Complex_project.md) to get an overall idea on how complex can .

[Also, here's a link to the main page just for you.](..\..\README.md) 

