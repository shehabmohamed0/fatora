import 'package:dartz/dartz.dart';
import 'package:fatora/core/errors/failures/failures.dart';
import 'package:fatora/core/params/auth/full_sign_up_params.dart';
import 'package:fatora/core/usecase/usecase.dart';
import 'package:fatora/features/auth/domain/repositories/auth_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class FullSignUp implements UseCase<void, FullSignUpParams> {
  final AuthRepository repository;
  FullSignUp(this.repository);

  @override
  Future<Either<Failure, void>> call({required FullSignUpParams params}) {
    return repository.fullSignUp(params);
  }
}
