import 'package:fatora/features/auth/presentation/pages/landing/landing_page.dart';
import 'package:fatora/features/auth/presentation/pages/signin/verifiy_phone_page.dart';
import 'package:fatora/features/auth/presentation/pages/signup/sign_up_page.dart';
import 'package:fatora/router/routes.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.landingPage:
        return _getPageRoute(
            routeName: settings.name, page: const LandingPage());
      case Routes.signup:
        return _getPageRoute(
            routeName: settings.name, page: const SignUpPage());
      case Routes.verifiyPhone:
        return _getPageRoute(
            routeName: settings.name, page: const VerifyPhonePage());

      default:
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            appBar: AppBar(
              title: const Text('Route not foud'),
            ),
          ),
        );
    }
  }
}

PageRoute _getPageRoute({
  required String? routeName,
  required Widget page,
  RouteSettings? routeSettings,
}) {
  return MaterialPageRoute(
    builder: (_) => page,
    settings: routeSettings ??
        RouteSettings(
          name: routeName,
        ),
  );
}
