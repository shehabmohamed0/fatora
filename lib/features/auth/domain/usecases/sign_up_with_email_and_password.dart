import 'package:dartz/dartz.dart';
import 'package:fatora/core/errors/failures/failures.dart';
import 'package:fatora/core/params/auth/sign_up_params.dart';
import 'package:fatora/core/usecase/usecase.dart';
import 'package:fatora/features/auth/domain/repositories/auth_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class SignUpWithEmailAndPassword implements UseCase<void, SignUpParams> {
  final AuthRepository repository;
  SignUpWithEmailAndPassword(this.repository);

  @override
  Future<Either<Failure, void>> call({required SignUpParams params}) {
    return repository.signUpWithEmailAndPassword(params);
  }
}
