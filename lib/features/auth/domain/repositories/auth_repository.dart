import 'package:dartz/dartz.dart';
import 'package:fatora/core/errors/failures/failures.dart';
import 'package:fatora/core/params/auth/google_sign_in_params.dart';
import 'package:fatora/core/params/auth/sign_in_params.dart';
import 'package:fatora/core/params/auth/sign_up_params.dart';
import 'package:fatora/features/auth/domain/entities/user.dart';

abstract class AuthRepository {
  Future<Either<Failure, void>> signInWithEmailAndPassword(SignInParams params);
  Future<Either<Failure, void>> signInWithGoogle(GoogleSignInParams params);
  Future<Either<Failure, void>> signUpWithEmailAndPassword(SignUpParams params);
  User get currentUser;
  Stream<User> get user;
  Future<Either<Failure, void>> signOut();
}
