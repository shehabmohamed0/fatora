import 'package:fatora/core/errors/failures/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:fatora/core/params/auth/sign_in_params.dart';
import 'package:fatora/core/usecase/usecase.dart';
import 'package:fatora/features/auth/domain/repositories/auth_repository.dart';
import 'package:injectable/injectable.dart';
@LazySingleton()
class SignInWithEmailAndPassword implements UseCase<void, SignInParams> {
  final AuthRepository repository;
  SignInWithEmailAndPassword(this.repository);

  @override
  Future<Either<Failure, void>> call({required SignInParams params}) {
    return repository.signInWithEmailAndPassword(params);
  }
}
