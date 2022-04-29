import 'package:fatora/core/errors/failures/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:fatora/core/params/auth/google_sign_in_params.dart';
import 'package:fatora/core/usecase/usecase.dart';
import 'package:fatora/features/auth/domain/repositories/auth_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class SignInWithGoogle implements UseCase<void, GoogleSignInParams> {
  final AuthRepository repository;
  SignInWithGoogle(this.repository);

  @override
  Future<Either<Failure, void>> call({required GoogleSignInParams params}) {
    return repository.signInWithGoogle(params);
  }
}
