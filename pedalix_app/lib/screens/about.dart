import 'package:flutter/material.dart';
import 'package:pedalix_app/main.dart';

class about extends StatelessWidget {
  const about({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('About'),
          backgroundColor: primaryColor,
        ),
      ),
    );
  }
}
