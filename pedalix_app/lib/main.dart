import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pedalix_app/components/navbar.dart';
import 'package:pedalix_app/firebase_options.dart';
import 'package:pedalix_app/screens/onboarding.dart';
import 'package:pedalix_app/screens/payments.dart';
import 'package:pedalix_app/screens/sign_up.dart';
import 'core/app_export.dart';
import 'package:pedalix_app/screens/qr_scan.dart';
import 'package:pedalix_app/screens/thankyou.dart';
import 'package:pedalix_app/screens/profile.dart';
import 'package:pedalix_app/screens/map_page.dart';

var globalMessengerKey = GlobalKey<ScaffoldMessengerState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  ThemeHelper().changeTheme('primary');

  runApp(MyApp());
}

final Color primaryColor = Color(0xFF127368);
Color customColor = Color(0x18115104).withOpacity(0.2);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          theme: theme.copyWith(dividerColor: Colors.transparent),
          title: 'pedalix_app',
          debugShowCheckedModeBanner: false,
          home: onboarding(),
          routes: {
            '/onboarding': (context) => const onboarding(),
          },
        );
      },
    );
  }
}
