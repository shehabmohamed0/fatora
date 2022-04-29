import 'package:fatora/features/auth/presentation/bloc/sign_up/sign_up_cubit.dart';
import 'package:fatora/features/auth/presentation/pages/signup/widgets/sign_up_form.dart';
import 'package:fatora/locator/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const SignUpPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign Up')),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: BlocProvider<SignUpCubit>(
          create: (_) => SignUpCubit(locator()),
          child: const SignUpForm(),
        ),
      ),
    );
  }
}
