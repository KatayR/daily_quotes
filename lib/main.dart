import 'package:daily_quotes/pages/about_page.dart';
import 'package:daily_quotes/pages/main_page.dart';
import 'package:daily_quotes/pages/quote_page.dart';
import 'package:daily_quotes/pages/settings_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(primarySwatch: Colors.blue),
        debugShowCheckedModeBanner: false,
        home: const MainPage(),
        routes: {
          '/quote': (context) => const QuotePage(),
          '/about': (context) => const AboutPage(),
          '/settings': (context) => const SettingsPage(),
        });
  }
}
