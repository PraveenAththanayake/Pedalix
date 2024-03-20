import 'package:flutter/material.dart';
import 'package:pedalix_app/screens/onboarding.dart';
import 'package:pedalix_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
