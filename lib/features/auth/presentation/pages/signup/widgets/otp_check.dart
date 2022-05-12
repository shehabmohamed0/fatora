import 'package:fatora/core/resources/constants_manager.dart';
import 'package:fatora/core/resources/values_manager.dart';
import 'package:fatora/features/auth/presentation/bloc/sign_up/otp_cubit/otp_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:pinput/pinput.dart';

class OTPCheckWidget extends StatefulWidget {
  const OTPCheckWidget({Key? key}) : super(key: key);

  @override
  State<OTPCheckWidget> createState() => _OTPCheckWidgetState();
}

class _OTPCheckWidgetState extends State<OTPCheckWidget>
    with AutomaticKeepAliveClientMixin {
  final TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    super.build(context);

    return BlocConsumer<OTPCubit, OTPState>(
      listener: (context, state) {
        if (state.status.isSubmissionSuccess) {
          if (state.autoGetCode) {
            setState(() {
              controller.text = state.otp.value;
            });
          }
        } else if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(content: Text(state.errorMessage ?? 'Sign Up Failure')),
            );
        } else if (state.status.isPure) {
          setState(() {
            controller.text = '';
          });
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: ListView(
            children: [
              if (state.status.isSubmissionInProgress)
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
  bool get wantKeepAlive => true;
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
