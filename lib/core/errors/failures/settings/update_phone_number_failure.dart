import 'package:fatora/core/errors/failures/failures.dart';

class UpdatePhoneNumberFailure implements Failure {
  final String message;
  const UpdatePhoneNumberFailure(
      [this.message = 'An unknown exception occurred.']);

  factory UpdatePhoneNumberFailure.fromCode(String code) {
    switch (code) {
      case 'invalid-verification-code':
        return const UpdatePhoneNumberFailure(
          'Verification code of the credential is not valid.',
        );
      case 'invalid-verification-id':
        return const UpdatePhoneNumberFailure(
          'Verification ID of the credential is not valid.',
        );
      case 'session-expired':
        return const UpdatePhoneNumberFailure(
          'Session expired.',
        );
      case 'credential-already-in-use':
        return const UpdatePhoneNumberFailure(
          'Phone number already in use.',
        );

      default:
        return const UpdatePhoneNumberFailure();
    }
  }
  @override
  List<Object?> get props => [message];

  @override
  bool? get stringify => true;
}
