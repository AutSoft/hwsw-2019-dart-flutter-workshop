# Variables and constants

There are a few ways to declare and initialize variables in Dart. Keep in mind that *every* uninitialized variable's value implicitly defaults to `null`, primitive types included.

You can declare a variable with its type explicitly and without initializing it.

```dart
List<int> forTheAges; // The type is List<int>, the value is null
```

If you want to take advantage of type inference, you can declare a variable with the `var` keyword. Remember though how type inference and the `dynamic` type works.

```dart
var x = 1; // x is of the integer type and is initialized to 1
var d; // d is of the dynamic type and its value is null
int y; // y is of the integer type, but its value is null
```

You can declare immutable constant references - constants - with the `final` keyword. When you declare a constant this way, you have to make sure it gets initialized.

```dart
final double pi = 3.14; // pi is a double constant
final e = 2.71; // e is also a double constant, its type is inferred
final d; // Compilation error, not initialized 
```

You can use the `const` keyword to declare *deep constant* objects. This means that any object marked with `const` tells the compiler that the object's entire deep state can be determined at compile time. A String literal, like "I'm a constant!" is a valid const, but `Random().nextInt(100)` is not.

```dart
const List<String> strings = ["a", "b", "c"]; // valid
const List<int> ints = [1, 2, Random().nextInt(100)] // invalid
```

As you can see in the example above, an object marked with `const`  has to be transitively immutable.

> Deep const objects have to be created from data that can be created and calculated at compile time.

## Visibility

Dart doesn't have visibility modifier keywords. Everything is public by default, and you can make a variable, method or class *library* private. You can make them private by starting their name with an underscore (`_`).

```dart
final _secretKey = "123ABC"; // _secretKey is a library private constant
```

A Dart library is a set of .dart files bundled together. Every app is also a library.

 [There have already been some examples with Strings in this section. Find out what else you can do with them.](03_Strings.md) 

 [Or just go straight to Flutter.](../02_Flutter/01_Flutter_core_concepts.md) 
