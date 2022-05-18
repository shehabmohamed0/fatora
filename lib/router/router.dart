import 'package:fatora/features/auth/presentation/bloc/sign_up/complete_form/complete_form_cubit.dart';
import 'package:fatora/features/auth/presentation/bloc/sign_up/flow_cubit/sign_up_flow_cubit.dart';
import 'package:fatora/features/auth/presentation/bloc/sign_up/otp_cubit/otp_cubit.dart';
import 'package:fatora/features/auth/presentation/bloc/sign_up/sign_up_form/sign_up_form_cubit.dart';
import 'package:fatora/features/auth/presentation/pages/landing/landing_page.dart';
import 'package:fatora/features/auth/presentation/pages/signup/sign_up_page.dart';
import 'package:fatora/features/auth/presentation/pages/verifiy_phone/verifiy_phone_page.dart';
import 'package:fatora/features/settings/presentation/bloc/add_email/add_email_cubit.dart';
import 'package:fatora/features/settings/presentation/pages/account_info/account_info_page.dart';
import 'package:fatora/features/settings/presentation/pages/change_phone/change_phone_page.dart';
import 'package:fatora/features/settings/presentation/pages/change_phone/otp_page.dart';
import 'package:fatora/features/settings/presentation/pages/add_email/add_email_page.dart';
import 'package:fatora/features/settings/presentation/pages/email_info/email_info_page.dart';
import 'package:fatora/features/settings/presentation/pages/phone_info/phone_info_page.dart';
import 'package:fatora/features/settings/presentation/pages/settings/settings_page.dart';
import 'package:fatora/locator/locator.dart';
import 'package:fatora/router/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.landingPage:
        return _getPageRoute(
            routeName: settings.name,
            builder: (context) => const LandingPage());
      case Routes.signup:
        return _getPageRoute(
            routeName: settings.name,
            builder: (context) => MultiBlocProvider(
                  providers: [
                    BlocProvider<SignUpFlowCubit>(
                      create: (_) => locator(),
                    ),
                    BlocProvider<SignUpFormCubit>(
                      create: (_) => locator(),
                    ),
                    BlocProvider<OTPCubit>(
                      create: (_) => locator(),
                    ),
                    BlocProvider<CompleteFormCubit>(
                      create: (_) => locator(),
                    ),
                  ],
                  child: const SignUpPage(),
                ));
      // case Routes.verifiyPhone:
      //   return _getPageRoute(
      //     routeName: settings.name,
      //     builder: (context) => const VerifiyPhonePage(
      //       verificaionId: '',
      //       phoneNumber: '',
      //     ),
      //   );
      case Routes.settings:
        return _getPageRoute(
            routeName: settings.name,
            builder: (context) => const SettingsPage());
      case Routes.accountInfo:
        return _getPageRoute(
            routeName: settings.name,
            builder: (context) => const AccountInfoPage());
      case Routes.phoneInfo:
        return _getPageRoute(
            routeName: settings.name,
            builder: (context) => const PhoneInfoPage());
      case Routes.changePhone:
        return _getPageRoute(
            routeName: settings.name,
            builder: (context) => const ChangePhonePage());
      case Routes.otp:
        return _getPageRoute(
            routeName: settings.name, builder: (context) => const OTPPage());
      case Routes.emailInfo:
        return _getPageRoute(
            routeName: settings.name,
            builder: (context) => const EmailInfoPage());
      case Routes.addEmail:
        return _getPageRoute(
            routeName: settings.name,
            builder: (context) => BlocProvider<AddEmailCubit>(
                  create: (context) => locator(),
                  child: const AddEmailPage(),
                ));

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
  required Widget Function(BuildContext) builder,
  RouteSettings? routeSettings,
}) {
  return MaterialPageRoute(
    builder: builder,
    settings: routeSettings ??
        RouteSettings(
          name: routeName,
        ),
  );
}
