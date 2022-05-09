import 'package:fatora/features/auth/presentation/bloc/sign_up/otp_cubit/otp_cubit.dart';
import 'package:fatora/resources/constants_manager.dart';
import 'package:fatora/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:formz/formz.dart';
import 'package:pinput/pinput.dart';

class OTPCheckWidget extends HookWidget {
  const OTPCheckWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController();

    return BlocConsumer<OTPCubit, OTPState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Column(
          children: [
            if (state.status.isSubmissionInProgress)
              const LinearProgressIndicator(),
            Flexible(
              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.symmetric(
                    horizontal: AppPadding.p16, vertical: AppPadding.p16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
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
                      onChanged: context.read<OTPCubit>().otpChanged,
                      onCompleted: (smscode) {
                        context.read<OTPCubit>().onCompleted(smscode, context);
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
                    const Spacer(),
                    const Align(
                      alignment: Alignment.bottomRight,
                      child: _NextButton(),
                    )
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _NextButton extends StatelessWidget {
  const _NextButton();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OTPCubit, OTPState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return ElevatedButton(
          onPressed: state.status.isValidated
              ? () {
                  context.read<OTPCubit>().submit(context);
                }
              : null,
          style: ElevatedButton.styleFrom(
              elevation: 0, shape: const RoundedRectangleBorder()),
          child: const Text('NEXT'),
        );
      },
    );
  }
}
