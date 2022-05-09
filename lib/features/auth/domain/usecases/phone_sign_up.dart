import 'package:fatora/core/errors/failures/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:fatora/core/params/auth/phone_sign_up_params.dart';
import 'package:fatora/core/usecase/usecase.dart';
import 'package:fatora/features/auth/domain/repositories/auth_repository.dart';
import 'package:injectable/injectable.dart';
@lazySingleton
class PhoneSignUp implements UseCase<void, PhoneSignUpParams> {
  final AuthRepository authRepository;

  PhoneSignUp(this.authRepository);
  @override
  Future<Either<Failure, void>> call({required PhoneSignUpParams params}) {
    return authRepository.phoneSignUp(params);
  }
}
