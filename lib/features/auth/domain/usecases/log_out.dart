import 'package:fatora/core/errors/failures/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:fatora/core/params/no_args_params.dart';
import 'package:fatora/core/usecase/usecase.dart';
import 'package:fatora/features/auth/domain/repositories/auth_repository.dart';
import 'package:injectable/injectable.dart';
@LazySingleton()
class SignInWithEmailAndPassword implements UseCase<void, NoArgsParams> {
  final AuthRepository repository;
  SignInWithEmailAndPassword(this.repository);

  @override
  Future<Either<Failure, void>> call({required NoArgsParams params}) {
    return repository.signOut();
  }
}
