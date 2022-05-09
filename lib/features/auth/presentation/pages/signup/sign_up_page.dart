import 'package:fatora/features/auth/presentation/bloc/sign_up/flow_cubit/sign_up_flow_cubit.dart';
import 'package:fatora/features/auth/presentation/bloc/sign_up/otp_cubit/otp_cubit.dart';
import 'package:fatora/features/auth/presentation/bloc/sign_up/sign_up_form/sign_up_form_cubit.dart';
import 'package:fatora/features/auth/presentation/pages/signup/widgets/otp_check.dart';
import 'package:fatora/features/auth/presentation/pages/signup/widgets/sign_up_form.dart';
import 'package:fatora/locator/locator.dart';
import 'package:fatora/resources/constants_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const SignUpPage());
  }

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final PageController pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign Up')),
      body:  MultiBlocProvider(
          providers: [
            BlocProvider<SignUpFlowCubit>(
              create: (_) => locator(),
            ),
            BlocProvider<SignUpFormCubit>(
              create: (_) => locator(),
            ),
            BlocProvider<OTPCubit>(
              create: (_) => locator(),
            )
          ],
          child: BlocConsumer<SignUpFlowCubit, SignUpFlowState>(
            listener: (context, state) {
              pageController.animateToPage(
                state.step,
                duration: AppConstants.duration300ms,
                curve: Curves.bounceIn,
              );
            },
            builder: (context, state) {
              return WillPopScope(
                onWillPop: () =>
                    context.read<SignUpFlowCubit>().previosStep(context),
                child: PageView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: pageController,
                  children: const [
                    SignUpForm(),
                    OTPCheckWidget(),
                  ],
                ),
              );
            },
          
        ),
      ),
    );
  }
}
