import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Routes {
  static const String LOGIN_PAGE = 'login';
  static const String REGISTER_PAGE = 'register';
  static const String VERIFY_OTP_PAGE = 'verify_otp';
  static const String HOME_PAGE = 'home';

  static Route<T> fadeThrough<T>(RouteSettings settings, WidgetBuilder page,
      {int duration = 300}) {
    return PageRouteBuilder<T>(
      settings: settings,
      transitionDuration: Duration(milliseconds: duration),
      pageBuilder: (context, animation, secondaryAnimation) => page(context),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
      },
    );
  }
}