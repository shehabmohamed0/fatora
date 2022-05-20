import 'package:fatora/core/extensions/formz_extesion.dart';
import 'package:fatora/core/form_inputs/email.dart';
import 'package:fatora/core/form_inputs/password.dart';
import 'package:fatora/features/settings/presentation/bloc/cubit/update_email_cubit.dart';
import 'package:fatora/widgets/password_text_field.dart';
import 'package:fatora/widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import '../../../../auth/presentation/bloc/app_status/app_bloc.dart';

class UpdateEmailPage extends StatelessWidget {
  const UpdateEmailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.select((AppBloc bloc) => bloc.state.user);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update email'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: BlocConsumer<UpdateEmailCubit, UpdateEmailState>(
          listener: (context, state) {
            switch (state.status) {
              case FormzStatus.submissionFailure:
                showSnackBar(context, state.errorMessage ?? 'no message');
                break;
              case FormzStatus.submissionSuccess:
                Navigator.pop(context);
                break;
              default:
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('New email',
                      style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 4),
                  TextField(
                    onChanged: context.read<UpdateEmailCubit>().emailChanged,
                    decoration: InputDecoration(
                        errorText: state.email.validationMessage()),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Current password',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 4),
                  PasswordTextField(
                    onChanged: context.read<UpdateEmailCubit>().passwordChanged,
                    errorText: state.password.validationMessage(),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: state.status.isButtonValid()
                          ? () {
                              context
                                  .read<UpdateEmailCubit>()
                                  .submit(user.email!);
                            }
                          : null,
                      child: state.status.isSubmissionInProgress
                          ? CircularProgressIndicator(
                              color: Theme.of(context).primaryColor,
                            )
                          : const Text('update'),
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
