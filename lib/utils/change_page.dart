import 'package:flutter/material.dart';

class ChangePage {
  static Future<dynamic> fadeChangePage(
    BuildContext context,
    Widget widget,
  ) async {
    return await Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => widget,
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            FadeTransition(
          opacity: animation.drive(
            Tween(begin: 0.0, end: 1.0).chain(
              CurveTween(curve: Curves.ease),
            ),
          ),
          child: child,
        ),
      ),
    );
  }

  static Future<dynamic> slideChangePage(
    BuildContext context,
    Widget widget,
  ) async {
    return await Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => widget,
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            SlideTransition(
          position: animation.drive(
            Tween(begin: Offset(0, 1), end: Offset(0, 0)).chain(
              CurveTween(curve: Curves.ease),
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}
