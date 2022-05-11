import 'package:fatora/core/errors/failures/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:fatora/core/params/auth/phone_sign_in_params.dart';
import 'package:fatora/core/usecase/usecase.dart';
import 'package:fatora/features/auth/domain/repositories/auth_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SignInWithPhone extends UseCase<void, PhoneSignInParams> {
  final AuthRepository authRepository;
  SignInWithPhone(this.authRepository);
  @override
  Future<Either<Failure, void>> call({required PhoneSignInParams params}) {
    return authRepository.signInWithPhone(params);
  }
}
