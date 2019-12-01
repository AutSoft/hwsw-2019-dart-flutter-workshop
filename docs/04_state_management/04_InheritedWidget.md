# InheritedWidget

There are still a few tricks left that you can use to improve the architecture of the app. Currently you pass down the state from the top widget - `ThermostatApp` - to `MainPage` -, which then passes down the state to all of its children. The main problems with this approach are that every widget in our app has to receive the state in their constructor or builder method, and every widget has to wait for the next global rebuild event instead of just refreshing their content when the data from the state changes. You can tackle these problems by adding an `InheritedWidget` to our widget tree.

> `InheritedWidget` is a widget that you can put in the widget tree as a parent of a sub-tree. The exciting thing is that the widgets in that sub-tree can interact with the data and functions the `InheritedWidget` exposes.

Start implementing this `InheritedWidget`, which is called `StateHolderInheritedWidget`.

```dart
class StateHolderInheritedWidget extends InheritedWidget {
  final ThermostatState state;

  StateHolderInheritedWidget({
    Key key,
    this.state,
    @required Widget child
  }): super(key: key, child: child);
    
  static StateHolderInheritedWidget of(BuildContext context){
    return context.inheritFromWidgetOfExactType(StateHolderInheritedWidget);
  }  

  @override
  bool updateShouldNotify(StateHolderInheritedWidget oldWidget) {
    return state.currentTemperature != oldWidget.state.currentTemperature &&
        state.targetTemperature != oldWidget.state.targetTemperature &&
        state.actionInProgress != oldWidget.state.actionInProgress;
  }
}
```

The goal here is to share some data (the state) with other widgets. In order to do this, you'll need to insert `StateHolderInheritedWidget` into the widget tree in a way that it becomes the root element of the sub-tree containing said widgets.

Notice that you passed exactly one required child widget to the constructor along with the state object.

The child widgets in the underlying sub-tree can register - or subscribe, if you will - to the changes of the state maintained in `InheritedWidget`. You'll do this by using the static `of(BuildContext context)` function. This function searches the widget tree upwards until it finds the first widget of class  `StateHolderInheritedWidget` and returns it.

When extending the `InheritedWidget` class the only method we need to override is `updateShouldNotify`. Using this method we get to say when we want the attached sub-tree to be updated with the new state when it has changed.

Everything's all set for inserting `StateHolderInheritedWidget` into the widget tree.

Modify the `build()` method of `_ThermostatAppState` to look like this:

```dart
@override
Widget build(BuildContext context) {
  return MaterialApp(
    title: 'Thermostat',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: StateHolderInheritedWidget(
      state: state,
      child: MainPage(
        title: 'Thermostat',
        setWarmer: _setWarmer,
        setColder: _setColder,
      ),
    ),
  );
}
```

Notice that state is no longer passed to `MainPage`, instead it's passed to `StateHolderInheritedWidget`. In order for this to work as intended, you have to make some slight adjustments to `MainPage`.

Remove the `state` property along with the corresponding constructor parameter.

```dart
class MainPage extends StatelessWidget {
  final String title;

  final Function setWarmer;

  final Function setColder;

  MainPage({Key key, this.title, this.setWarmer, this.setColder})
      : super(key: key);
    
  // ...
}
```

Before you get to work some magic with our `InheritedWidget`, you need to do some housekeeping around the widgets of `MainPage`. Lift the widget building functions out of `MainPage` to their respective files as classes that extend `StatelessWidget`. The widget building code pieces go into the newly created widget  classes' `build` methods, where you can access the widget's `context`.  You can find these classes [here](./projects/state_handling_demos/05_thermostat_with_inheritedwidget).

After extracting the widget builder parts of our code, `MainPage`'s `_buildBody` method became much less cluttered. As a bonus, `MainPage` doesn't know anything about the app state, which is all right, because it really doesn't need anything from it.

> To be a bit more organized, also move the `MAX_TEMP`, `MIN_TEMP`, and `IDLE_STATUS_COLOR` constants from *main_page.dart* to *main.dart*.

Now, look at the trick what you were making these recent changes for. By using `StateHolderInheritedWidget of(BuildContext context)`, you can traverse the widget tree upwards to find the first widget of type `StateHolderInheritedWidget`. This is just the thing you're doing in the widgets of `MainPage`, for example in `CurrentTemperature`'s `build` method:

```dart
@override
  Widget build(BuildContext context) {
    final state = StateHolderInheritedWidget.of(context).state;

    return Text(
      "Current temperature\n${state.currentTemperature} °C",
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 30),
    );
  }
```

Thermostat is starting to look like a maintainable application with actual separation of concerns.

There are some issues with this approach though. With the UI getting more complex, essentially you have to design `InheritedWidget`s' places in the widget tree. This is fine, but you have to deal with it. On the other hand, actions from the UI - like button clicks - are handled by callbacks that you pass down from the main app state. This is far from ideal as this approach doesn't scale well.

[Solving these issues require involving something called the BLoC pattern.](05_Manual_bloc.md) 

