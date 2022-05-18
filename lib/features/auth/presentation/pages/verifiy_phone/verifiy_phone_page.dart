import 'package:fatora/core/resources/assets_manager.dart';
import 'package:fatora/features/auth/presentation/bloc/sign_in/phone_form/phone_form_cubit.dart';
import 'package:fatora/features/auth/presentation/bloc/verifiy_phone/verifiy_phone_cubit.dart';
import 'package:fatora/features/auth/presentation/pages/verifiy_phone/widgets/otp_widget.dart';
import 'package:fatora/widgets/ensure_visible_when_focused.dart';
import 'package:fatora/widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:formz/formz.dart';

class VerifiyPhonePage<T extends VerifiyPhoneCubit> extends HookWidget {
  const VerifiyPhonePage({
    Key? key,
    required this.phoneNumber,
    required this.onSubmit,
    required this.onSubmmisionSuccess,
  }) : super(key: key);
  final String phoneNumber;
  final Function(T t) onSubmit;
  final VoidCallback onSubmmisionSuccess;
  @override
  Widget build(BuildContext context) {
    final textController = useTextEditingController();
    final focusNode = useFocusNode();

    return Scaffold(
      appBar: AppBar(
        title: const Text('OTP'),
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Image.asset(
                        ImageAssets.otpPNG,
                      ),
                    ),
                    const SizedBox(height: 32),
                    const Text(
                      'Verification code',
                      style:
                          TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'We have sent the code verifiaction to\nYour Mobile Number',
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .copyWith(
                              color: Colors.grey, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      phoneNumber,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 16),
                    BlocConsumer<T, VerifiyPhoneState>(
                      listener: (context, state) {
                        if (state.status.isSubmissionSuccess) {
                          onSubmmisionSuccess();
                        } else if (state.status.isSubmissionFailure) {
                          showSnackBar(context, state.errorMessage ?? 'failed');
                        }
                      },
                     
                      builder: (context, state) {
                        if (state.autoRecievedCode) {


                          textController.text = state.otp.value;
                          print(textController.value);
                        }
                        return EnsureVisibleWhenFocused(
                          focusNode: focusNode,
                          child: OTPWidget(
                            controller: textController,
                            focusNode: focusNode,
                            onCompleted: state.autoVerified
                                ? null
                                : (s) {
                                    final bloc = context.read<T>();
                                    onSubmit(bloc);
                                    bloc.onComplete();
                                  },
                            onChanged: context.read<T>().otpChanged,
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ),
          BlocBuilder<T, VerifiyPhoneState>(
            buildWhen: (previous, current) => previous.status != current.status,
            builder: (context, state) {
              return Container(
                width: double.infinity,
                margin: const EdgeInsets.all(16),
                child: ElevatedButton(
                  onPressed: !state.status.isInvalid &&
                          !state.status.isSubmissionInProgress
                      ? () {
                          final bloc = context.read<T>();
                          onSubmit(bloc);
                        }
                      : null,
                  child: state.status.isSubmissionInProgress
                      ? CircularProgressIndicator(
                          color: Theme.of(context).primaryColor,
                        )
                      : const Text('Verifiy'),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
