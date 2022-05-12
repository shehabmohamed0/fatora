
import 'package:fatora/core/resources/constants_manager.dart';
import 'package:fatora/features/auth/presentation/bloc/sign_in/phone/phone_sign_in_cubit.dart';
import 'package:fatora/features/auth/presentation/pages/signin/widgets/otp_form.dart';
import 'package:fatora/features/auth/presentation/pages/signin/widgets/phone_form.dart';
import 'package:fatora/locator/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:formz/formz.dart';

class VerifyPhonePage extends HookWidget {
  const VerifyPhonePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pageController = usePageController(
      initialPage: 0,
    );
    return BlocProvider<PhoneSignInCubit>(
        create: (context) => locator(),
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Phone verification'),
          ),
          body: BlocListener<PhoneSignInCubit, PhoneSignInState>(
            listener: (context, state) {
              if (state.phoneFormStatus.isSubmissionFailure ||
                  state.smsFormStatus.isSubmissionFailure) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(
                        content: Text(state.errorMessage ?? 'Sign In Failure')),
                  );
              }
            },
            child: BlocConsumer<PhoneSignInCubit, PhoneSignInState>(
              listenWhen: (previous, current) => previous.step != current.step,
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
                      context.read<PhoneSignInCubit>().previosStep(context),
                  child: PageView(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: pageController,
                    children: const [PhoneForm(), OTPForm()],
                  ),
                );
              },
            ),
          ),
        ));
  }
}
