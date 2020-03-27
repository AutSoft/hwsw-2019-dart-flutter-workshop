# Classes and inheritance

The class declaration syntax is the same as in most languages that use the concept of classes. Also, variables are not *fields*, but *properties* with implicit getters and setters.

```dart
class Person {
  String firstName;
  String lastName;
  
  Person(firstName, lastName){
    this.firstName = firstName;
    this.lastName = lastName;
  }
}

class Student extends Person {
  int grade;

  Student(String firstName, String lastName, int grade):super(firstName, lastName){
    this.grade = grade;
  }
    
  String getFullName(){
    return "$firstName $lastName";
  }

  String toString() {
    return "$firstName $lastName's grade is $grade";
  }
}
```

## Classes as implicit interfaces

Dart doesn't have explicit interfaces, there is no `interface` keyword in the language. Instead, every class implicitly declares an interface that consist of the class' public properties and methods.

For example, check out the [`Comparable`](https://github.com/dart-lang/sdk/blob/master/sdk/lib/core/comparable.dart) class' implementation. Unlike in other languages, `Comparable` is an *abstract* class which other classes can either *extend* or *implement*.

For a quick look at how this works, check out the [official documentation](https://dart.dev/guides/language/language-tour#implicit-interfaces) on implicit interfaces.

## Constructors

You have a few options when the time comes for declaring constructors of a class. First of all, if you don't declare any constructors, a default no-argument constructor is implicitly created for the class. In this case, every non-final property is initialized to `null` and final properties have to be initialized inline with their declaration.

Of course, you can also declare a constructor with as many parameters as you like.

```dart
class Person {
  String firstName;
  String lastName;
  
  Person(firstName, lastName){
    this.firstName = firstName;
    this.lastName = lastName;
  }
}
```

> You can declare constructor parameters as *named* or *optional* the same way as any other function parameters.

The syntax above is pretty verbose. There is a syntactic sugar to make this easier.

```dart
class Person {
  final String firstName;
  final String lastName;
  
  Person(this.firstName, this.lastName){
    // You can do further initialization steps here, or just discard the block body and end the constructor with a semicolon after the parameter list.
  }
}
```

> Notice that both `firstName` and `lastName` properties are now final, but are not explicitly initialized. The thing is that final properties have to be initialized before running any constructor's body. This syntax works just like that.

A quite unusual feature is that you can create named constructors for your classes. The syntax for a named constructor is `ClassName.identifier(...){...}`.

```dart
class Person {
  final String firstName;
  final String lastName;
  
  Person(this.firstName, this.lastName);
    
  Person.comedian(): this("Jack", "Black");
}
```

You can call the superclass' constructor by using the `super` keyword.

```dart
class Student extends Person {
  int grade;

  Student(String firstName, String lastName, int grade):super(firstName, lastName){
    this.grade = grade;
  }
}
```

Also, there is a C-style initializer list syntax that you can use to initialize a class' own properties.

```dart
class Student {
  final String firstName;
  final String lastName;
  int grade;

  Student(String firstName, String lastName, int grade)
      : firstName = firstName,
        lastName = lastName,
        grade = grade;
}
```

## Getters and setters

Properties have implicit default getters (and setters, when appropriate) that you can use to read (or write) their value. You can create additional properties by declaring explicit getters and setters.

```dart
class Student {
  final String firstName;
  final String lastName;
  int grade;

  // Constructors ...

  String get usGrade {
    var value = "F";
    switch (grade) {
      case 1:
        value = "F";
        break;
      case 2:
        value = "E";
        break;
      // ...
    }
    return value;
  }
  
  void set usGrade(String value){
      switch (value) {
      case "F":
        grade = 1;
        break;
      case "E":
        grade = 2;
        break;
      // ...
    }
  }
}
```

 [One last thing left, but it is important nontheless. You'll get the general idea behind asynchronous programming.](08_Async_summary.md) 

 [There really isn't much to skip now before Flutter, but you can skip if you want to.](../02_Flutter/01_Flutter_core_concepts.md) 

 [Also, you can jump right into the common task demo projects.](../03_common_task_demos/01_Common_task_demos.md) 
