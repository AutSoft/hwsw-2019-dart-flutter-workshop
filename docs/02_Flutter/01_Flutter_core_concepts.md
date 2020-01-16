# The core concepts of Flutter

This short section will introduce the core concepts of Flutter before the real action begins. 

You can skip the basics and explore the demo projects // TODO link, go through the widget state handling section, or have a look at a complex Flutter app project.

## Everything is a Widget

In Flutter, everything revolves around widgets. Your app is a widget, that holds and manages other widgets, which do the same with their widgets, etc. Widgets can be used to hold values for other widgets, which in turn can display data on the UI. There are also invisible UI widgets, such as containers.

In an app, widgets form a *widget tree*. The widget tree is a hierarchy of widgets which defines the state and the displayed UI of the app.

![widget-tree](../assets/widget-tree.png)

## The world is a big Canvas

Flutter doesn't rely on the underlying platform's UI framework. Instead, it uses it's own UI framework built on the Skia open source 2D rendering engine. Because of this, all of the UI is rendered on a native Skia canvas.

#### States matter!

A widget's state is the data it holds and what it displays.

As a result of the widget-based framework, managing the state of the widgets is one of the main concerns developers have to face while working with Flutter. You can see for yourself if you check out the [widget state handling section](..\04_state_management).

[You're almost done! One more of this and you'll be totally ready to take on the remaining parts](02_Basic_building_blocks.md)
