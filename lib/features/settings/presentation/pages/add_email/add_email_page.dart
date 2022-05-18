import 'package:fatora/features/settings/presentation/bloc/add_email/add_email_cubit.dart';
import 'package:fatora/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class AddEmailPage extends StatelessWidget {
  const AddEmailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Email'),
      ),
      body: BlocConsumer<AddEmailCubit, AddEmailState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Column(
            children: [
              if (state.status.isSubmissionInProgress)
                const LinearProgressIndicator(),
              CustomTextField(
                labelText: 'Email',
                onChanged: context.read<AddEmailCubit>().emailChanged,
                errorText: () {
                  return null;
                },
              ),
              const SizedBox(height: 8),
              CustomTextField(
                labelText: 'Password',
                onChanged: context.read<AddEmailCubit>().passwordChanged,
                errorText: () {
                  return null;
                },
              ),
              const SizedBox(height: 8),
              ElevatedButton(onPressed: () {}, child: const Text('Add'))
            ],
          );
        },
      ),
    );
  }
}
