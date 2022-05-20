import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:fatora/core/extensions/formz_extesion.dart';
import 'package:fatora/features/settings/presentation/bloc/add_email/add_email_cubit.dart';
import 'package:fatora/router/routes.dart';
import 'package:fatora/widgets/custom_text_field.dart';
import 'package:fatora/widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:fatora/core/form_inputs/email.dart';
import 'package:fatora/core/form_inputs/password.dart';

class AddEmailPage extends StatelessWidget {
  const AddEmailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Email'),
        elevation: 0,
      ),
      body: BlocConsumer<AddEmailCubit, AddEmailState>(
        listener: (context, state) {
          switch (state.status) {
            case FormzStatus.submissionSuccess:
              Navigator.pop(context);
              break;
            case FormzStatus.submissionFailure:
              showSnackBar(context,
                  state.errorMessage ?? 'Error while adding the email');
              break;
            case FormzStatus.submissionCanceled:
              AwesomeDialog(
                      context: context,
                      dialogType: DialogType.NO_HEADER,
                      headerAnimationLoop: false,
                      title: 'Relogin',
                      desc: state.errorMessage,
                      showCloseIcon: true,
                      bodyHeaderDistance: 10,
                      btnCancelOnPress: () {},
                      btnOkOnPress: () {},
                    ).show();
              break;
            default:
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CustomTextField(
                  labelText: 'Email',
                  onChanged: context.read<AddEmailCubit>().emailChanged,
                  errorText: state.email.validationMessage,
                ),
                const SizedBox(height: 8),
                CustomTextField(
                  labelText: 'Password',
                  onChanged: context.read<AddEmailCubit>().passwordChanged,
                  errorText: state.password.validationMessage,
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: state.status.isButtonValid()
                      ? context.read<AddEmailCubit>().submit
                      : null,
                  child: state.status.isSubmissionInProgress
                      ? const CircularProgressIndicator()
                      : const Text('Add'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
