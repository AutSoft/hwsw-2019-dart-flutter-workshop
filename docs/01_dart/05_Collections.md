# Collections

Besides having `List`, `Map`, and `Set` collection types, Dart has literal syntax for creating each of the collection types.

You can create a  `List` literal by listing elements in square brackets:

```dart
final numbers = [1, 2, 3, 4, 5]; // this will create a fixes-length List
```

You can create a `Map` literal by listing key-value pairs in curly braces:

```dart
final dogsWithAge = {
  "Fido" : 10,
  "Lucky" : 5, 
}
```

`Set` literals also use the curly brace syntax:

```dart
final names = {"Jack", "Joe", "Jack"}; // names will contain "Jack" and "Joe"
```

There are a number of out-of-the-box functions that you can use on collections to make working with them a walk in the park.

> If you find yourself in need of more collection processing functions, there is a port of the Kotlin standard library, which adds even more useful ones to your tool set. The library's called *kt.dart* and you can find it on [pub.dev](https://pub.dev/packages/kt_dart).

 [A bit more interesting topic is around the corner: Functions!](06_Functions.md) 

 [Feeling like a pro already? Flutter is this way.](..\02_Flutter\01_Flutter_core_concepts.md) 