import 'package:fatora/core/errors/failures/failures.dart';

class SignInWithCredential implements Failure {
  /// The associated error message.
  final String message;

  /// {@macro log_in_with_google_failure}
  const SignInWithCredential([
    this.message = 'An unknown exception occurred.',
  ]);

  /// Create an authentication message
  /// from a firebase authentication exception code.
  factory SignInWithCredential.fromCode(String code) {
    switch (code) {
      case 'account-exists-with-different-credential':
        return const SignInWithCredential(
          'Account exists with different credentials.',
        );
      case 'invalid-credential':
        return const SignInWithCredential(
          'The credential received is malformed or has expired.',
        );
      case 'operation-not-allowed':
        return const SignInWithCredential(
          'Operation is not allowed.  Please contact support.',
        );
      case 'user-disabled':
        return const SignInWithCredential(
          'This user has been disabled. Please contact support for help.',
        );
      case 'user-not-found':
        return const SignInWithCredential(
          'Email is not found, please create an account.',
        );
      case 'wrong-password':
        return const SignInWithCredential(
          'Incorrect password, please try again.',
        );
      case 'invalid-verification-code':
        return const SignInWithCredential(
          'The credential verification code received is invalid.',
        );
      case 'invalid-verification-id':
        return const SignInWithCredential(
          'The credential verification ID received is invalid.',
        );
      default:
        return const SignInWithCredential();
    }
  }

  @override
  List<Object?> get props => [message];

  @override
  bool? get stringify => true;
}

class GoogleSignInWithGoogleCanceledFailure implements Failure {
  @override
  List<Object?> get props => [];

  @override
  bool? get stringify => true;
}
