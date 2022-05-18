import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:fatora/core/errors/exceptions/auth/google_sign_in_exceptions.dart';
import 'package:fatora/core/errors/failures/auth/link_email_and_password_failure.dart';
import 'package:fatora/core/errors/failures/auth/sign_in_with_email_and_password_exception.dart';
import 'package:fatora/core/errors/failures/auth/sign_in_with_credential_failure.dart';
import 'package:fatora/core/params/auth/link_email_and_password_params.dart';
import 'package:fatora/core/params/auth/phone_sign_in_params.dart';
import 'package:fatora/core/params/auth/phone_sign_up_params.dart';
import 'package:fatora/core/params/auth/verify_phone_params.dart';
import 'package:fatora/core/services/network/network_info.dart';
import 'package:firebase_auth/firebase_auth.dart' hide User;

import 'package:fatora/features/auth/data/datasources/local/auth_local_service.dart';
import 'package:fatora/features/auth/data/datasources/remote/auth_api_service.dart';
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
  Future<Either<Failure, void>> signOut() async {
    try {
      await authApiService.signOut();
      return const Right(null);
    } on Exception catch (e) {
      log(e.toString());
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, void>> signInWithEmailAndPassword(
      SignInParams params) async {
    if (!await networkInfo.isConnected) {
      return Left(ServerFailure.internetConnection());
    }
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
  Future<Either<Failure, void>> phoneSignUp(PhoneSignUpParams params) async {
    if (!await networkInfo.isConnected) {
      return Left(ServerFailure.internetConnection());
    }
    try {
      await authApiService.phoneSignUp(
        name: params.name,
        phoneNumber: params.phoneNumber,
        phoneCredential: params.phoneCredential,
      );
      return const Right(null);
    } on FirebaseAuthException catch (e) {
      return Left(SignInWithCredentialFailure(e.code));
    }
  }

  @override
  Future<Either<Failure, void>> signInWithGoogle() async {
    try {
      await authApiService.signInWithGoogle();
      return const Right(null);
    } on FirebaseAuthException catch (e) {
      return Left(SignInWithCredentialFailure.fromCode(e.code));
    } on GoogleSignInCanceledException {
      return Left(GoogleSignInWithGoogleCanceledFailure());
    } catch (_) {
      log(_.toString());

      return const Left(SignInWithCredentialFailure());
    }
  }

  @override
  Stream<User> get user => authApiService.user;

  @override
  User get currentUser => authApiService.currentUser;

  @override
  Future<Either<Failure, void>> signInWithFacebook() async {
    try {
      await authApiService.signInWithFacebook();
      return const Right(null);
    } on FirebaseAuthException catch (e) {
      return Left(SignInWithCredentialFailure.fromCode(e.code));
    } on GoogleSignInCanceledException {
      return Left(GoogleSignInWithGoogleCanceledFailure());
    } catch (_) {
      log(_.toString());
      return const Left(SignInWithCredentialFailure());
    }
  }

  @override
  Future<Either<Failure, void>> signInWithPhone(
      PhoneSignInParams params) async {
    if (!await networkInfo.isConnected) {
      return Left(ServerFailure.internetConnection());
    }
    try {
      await authApiService
          .signInWithPhoneCredential(params.phoneAuthCredential);
      return const Right(null);
    } on FirebaseAuthException catch (e) {
      log(e.code);
      return Left(SignInWithCredentialFailure.fromCode(e.code));
    } on Exception {
      return const Left(SignInWithCredentialFailure());
    }
  }

  @override
  Future<Either<Failure, void>> verifyPhone(VerifyPhoneParams params) async {
    if (!await networkInfo.isConnected) {
      return Left(ServerFailure.internetConnection());
    }
    try {
      await authApiService.verifyPhone(
          phoneNumber: params.phoneNumber,
          verificationCompleted: params.verificationCompleted,
          verificationFailed: params.verificationFailed,
          codeSent: params.codeSent,
          codeAutoRetrievalTimeout: params.codeAutoRetrievalTimeout);

      return const Right(null);
    } on FirebaseAuthException catch (e) {
      log(e.code);
      return Left(ServerFailure('Firebase failure verifiy phone'));
    } on Exception catch (e) {
      log(e.toString());
      return Left(ServerFailure('general exception verifiy phone'));
    }
  }

  @override
  Future<Either<Failure, void>> linkeEmailAndPassword(
      LinkEmailAndPasswordParams params) async {
    try {
      await authApiService.linkEmailAndPassword(params.email, params.password);
      return const Right(null);
    } on FirebaseAuthException catch (e) {
      return Left(LinkEmailAndPasswordFailure.fromCode(e.code));
    } on Exception catch (e) {
      log(e.toString());
      return const Left(LinkEmailAndPasswordFailure());
    }
  }
}
