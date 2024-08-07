import 'package:flutter/material.dart';

class PageTransition<T> extends MaterialPageRoute<T> {
  PageTransition({
    required super.builder,
    super.settings,
  });

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
    // You can customize the animation here
    // From bottom to top
    // const begin = Offset(0.0, 1.0);
    // From top to bottom
    // const begin = Offset(0.0, -1.0);
    // From bottom to left
    const begin = Offset(1.0, 0.0);
    // From left to right
    // const begin = Offset(-1.0, 0.0);
    const end = Offset.zero;
    const curve = Curves.easeInOut;
    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
    var offsetAnimation = animation.drive(tween);
    return SlideTransition(position: offsetAnimation, child: child);
  }
}
