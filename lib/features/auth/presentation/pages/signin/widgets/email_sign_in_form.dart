part of '../sign_in_page.dart';

class EmailSignInForm extends StatelessWidget {
  const EmailSignInForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EmailFormCubit, EmailFormState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(state.errorMessage ?? 'Authentication Failure'),
              ),
            );
        }
      },
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),
            Text(
              'Email',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 4),
            TextField(
              onChanged: context.read<EmailFormCubit>().emailChanged,
              decoration:
                  InputDecoration(errorText: state.email.validationMessage()),
            ),
            const SizedBox(height: 16),
            Text(
              'Password',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 4),
            PasswordTextField(
              onChanged: context.read<EmailFormCubit>().passwordChanged,
              errorText: state.password.validationMessage(),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: !state.status.isInvalid &&
                        !state.status.isSubmissionInProgress&& !state.status.isPure
                    ? context.read<EmailFormCubit>().signInWithEmailAndPassword
                    : null,
                child: state.status.isSubmissionInProgress
                    ? CircularProgressIndicator(
                        color: Theme.of(context).primaryColor,
                      )
                    : const Text(
                        'Login',
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
