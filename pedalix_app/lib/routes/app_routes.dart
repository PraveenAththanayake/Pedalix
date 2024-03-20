import 'package:flutter/material.dart';
import 'package:pedalix_app/screens/sign_up.dart';

class AppRoutes {
  static const String signUpScreen = '/sign_up_screen';

  static Map<String, WidgetBuilder> routes = {
    signUpScreen: (context) => SignUpScreen()
  };
}
