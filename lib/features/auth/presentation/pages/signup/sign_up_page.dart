import 'package:fatora/core/resources/constants_manager.dart';
import 'package:fatora/features/auth/presentation/bloc/sign_up/complete_form/complete_form_cubit.dart';
import 'package:fatora/features/auth/presentation/bloc/sign_up/flow_cubit/sign_up_flow_cubit.dart';
import 'package:fatora/features/auth/presentation/bloc/sign_up/otp_cubit/otp_cubit.dart';
import 'package:fatora/features/auth/presentation/bloc/sign_up/sign_up_form/sign_up_form_cubit.dart';
import 'package:fatora/features/auth/presentation/pages/signup/widgets/complete_form.dart';
import 'package:fatora/features/auth/presentation/pages/signup/widgets/otp_check.dart';
import 'package:fatora/features/auth/presentation/pages/signup/widgets/sign_up_form.dart';
import 'package:fatora/locator/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final PageController pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign Up')),
      body: BlocConsumer<SignUpFlowCubit, SignUpFlowState>(
        buildWhen: (previous, current) => false,
        listener: (context, state) {
          pageController.animateToPage(
            state.step,
            duration: AppConstants.duration200ms,
            curve: Curves.bounceIn,
          );
        },
        builder: (context, state) {
          return WillPopScope(
            onWillPop: () =>
                context.read<SignUpFlowCubit>().previosStep(context),
            child: PageView(
              controller: pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: const [SignUpForm(), OTPCheckWidget(), CompleteForm()],
            ),
          );
        },
      ),
    );
  }
}
