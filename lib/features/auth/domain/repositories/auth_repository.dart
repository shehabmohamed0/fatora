import 'package:dartz/dartz.dart';
import 'package:fatora/core/errors/failures/failures.dart';
import 'package:fatora/core/params/auth/phone_sign_in_params.dart';
import 'package:fatora/core/params/auth/phone_sign_up_params.dart';
import 'package:fatora/core/params/auth/sign_in_params.dart';
import 'package:fatora/core/params/auth/full_sign_up_params.dart';
import 'package:fatora/core/params/auth/verify_phone_params.dart';
import 'package:fatora/features/auth/domain/entities/user.dart';

abstract class AuthRepository {
  Future<Either<Failure, void>> signInWithEmailAndPassword(SignInParams params);
  Future<Either<Failure, void>> signInWithGoogle();
  Future<Either<Failure, void>> signInWithPhone(PhoneSignInParams params);
  Future<Either<Failure, void>> fullSignUp(FullSignUpParams params);
  Future<Either<Failure, void>> phoneSignUp(PhoneSignUpParams params);
  Future<Either<Failure, void>> signInWithFacebook();
  Future<Either<Failure, void>> verifyPhone(VerifyPhoneParams params);

  User get currentUser;
  Stream<User> get user;
  Future<Either<Failure, void>> signOut();
}
