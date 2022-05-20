import 'package:fatora/core/errors/failures/failures.dart';

class ReAuthenticateUserFailure extends Failure {
  final message = 'This action requires recent login';
}
