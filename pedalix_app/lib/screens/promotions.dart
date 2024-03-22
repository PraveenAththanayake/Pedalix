import 'package:flutter/material.dart';
import 'package:pedalix_app/main.dart';

class promotions extends StatelessWidget {
  const promotions({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Promotions'),
          backgroundColor: primaryColor,
        ),
      ),
    );
  }
}
