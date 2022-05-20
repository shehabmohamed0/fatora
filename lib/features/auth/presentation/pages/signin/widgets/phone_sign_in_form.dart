part of '../sign_in_page.dart';

class PhoneSignInForm extends StatelessWidget {
  const PhoneSignInForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PhoneFormCubit, PhoneFormState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(state.errorMessage ?? 'Authentication Failure'),
              ),
            );
        } else if (state.status.isSubmissionSuccess) {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => BlocProvider<PhoneSignInVerificationCubit>(
                  create: (context) => locator(),
                  child: VerifiyPhonePage<PhoneSignInVerificationCubit>(
                    phoneNumber: state.phoneNumber.value,
                    onSubmit: (bloc) {
                      bloc.signInWithPhoneNumber(state.verificationId!);
                    },
                    onSubmmisionSuccess: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ));
        }
      },
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),
            Text(
              'Phone number',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 4),
            InternationalPhoneTextField(
              countries: const ['EG'],
              errorText: state.phoneNumber.validationMessage,
              onInputChanged: (phone) => context
                  .read<PhoneFormCubit>()
                  .phoneChanged(phone.phoneNumber!),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: !state.status.isInvalid &&
                        !state.status.isSubmissionInProgress&& !state.status.isPure
                    ? context.read<PhoneFormCubit>().verifiy
                    : null,
                child: state.status.isSubmissionInProgress
                    ? CircularProgressIndicator(
                        color: Theme.of(context).primaryColor,
                      )
                    : const Text(
                        'Verifiy',
                        style: TextStyle(letterSpacing: 2),
                      ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Text(
                  'Not registered yet?',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                TextButton(
                  style: TextButton.styleFrom(
                      visualDensity: VisualDensity.compact),
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.signup);
                  },
                  child: Text(
                    'Create an Account.',
                    style: TextStyle(color: Colors.orange.shade900),
                  ),
                )
              ],
            )
          ],
        );
      },
    );
  }
}
