import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'constants.dart';
import 'home_page.dart';
import 'main_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return CalendarControllerProvider(
      controller: EventController(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: AppTheme.lightTheme,
        home: const Scaffold(
          body: MyHomePage(title: 'calendar_view Example'),
        ),
        localizationsDelegates: globalMaterialLocalizations,
        supportedLocales: locales,
      ),
    );
  }
}