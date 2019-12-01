# Types

Dart is a *statically typed* language. It uses static type checking at compile time, and runtime checks to ensure type safety.

```dart
int x = 12; // from now on, x is an integer
x = 6; // This compiles
x = 1.0; // But this doesn't, because 1.0 is a double value
```

## Built-in types

Every type in Dart inherits from `Object`, just like in Java.

Dart supports the following types:

* Numbers
  * `int`
    * Depending on the platform Dart is running on, an `int` can be no larger than 64 bits.
  * `double`
    * There is no `float` here, only `double`. 64 bit floating point fractional values.
* `String`
  * An UTF-16 String implementation with rune support.
* `List`
  * Arrays with benefits. The *dart:core* library provides implementations.
  * Can be fixed-length or growable. 
* `Map`
  * A set of key-value pairs. The *dart:core* library provides implementations.
* `dynamic`
  * A keyword and an actual type. Using it as a type can break type-safety. On the other hand, using it as a type in generics behaves like if it was declared as `Object`.

## Type inference

Dart supports type inference for fields, methods, local variables, and most generic type arguments.

```dart
var x = 12; // x is an integer
final lang = "Dart"; // lang is a String constant
```

The following syntax declares the same function twice:

```dart
int one() { // one()'s return type is explicitly integer
  return 1;
}

two() { // two()'s return type is inferred (integer)
  return 2;
}
```

Type inference also works with generics:

```dart
Map<String, dynamic> traveler = {"name": "Doctor", "age": 4250};
Map wife = {"name": "River", "age": 548};
```

> The `dynamic` keyword means "object of any type". It is possible to declare the "type" of a variable as `dynamic` and simulate dynamic typing, but that leaves you without type-safety to lean on.
>
> ```dart
> dynamic x = [1, 2]; // x stores a list of integers
> x = 1; // Now x stores an integer
> x.length; // Compiles, but results in a runtime error
> ```

 [You now have the idea of how Dart's type system works. Head over to variables and constants to continue the journey.](02_Variables_and_constants.md) 

 [If you had enough of the basics, this is the way to the door labeled Flutter.](../02_Flutter/01_Flutter_core_concepts.md) 