import 'package:fatora/core/errors/failures/failures.dart';

class UpdateEmailFailure implements Failure {
  final String message;
  const UpdateEmailFailure([this.message = 'An unknown exception occurred.']);

  factory UpdateEmailFailure.fromCode(String code) {
    switch (code) {
      case 'user-mismatch':
        return const UpdateEmailFailure(
          'The email and password you entered does\'t belono to user.',
        );
      case 'user-not-found':
        return const UpdateEmailFailure(
          'The credential given does not correspond to any existing user.',
        );
      case 'invalid-email':
        return const UpdateEmailFailure(
          'The new email is invalid.',
        );
      case 'wrong-password':
        return const UpdateEmailFailure(
          'The password is not correct.',
        );
      case 'email-already-in-use':
        return const UpdateEmailFailure(
          'Email is already used by another user.',
        );
      case 'requires-recent-login':
        return const UpdateEmailFailure(
          'The user\'s last sign-in time does not meet the security threshold.',
        );
      case 'too-many-requests':
        return const UpdateEmailFailure(
          'Too many requests.',
        );

      default:
        return const UpdateEmailFailure();
    }
  }
  @override
  List<Object?> get props => [message];

  @override
  bool? get stringify => true;
}
