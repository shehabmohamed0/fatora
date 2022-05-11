import 'dart:developer';

import 'package:fatora/features/auth/presentation/bloc/sign_in/phone/phone_sign_in_cubit.dart';
import 'package:fatora/resources/constants_manager.dart';
import 'package:fatora/resources/values_manager.dart';
import 'package:fatora/router/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:pinput/pinput.dart';

class OTPForm extends StatefulWidget {
  const OTPForm({Key? key}) : super(key: key);

  @override
  State<OTPForm> createState() => _OTPFormState();
}

class _OTPFormState extends State<OTPForm> {
  final controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();
    return BlocConsumer<PhoneSignInCubit, PhoneSignInState>(
      listener: (context, state) {
        if (state.smsFormStatus.isSubmissionSuccess) {
          Navigator.of(context).popUntil((route) => route.settings.name ==Routes.landingPage);
        }
        if (state.autoFilled) {
          log('${state.autoFilled}');
          setState(() {
            controller.text = state.otp.value;
          });
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: ListView(
            children: [
              if (state.phoneFormStatus.isSubmissionInProgress)
                const LinearProgressIndicator(),
              Padding(
                padding: const EdgeInsets.all(AppPadding.p16),
                child: Column(
                  children: [
                    Text(
                      'Enter the code',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Enter the 6-digit verification code to confirm you got the text message',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 16),
                    Pinput(
                      length: 6,
                      controller: controller,
                      onChanged: context.read<PhoneSignInCubit>().otpChanged,
                      onCompleted: (smscode) {
                        context.read<PhoneSignInCubit>().onCompleted(smscode);
                      },
                    ),
                    const SizedBox(height: 24),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: TweenAnimationBuilder<double>(
                        tween: Tween<double>(begin: 30, end: 0),
                        duration: AppConstants.duration30s,
                        builder: (_, second, __) {
                          if (second == 0) {
                            return TextButton(
                              onPressed: () {},
                              child: Text(
                                'Get new code',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                        color: Colors.blueAccent,
                                        fontWeight: FontWeight.bold),
                              ),
                            );
                          }
                          return Text(
                            'Get new code (${second.toInt()} seconds)',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                    color: Colors.grey.shade400,
                                    fontWeight: FontWeight.bold),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          bottomSheet:
              Row(mainAxisAlignment: MainAxisAlignment.end, children: const [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: _NextButton(),
            ),
          ]),
        );
      },
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

class _NextButton extends StatelessWidget {
  const _NextButton();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PhoneSignInCubit, PhoneSignInState>(
      buildWhen: (previous, current) =>
          previous.phoneFormStatus != current.phoneFormStatus,
      builder: (context, state) {
        return ElevatedButton(
          onPressed: state.phoneFormStatus.isValidated
              ? context.read<PhoneSignInCubit>().submitSMS
              : null,
          style: ElevatedButton.styleFrom(
              elevation: 0, shape: const RoundedRectangleBorder()),
          child: const Text('NEXT'),
        );
      },
    );
  }
}
