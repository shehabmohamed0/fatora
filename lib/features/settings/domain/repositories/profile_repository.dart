import 'package:dartz/dartz.dart';
import 'package:fatora/core/errors/failures/failures.dart';
import 'package:fatora/core/params/settings/update_profile_params.dart';

abstract class ProfileRepository {
  Future<Either<Failure, void>> updateProfile(UpdateProfileParams params);
}
