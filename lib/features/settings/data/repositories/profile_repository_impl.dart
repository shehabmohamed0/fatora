import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fatora/core/errors/failures/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:fatora/core/errors/failures/settings/update_phone_number_failure.dart';
import 'package:fatora/core/params/settings/update_phone_params.dart';
import 'package:fatora/core/params/settings/update_profile_params.dart';
import 'package:fatora/core/services/network/network_info.dart';
import 'package:fatora/features/settings/data/datasources/profile_api_service.dart';
import 'package:fatora/features/settings/domain/repositories/profile_repository.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ProfileRepository)
class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileApiService _profileApiService;
  final NetworkInfo _networkInfo;
  ProfileRepositoryImpl(this._profileApiService, this._networkInfo);

  @override
  Future<Either<Failure, void>> updateProfile(
      UpdateProfileParams params) async {
    try {
      if (!await _networkInfo.isConnected) {
        return Left(ServerFailure.internetConnection());
      }
      await _profileApiService.updateProfile(
        name: params.name,
        birthDate: params.birthDate,
        gender: params.gender,
      );

      return const Right(null);
    } on PlatformException catch (e) {
      log(e.code);
      log(e.message ?? 'No message provided');
      return Left(ServerFailure('firebase failure in update profile'));
    } on Exception catch (e) {
      log('${e.runtimeType}');
      return Left(ServerFailure('General failure in update profile'));
    }
  }

  @override
  Future<Either<Failure, void>> updatePhone(
      UpdatePhoneNumberParams params) async {
    if (!await _networkInfo.isConnected) {
      return Left(ServerFailure.internetConnection());
    }
    try {
      await _profileApiService.updatePhoneNumber(
          params.phoneNumber, params.phoneCredential);
      return const Right(null);
    } on FirebaseException catch (e) {
      log(e.code);
      return Left(UpdatePhoneNumberFailure.fromCode(e.code));
    } on Exception {
      return const Left(UpdatePhoneNumberFailure());
    }
  }
}
