# Functions

## Function basics

Functions are first class citizens in Dart. This means that a function can be a parameter of another function and a function can return a function.

> A function that receives another functions as a parameters, or returns a function is called a *higher-order function*.

You can declare functions using C-like syntax like in many other programming languages.

```dart
String fullName(String first, String last){
  return "$first $last";
}
```

In the above example both `first` and `last` parameters can be null, but passing both of them is *required* on the function's call site in the declared order. These are called *positional* parameters.

The `fullName` function can be simplified by transforming it into a function with and *expression body*. The expression body syntax uses the *fat arrow* `=>` symbol in Dart.

```dart
String fullName(String first, String last) => "$first $last";
```

Dart has two modifiers that can be applied on a function's parameters, *named* and *optional*.

## Named parameters

By default, you can't refer to function parameters by their names, and because of that you can't mix up their positions either. What you can do, is mark some of the parameters as *named*. You can do this by surrounding parameters with curly braces `{...}`.

```dart
String fullName({String first, String last, String title}){
  return "$first $last $title";
}
```

In the example above, all parameters are *named*, so you can call `fullName` like this:

```dart
var name = fullName(title: "Mr.", last: "NiceGuy");
```

Notice that named parameters can be omitted from the parameter list. They will be `null` in the function body. 

You can mark named parameters as *required* by using the `@required` annotation on them.

```dart
String fullName({@required String first, @required String last, String title}){
  return "$first $last $title";
}
```

The *named* sub-list has to be at the end of the list and only one *named* sub-list is allowed.

```dart
String fullName(String first, {String last, String title}) {...} // This is OK. 
String fullName({String first, String last}, String title) {...} // This is not OK!
String fullName({String first}, String last, {String title}) {...} // This is not OK either!
```

*Named* parameters can have default values.

```dart
String fullName(String first, {String last = "Doe", String title = ""}) {...}
```

## Optional parameters

You can mark *positional* parameters as *optional* by surrounding them with square brackets `[...]`. 

```dart
String fullName(String first, String last, [String title]){
  return "$first $last $title";
}
```

*Optional* parameters' value is `null` if they're omitted. They are still *positional*.

The *optional* sub-list has to be at the end of the list and only one *optional* sub-list is allowed.

```dart
String fullName(String first, [String last, String title]) {...} // This is OK. 
String fullName([String first, String last], String title) {...} // This is not OK!
String fullName([String first], String last, [String title]) {...} // This is not OK either!
```

*Optional* parameters can have default values.

```dart
String fullName(String first, [String last = "Doe", String title = ""]) {...}
```

## Anonymous functions

You can declare anonymous functions by omitting the return type and name from the normal function syntax. Both block body and expression body declarations are allowed.

```dart
// Anonymous function with block body
LongRunningTask().start(callback: (statusCode) {
  print(statusCode);
});

// Anonymous function with expression body
LongRunningTask().start(callback: (statusCode) => print(statusCode));
```

 [This was intense. You're doing fine if you got here on the long way. Next up are classes and inheritance.](07_Classes_and_inheritance.md) 

