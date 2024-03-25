import 'package:flutter/material.dart';

PageRouteBuilder<dynamic> slideTransitionAnimation(
  Widget page,
) {
  return PageRouteBuilder<dynamic>(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(1.0, 0.0);
      var end = Offset.zero;
      var curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      // Add a duration to the animation
      var durationAnimation = animation.drive(
        Tween<double>(
          begin: 0,
          end: 1,
        ).chain(
          CurveTween(curve: curve),
        ),
      );

      return SlideTransition(
        position: durationAnimation.drive(tween),
        child: child,
      );
    },
    transitionDuration:
        Duration(milliseconds: 500), // Add your desired duration here
  );
}

PageRouteBuilder<dynamic> fadeTransitionAnimation(
  Widget page,
) {
  return PageRouteBuilder<dynamic>(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var curve = Curves.ease; // Add your desired curve here

      var tween =
          Tween<double>(begin: 0, end: 1).chain(CurveTween(curve: curve));

      // Add a duration to the animation
      var durationAnimation = animation.drive(tween);

      return FadeTransition(
        opacity: durationAnimation,
        child: child,
      );
    },
    transitionDuration:
        Duration(milliseconds: 500), // Add your desired duration here
  );
}
