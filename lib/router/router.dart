import 'package:fatora/features/auth/presentation/pages/landing/landing_page.dart';
import 'package:fatora/features/auth/presentation/pages/signin/verifiy_phone_page.dart';
import 'package:fatora/features/auth/presentation/pages/signup/sign_up_page.dart';
import 'package:fatora/features/settings/presentation/pages/account_info/account_info_page.dart';
import 'package:fatora/features/settings/presentation/pages/change_phone/change_phone_page.dart';
import 'package:fatora/features/settings/presentation/pages/phone_info/phone_info_page.dart';
import 'package:fatora/features/settings/presentation/pages/settings/settings_page.dart';
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
      case Routes.settings:
        return _getPageRoute(
            routeName: settings.name, page: const SettingsPage());
      case Routes.accountInfo:
        return _getPageRoute(
            routeName: settings.name, page: const AccountInfoPage());
      case Routes.phoneInfo:
        return _getPageRoute(
            routeName: settings.name, page: const PhoneInfoPage());
      case Routes.changePhone:
        return _getPageRoute(
            routeName: settings.name, page: const ChangePhonePage());

      default:
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            appBar: AppBar(
              title: const Text('Route not found'),
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
