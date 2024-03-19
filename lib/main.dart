import 'package:flutter/material.dart';
import 'package:pedalix_app/screens/onboarding.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // Define routes for navigation
      routes: {
        '/': (context) => onboarding(),
        '/onboarding': (context) => onboarding(),
      },
    );
  }
}
