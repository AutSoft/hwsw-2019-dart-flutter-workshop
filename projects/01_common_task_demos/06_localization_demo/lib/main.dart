import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n_delegate.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'widgets/login_screen.dart';

void main() => runApp(LocalizationDemoApp());

class LocalizationDemoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HWSW19 Localization Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(title: 'UI Demo'),
      localizationsDelegates: [
        // A class which loads the translations from JSON files
        FlutterI18nDelegate(fallbackFile: "en.json", path : "assets/lang"),
        // Built-in localization of basic text for Material widgets
        GlobalMaterialLocalizations.delegate,
        // Built-in localization for text direction LTR/RTL
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('hu'),
        const Locale('en'),
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale.languageCode &&
              supportedLocale.countryCode == locale.countryCode) {
            return supportedLocale;
          }
        }
        // If the locale of the device is not supported, use the first one
        // from the list (English, in this case).
        return supportedLocales.first;
      },
    );
  }
}

class HomePage extends StatelessWidget {
  final colors = [Colors.red, Colors.blue, Colors.green, Colors.amber];

  final String title;

  HomePage({Key key, @required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: LoginScreen(),
      ),
    );
  }
}
