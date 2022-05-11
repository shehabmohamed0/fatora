import 'package:fatora/features/auth/presentation/bloc/sign_in/phone/phone_sign_in_cubit.dart';
import 'package:fatora/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class PhoneForm extends StatefulWidget {
  const PhoneForm({Key? key}) : super(key: key);

  @override
  State<PhoneForm> createState() => _PhoneFormState();
}

class _PhoneFormState extends State<PhoneForm>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<PhoneSignInCubit, PhoneSignInState>(
      builder: (context, state) {
        return Container(
          color: Colors.white,
          child: Column(
            children: [
              if (state.phoneFormStatus.isSubmissionInProgress)
                const LinearProgressIndicator(),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    '🇪🇬 ',
                    style: TextStyle(fontSize: 28),
                  ),
                  Flexible(
                      child: CustomTextField(
                    labelText: 'Phone number',
                    helperText: '',
                    errorText: () {
                      return state.phoneNumber.invalid
                          ? 'invalid phone number'
                          : null;
                    },
                    onChanged: context.read<PhoneSignInCubit>().phoneChanged,
                  )),
                ],
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                  onPressed: !state.phoneFormStatus.isSubmissionInProgress
                      ? context.read<PhoneSignInCubit>().submit
                      : null,
                  child: const Text('Next')),
            ],
          ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
