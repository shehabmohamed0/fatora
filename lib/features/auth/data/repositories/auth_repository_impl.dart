import 'dart:developer';

import 'package:fatora/core/errors/failures/auth/sign_in_with_email_and_password_exception.dart';
import 'package:fatora/core/errors/failures/auth/sign_up_with_email_and_password_exception.dart';
import 'package:fatora/core/params/auth/google_sign_in_params.dart';
import 'package:fatora/core/services/network/network_info.dart';
import 'package:firebase_auth/firebase_auth.dart' hide User;

import 'package:fatora/core/errors/exceptions/exceptions.dart';
import 'package:fatora/features/auth/data/datasources/local/auth_local_service.dart';
import 'package:fatora/features/auth/data/datasources/remote/auth_api_service.dart';
import 'package:fatora/core/params/auth/sign_up_params.dart';
import 'package:fatora/core/params/auth/sign_in_params.dart';
import 'package:fatora/core/errors/failures/failures.dart';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  AuthApiService authApiService;
  AuthLocalService authLocalService;
  NetworkInfo networkInfo;

  AuthRepositoryImpl(
      {required this.authApiService,
      required this.authLocalService,
      required this.networkInfo});

  @override
  Either<Failure, User> getCurrentUserUser() {
    try {
      final user = authLocalService.currentUser();
      return Right(user);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      await authApiService.signOut();
      return const Right(null);
    } on Exception {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, void>> signInWithEmailAndPassword(
      SignInParams params) async {
    try {
      await authApiService.signInWithEmailAndPassword(
          params.email, params.password);
      return const Right(null);
    } on FirebaseAuthException catch (e) {
      return Left(SignInWithEmailAndPasswordFailure(e.code));
    } on Exception {
      return const Left(SignInWithEmailAndPasswordFailure());
    }
  }

  @override
  Future<Either<Failure, void>> signUpWithEmailAndPassword(
      SignUpParams params) async {
    try {
      await authApiService.signUpWithEmailAndPassword(
          params.email, params.password);
      return const Right(null);
    } on FirebaseAuthException catch (e) {
      log('${e.message}');
      return Left(SignUpWithEmailAndPasswordFailure(e.code));
    }
  }

  @override
  Stream<User> get user => authApiService.user;

  @override
  User get currentUser => authApiService.currentUser;

  @override
  Future<Either<Failure, void>> signInWithGoogle(GoogleSignInParams params) async {
    throw UnimplementedError();
  }
}
