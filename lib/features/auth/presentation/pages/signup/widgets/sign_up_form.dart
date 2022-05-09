import 'package:fatora/features/auth/presentation/bloc/sign_up/flow_cubit/sign_up_flow_cubit.dart';
import 'package:fatora/features/auth/presentation/bloc/sign_up/otp_cubit/otp_cubit.dart';
import 'package:fatora/features/auth/presentation/bloc/sign_up/sign_up_form/sign_up_form_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../../../../../widgets/bloc_text_field.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpFormCubit, SignUpFormState>(
      listener: (context, state) async {
        // if (state.status.isSubmissionSuccess) {
        //   Navigator.of(context).pop();
        // } else if (state.status.isSubmissionFailure) {
        //   ScaffoldMessenger.of(context)
        //     ..hideCurrentSnackBar()
        //     ..showSnackBar(
        //       SnackBar(content: Text(state.errorMessage ?? 'Sign Up Failure')),
        //     );
        // }
      },
      child: Align(
        alignment: const Alignment(0, -1 / 3),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const _FirstNameTextField(),
                const SizedBox(height: 8),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Text(
                      '🇪🇬 ',
                      style: TextStyle(fontSize: 28),
                    ),
                    Flexible(child: _PhoneNumberTextField()),
                  ],
                ),
                const SizedBox(height: 8),
                // const _EmailTextField(),
                // const SizedBox(height: 8),
                // const _PasswordTextField(),
                const SizedBox(height: 8),
                const _SignUpButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PhoneNumberTextField extends StatelessWidget {
  const _PhoneNumberTextField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocTextFieldInput<SignUpFormCubit, SignUpFormState>(
      labelText: 'Phone number',
      helperText: '',
      errorText: (state) =>
          state.phoneNumber.invalid ? 'invalid phone number' : null,
      buildWhen: (previous, current) =>
          previous.phoneNumber != current.phoneNumber,
      onChanged: (bloc, phone) => bloc.phoneChanged(phone),
    );
  }
}

class _FirstNameTextField extends StatelessWidget {
  const _FirstNameTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocTextFieldInput<SignUpFormCubit, SignUpFormState>(
      labelText: 'First name',
      buildWhen: (previous, current) =>
          previous.name.status != current.name.status,
      onChanged: (bloc, value) {
        bloc.nameChanged(value);
      },
      errorText: (state) =>
          state.name.invalid ? 'name can not be empty.' : null,
    );
  }
}

class _SignUpButton extends StatelessWidget {
  const _SignUpButton();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpFormCubit, SignUpFormState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : ElevatedButton(
                key: const Key('signUpForm_continue_raisedButton'),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  primary: Colors.orangeAccent,
                ),
                onPressed: state.status.isValidated
                    ? () => context
                        .read<SignUpFormCubit>()
                        .signUpFormSubmitted(context)
                    : null,
                child: const Text('SIGN UP'),
              );
      },
    );
  }
}
