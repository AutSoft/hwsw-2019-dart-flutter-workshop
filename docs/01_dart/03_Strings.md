# String literals, String interpolation

There are a few ways to declare `String` literals.

Surround text with quotation marks and you'll get an *escaped String*. You'll get the same result with apostrophes.

```dart
final recipe = "cake";
final cookie = 'chocolate chip';
```

The main difference between the two representations is that you can have the other symbol in the literal without having to escape it.

Raw `String` literals start with `r`:

```dart
final raw = r"\/\/00t"; // raw literally has the value \/\/00t
```

You can write multi-line `String` literals by using triple quotation marks or apostrophes.

```dart
final multiline = """Mind
==========================
the gap""";
```

Dart supports `String` interpolation by using the dollar mark (`$`) for variables and dollar mark with curly braces (`${...}`) for expressions.

```dart
final encounter = "A wild $name appeared";
final confirmation = "You bought ${transaction.potionCount} potions.";
```

You can combine rows of `String`s defined by any method above into a single `String`.

```dart
final wibblyWobbly = '"People assume that time\'s a strict'
    "progression from cause to effect,\n"
    "but acutally - from a non-linear, non-subjective viewpoint\n"
    '''it's more like a big ball of
wibbly wobbly, timey wimey stuff."''';
```

Note that using this syntax will not implicitly result in a multi-line `String`. You still have to insert a newline character if you're not using the multi-line `String` syntax.

 [String handling is easy and fun in Dart. Control flow statements are even easier to learn.](04_Control_flow.md) 

 [Or, you know, you can just skip to Flutter.](../02_Flutter/01_Flutter_core_concepts.md) 