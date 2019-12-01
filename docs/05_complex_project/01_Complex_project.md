# Using the Bloc library

You can check out how a lifelike app is built using [Bloc](https://pub.dev/packages/bloc) and it's Flutter extension, [flutter_bloc]( https://pub.dev/packages/flutter_bloc ) in the Stack Overflow Flutter Questions project.

> The flutter_bloc library provides widgets that make *dependency injection* and BLoC handling easier while using Flutter.

# A complex app - Stack Overflow Flutter Questions

First of all, you can find the project [here](01_Complex_project.md).

The app implements the following features:

* It uses the bloc and flutter_bloc libraries for BLoC implementation
* It fetches data from [Stack Overflow's piblic API](https://api.stackexchange.com/docs) using the [http](https://pub.dev/packages/http) package
  * The data consists of the 20 newest Flutter-related questions on SO and the replies to those mesages.
* It stores the fetched data in a SQLite database managed by the [Moor](https://pub.dev/packages/moor) library.
  * If there is no Internet connection, the app loads questions and answers from it's database.
* Full state handling
  * The app is prepared for empty or error results from the data fetching.
* Layered architecture with the following components:
  * Database handler
  * DiskDataSource
  * Network API
  * NetworkDataSource
  * Interactor
  * BLoC
  * UI

[Go back to the main page.](..\..\README.md) 