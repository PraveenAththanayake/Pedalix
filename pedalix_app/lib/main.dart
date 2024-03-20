import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pedalix_app/firebase_options.dart';
import 'package:pedalix_app/screens/login_page.dart';
import 'package:pedalix_app/screens/onboarding.dart';
import 'core/app_export.dart';

var globalMessengerKey = GlobalKey<ScaffoldMessengerState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  /// Please update theme as per your need if required.
  ThemeHelper().changeTheme('primary');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          theme: theme, // Assuming 'theme' is defined in 'app_export.dart'
          title: 'pedalix_app',
          debugShowCheckedModeBanner: false,

          routes: {
            '/': (context) =>
                onboarding(), // Updated to use 'Onboarding' instead of 'onboarding'
            '/onboarding': (context) => onboarding(),
            '/login': (context) => LoginPage(),
            // Assuming 'AppRoutes.routes' is defined in 'app_export.dart'
          },
        );
      },
    );
  }
}
