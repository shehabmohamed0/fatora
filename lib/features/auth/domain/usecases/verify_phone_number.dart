import 'package:fatora/core/errors/failures/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:fatora/core/params/auth/verify_phone_params.dart';
import 'package:fatora/core/usecase/usecase.dart';
import 'package:fatora/features/auth/domain/repositories/auth_repository.dart';
import 'package:injectable/injectable.dart';
@lazySingleton
class VerifyPhoneNumber extends UseCase<void, VerifyPhoneParams> {
  final AuthRepository _authRepository;
  VerifyPhoneNumber(this._authRepository);
  @override
  Future<Either<Failure, void>> call({required VerifyPhoneParams params}) {
    return _authRepository.verifyPhone(params);
  }
}
