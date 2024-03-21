import 'package:flutter/material.dart';
import 'package:pedalix_app/main.dart';

class help extends StatelessWidget {
  const help({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Help'),
          backgroundColor: primaryColor,
        ),
      ),
    );
  }
}
