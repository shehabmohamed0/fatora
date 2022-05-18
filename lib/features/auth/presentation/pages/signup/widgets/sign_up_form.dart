import 'package:fatora/core/form_inputs/phone_number.dart';
import 'package:fatora/features/auth/presentation/bloc/sign_up/sign_up_form/sign_up_form_cubit.dart';
import 'package:fatora/widgets/international_phone_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../../../../../widgets/bloc_text_field.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({
    Key? key,
  }) : super(key: key);

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm>
    with AutomaticKeepAliveClientMixin {
  final textController = TextEditingController();

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocListener<SignUpFormCubit, SignUpFormState>(
      listener: (context, state) {
        if (state.status.isSubmissionSuccess) {
          // Navigator.of(context).pop();
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
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const _FirstNameTextField(),
                const SizedBox(height: 8),

                BlocBuilder<SignUpFormCubit, SignUpFormState>(
                  builder: (context, state) {
                    return InternationalPhoneTextField(
                      controller: textController,
                      countries: const ['EG'],
                      errorText: () {
                        return state.phoneNumber.validationMessage();
                      },
                      onInputChanged: (phoneNumber) {
                        context
                            .read<SignUpFormCubit>()
                            .phoneChanged(phoneNumber.phoneNumber!);
                      },
                    );
                  },
                ),
             
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
