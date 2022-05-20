import 'package:fatora/core/resources/values_manager.dart';
import 'package:fatora/features/auth/presentation/bloc/sign_up/complete_form/complete_form_cubit.dart';
import 'package:fatora/widgets/bloc_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class CompleteForm extends StatelessWidget {
  const CompleteForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomSheet: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Material(
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [_SkipButton(), _AddButton()],
          ),
        ),
      ),
      body: BlocListener<CompleteFormCubit, CompleteFormState>(
        listener: (context, state) {
          if (state.status.isSubmissionSuccess) {
            Navigator.of(context).pop();
          } else if (state.status.isSubmissionFailure) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                    content: Text(state.errorMessage ??
                        'Failed to link email and password')),
              );
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(AppPadding.p16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(
                  Icons.check_circle_sharp,
                  color: Colors.green,
                  size: 40,
                ),
                Text('Your account has been created successfully',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineSmall),
                const SizedBox(height: 14),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Want to add extra way to sign in?',
                      style: Theme.of(context).textTheme.titleLarge),
                ),
                const _EmailTextField(),
                const _PasswordTextField(),
                const SizedBox(
                  height: 40,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PasswordTextField extends StatelessWidget {
  const _PasswordTextField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocTextFieldInput<CompleteFormCubit, CompleteFormState>(
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

class _EmailTextField extends StatelessWidget {
  const _EmailTextField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocTextFieldInput<CompleteFormCubit, CompleteFormState>(
      labelText: 'email',
      helperText: '',
      errorText: (state) => state.email.invalid ? 'invalid email' : null,
      keyboaedType: TextInputType.emailAddress,
      buildWhen: (previous, current) =>
          previous.email.status != current.email.status,
      onChanged: (bloc, email) => bloc.emailChanged(email),
    );
  }
}

class _SkipButton extends StatelessWidget {
  const _SkipButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: const Text('Skip'));
  }
}

class _AddButton extends StatelessWidget {
  const _AddButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CompleteFormCubit, CompleteFormState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) => state.status.isSubmissionInProgress
          ?  CircularProgressIndicator(color: Theme.of(context).primaryColor,)
          : ElevatedButton(
              onPressed: state.status.isValid
                  ? context.read<CompleteFormCubit>().submit
                  : null,
              child: const Text('Add'),
            ),
    );
  }
}
