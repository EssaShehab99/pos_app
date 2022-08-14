import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Routes {
  static const String LOGIN_PAGE = 'login';
  static const String REGISTER_PAGE = 'register';
  static const String VERIFY_OTP_PAGE = 'verify-otp';
  static const String FORGOT_PASSWORD_PAGE = 'forgot-password';
  static const String HOME_PAGE = 'home';
  static const String SALES_INVOICE_PAGE = 'sales-invoice';
  static const String SALES_RETURNED_INVOICE='returned-invoice';
  static const String CUSTOMER_PAGE = 'customer';
  static const String PRODUCT_PAGE = 'product';
  static const String SHOW_SALES_INVOICE_PAGE = 'show-sales-invoice';

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