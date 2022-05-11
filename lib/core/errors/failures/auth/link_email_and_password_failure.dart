import 'package:fatora/core/errors/failures/failures.dart';

class LinkEmailAndPasswordFailure implements Failure {
  final String message;

  /// {@macro link_email_and_password_failure}
  const LinkEmailAndPasswordFailure([
    this.message = 'An unknown exception occurred.',
  ]);

  /// Create an authentication message
  /// from a firebase authentication exception code.
  factory LinkEmailAndPasswordFailure.fromCode(String code) {
    switch (code) {
      case 'provider-already-linked':
        return const LinkEmailAndPasswordFailure(
          'The provider has already been linked to the user.',
        );
      case 'invalid-credential':
        return const LinkEmailAndPasswordFailure(
          'provider\'s credential is not valid.',
        );
      case 'credential-already-in-use':
        return const LinkEmailAndPasswordFailure(
          'credential already exists among your users.',
        );
      case 'invalid-email':
        return const LinkEmailAndPasswordFailure(
          'Email is not valid or badly formatted.',
        );
      case 'email-already-in-use':
        return const LinkEmailAndPasswordFailure(
          'An account already exists for that email.',
        );
      case 'operation-not-allowed':
        return const LinkEmailAndPasswordFailure(
          'Operation is not allowed.  Please contact support.',
        );
      case 'invalid-verification-code':
        return const LinkEmailAndPasswordFailure(
          'Verification code of the credential is not valid.',
        );
      case 'requires-recent-login':
        return const LinkEmailAndPasswordFailure(
          'Sign in first to apply these changes.',
        );
      case 'invalid-verification-id':
        return const LinkEmailAndPasswordFailure(
          'Verification ID of the credential is not valid.',
        );
      case 'weak-password':
        return const LinkEmailAndPasswordFailure(
          'Password is not strong enough.',
        );

      default:
        return const LinkEmailAndPasswordFailure();
    }
  }

  @override
  List<Object?> get props => [];

  @override
  bool? get stringify => true;
}
/*invalid-verification-id:
Thrown if the credential is a [PhoneAuthProvider.credential] and the verification ID of the credential is not valid.
 */