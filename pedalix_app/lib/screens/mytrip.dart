import 'package:flutter/material.dart';
import 'package:pedalix_app/main.dart';

// ignore: camel_case_types
class mytrip extends StatelessWidget {
  const mytrip({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('My Trip'),
          backgroundColor: primaryColor,
        ),
      ),
    );
  }
}
