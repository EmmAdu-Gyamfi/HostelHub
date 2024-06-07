import 'package:flutter/material.dart';

class MyNavigator {
  static Future navigateTo(BuildContext context, Widget page, {bool replace = false}) {
    if(replace){
      return Navigator.of(context).pushReplacement(_createRoute(page));
    } else {
      return  Navigator.of(context).push(_createRoute(page));
    }
  }

  static Route _createRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(1.0, 0.0);
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}
