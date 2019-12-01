# Basic building blocks

## StatelessWidget

Stateless widgets - as the name suggests - doesn't manage their own state. In other words, they have an immutable state. On top of that, a `StatelessWidget` instance can only be drawn once in an app's lifetime. This means if you have to update a UI represented by a `StatelessWidget`, you have to create a new instance of it.

Read more about the `StatelessWidget` class in the [official documentation](https://api.flutter.dev/flutter/widgets/StatelessWidget-class.html).

## StatefulWidget

Stateful widgets have an immutable state and they can be redrawn multiple times. They can even change their own state and trigger a redraw on themselves.

Read more about the `StatefulWidget` class in the [official documentattion](https://api.flutter.dev/flutter/widgets/StatefulWidget-class.html).

## InheritedWidget

The `InheritedWidget`class' main purpose is to efficiently propagate information down the widget tree. They are invisible to the user as the have no UI. 

Read more about the ` InheritedWidget` class in the [official documentation](https://api.flutter.dev/flutter/widgets/InheritedWidget-class.html).

## BuildContext

A `BuildContext` instance holds the location of a widget in the widget tree.

Read more about the ` BuildContext` class in the [official documentation](https://api.flutter.dev/flutter/widgets/BuildContext-class.html).

You're all set to bravely delve into some [demo projects]() showcasing common mobile app development tasks solved in Flutter.

If you're brave enough you can skip the demo projects and get the [state handling](..\04_state_management\01_app_architecture_and_state_mananagement) show on  [01_Common_task_demos.md](..\03_common_task_demos\01_Common_task_demos.md) the road, or take the shortest path to the complex 