import 'package:fatora/features/auth/presentation/bloc/sign_up/complete_form/complete_form_cubit.dart';
import 'package:fatora/widgets/bloc_text_field.dart';
import 'package:flutter/material.dart';

class CompleteForm extends StatelessWidget {
  const CompleteForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: const [_EmailTextField(), _PasswordTextField()],
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
