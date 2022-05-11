import 'package:fatora/core/errors/failures/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:fatora/core/params/auth/link_email_and_password_params.dart';
import 'package:fatora/core/usecase/usecase.dart';
import 'package:fatora/features/auth/domain/repositories/auth_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class LinkEmailAndPassword extends UseCase<void, LinkEmailAndPasswordParams> {
  final AuthRepository _authRepository;
  LinkEmailAndPassword(this._authRepository);
  @override
  Future<Either<Failure, void>> call(
      {required LinkEmailAndPasswordParams params}) {
    return _authRepository.linkeEmailAndPassword(params);
  }
}
