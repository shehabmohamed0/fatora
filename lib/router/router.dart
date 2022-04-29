import 'package:fatora/features/auth/presentation/bloc/app_status/app_bloc.dart';
import 'package:fatora/features/auth/presentation/pages/signin/sign_in_page.dart';
import 'package:fatora/features/auth/presentation/pages/signup/sign_up_page.dart';
import 'package:fatora/features/cart/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';

List<Page> onGenerateAppViewPages(AppStatus state, List<Page<dynamic>> pages) {
  switch (state) {
    case AppStatus.authenticated:
      return [HomePage.page()];
    case AppStatus.unauthenticated:
      return [SignInPage.page()];
  }
}

// class AppRouter {
//   static Route<dynamic> generateRoute(RouteSettings settings) {
//     switch (settings.name) {
//     }
//   }
// }

// PageRoute _getPageRoute({
//   required String? routeName,
//   required Widget view,
//   RouteSettings? routeSettings,
// }) {
//   return MaterialPageRoute(
//     builder: (_) => view,
//     settings: routeSettings ??
//         RouteSettings(
//           name: routeName,
//         ),
//   );
// }
