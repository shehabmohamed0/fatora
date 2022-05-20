import 'package:fatora/core/resources/constants_manager.dart';
import 'package:fatora/core/resources/values_manager.dart';
import 'package:fatora/features/settings/presentation/bloc/change_phone/update_phone_cubit.dart';
import 'package:fatora/router/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:pinput/pinput.dart';
import 'package:formz/formz.dart';

class OTPPage extends HookWidget {
  const OTPPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Verification'),
      ),
      body: BlocConsumer<UpdateePhoneCubit, UpdatePhoneState>(
        listener: (context, state) {
          if (state.otpFormStatus.isSubmissionSuccess) {
            Navigator.popUntil(
                context, (route) => route.settings.name == Routes.settings);
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('phone changed succssesflly')));
          } else if (state.otpFormStatus.isSubmissionFailure) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(state.errorMessage ?? 'Something went wrong')));
          }
        },
        buildWhen: _buildWhen,
        builder: (context, state) {
          if (state.autoRetrievedSMS) {
            controller.text = state.otp.value;
          }
          return ListView(
            children: [
              if (state.otpFormStatus.isSubmissionInProgress)
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
                      controller: controller,
                      length: 6,
                      onChanged: context.read<UpdateePhoneCubit>().otpChanged,
                      onCompleted:
                          context.read<UpdateePhoneCubit>().onCompletedOneTime,
                    ),
                    const SizedBox(height: 24),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: TweenAnimationBuilder<double>(
                        tween: Tween<double>(begin: 60, end: 0),
                        duration: AppConstants.duration60s,
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
                                      fontWeight: FontWeight.bold,
                                    ),
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
                                  fontWeight: FontWeight.bold,
                                ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 54,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: state.otpFormStatus.isValid ||
                                state.otpFormStatus.isSubmissionFailure
                            ? context.read<UpdateePhoneCubit>().complete
                            : null,
                        child: const Text(
                          'Verify',
                          style: TextStyle(letterSpacing: 2),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  bool _buildWhen(UpdatePhoneState previous, UpdatePhoneState current) =>
      previous.otp != current.otp ||
      previous.otpFormStatus != current.otpFormStatus ||
      previous.otpFormCompletedOneTime != current.otpFormCompletedOneTime ||
      previous.autoRetrievedSMS != current.autoRetrievedSMS ||
      previous.phoneAuthCredential != current.phoneAuthCredential;
}
