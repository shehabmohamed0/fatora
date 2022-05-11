import 'package:fatora/features/auth/presentation/bloc/app_status/app_bloc.dart';
import 'package:fatora/features/auth/presentation/pages/signin/sign_in_page.dart';
import 'package:fatora/features/cart/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        switch (state.status) {
          case AppStatus.authenticated:
            return const HomePage();
          case AppStatus.unauthenticated:
            return const SignInPage();
        }
      },
    );
  }
}
