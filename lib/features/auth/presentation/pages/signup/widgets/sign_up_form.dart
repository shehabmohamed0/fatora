import 'package:fatora/features/auth/presentation/bloc/sign_up/sign_up_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../../../../../widgets/bloc_text_field.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpCubit, SignUpState>(
      listener: (context, state) {
        if (state.status.isSubmissionSuccess) {
          Navigator.of(context).pop();
        } else if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(content: Text(state.errorMessage ?? 'Sign Up Failure')),
            );
        }
      },
      child: Align(
        alignment: const Alignment(0, -1 / 3),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const _FirstNameTextField(),
              const _FirstNameTextField(),
              const SizedBox(height: 8),
              const _PasswordTextField(),
              const SizedBox(height: 8),
              const _PhoneNumberTextField(),
              const SizedBox(height: 8),
              const _EmailTextField(),
              const SizedBox(height: 8),
              _SignUpButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmailTextField extends StatelessWidget {
  const _EmailTextField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocTextFieldInput<SignUpCubit, SignUpState>(
      labelText: 'email',
      helperText: '',
      errorText: (state) => state.email.invalid ? 'invalid email' : null,
      keyboaedType: TextInputType.emailAddress,
      buildWhen: (previous, current) =>
          previous.email.status != current.password.status,
      onChanged: (bloc, email) => bloc.emailChanged(email),
    );
  }
}

class _PhoneNumberTextField extends StatelessWidget {
  const _PhoneNumberTextField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocTextFieldInput<SignUpCubit, SignUpState>(
      labelText: 'phone number',
      helperText: '',
      errorText: (state) =>
          state.phoneNumber.invalid ? 'invalid phone number' : null,
      buildWhen: (previous, current) =>
          previous.phoneNumber != current.phoneNumber,
      onChanged: (bloc, phone) => bloc.phoneChanged(phone),
    );
  }
}

class _PasswordTextField extends StatelessWidget {
  const _PasswordTextField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocTextFieldInput<SignUpCubit, SignUpState>(
      labelText: 'password',
      helperText: '',
      isPassword: true,
      errorText: (state) => state.password.invalid
          ? 'password must be at least 8 character'
          : null,
      buildWhen: (previous, current) =>
          previous.password.status != current.password.status,
      onChanged: (bloc, password) => bloc.passwordChanged(password),
    );
  }
}

class _FirstNameTextField extends StatelessWidget {
  const _FirstNameTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocTextFieldInput<SignUpCubit, SignUpState>(
      labelText: 'First name',
      buildWhen: (previous, current) =>
          previous.firstName.status != current.firstName.status,
      onChanged: (bloc, value) {
        bloc.firstNameChanged(value);
      },
      errorText: (state) =>
          state.firstName.invalid ? 'name can not be empty.' : null,
    );
  }
}

class _SecondNameTextField extends StatelessWidget {
  const _SecondNameTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocTextFieldInput<SignUpCubit, SignUpState>(
      labelText: 'First name',
      buildWhen: (previous, current) =>
          previous.firstName.status != current.firstName.status,
      onChanged: (bloc, value) {
        bloc.firstNameChanged(value);
      },
      errorText: (state) =>
          state.firstName.invalid ? 'name can not be empty.' : null,
    );
  }
}

class _SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
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
                    ? () => context.read<SignUpCubit>().signUpFormSubmitted()
                    : null,
                child: const Text('SIGN UP'),
              );
      },
    );
  }
}
