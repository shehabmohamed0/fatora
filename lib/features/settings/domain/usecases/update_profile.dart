import 'package:fatora/core/errors/failures/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:fatora/core/params/settings/update_profile_params.dart';
import 'package:fatora/core/usecase/usecase.dart';
import 'package:fatora/features/settings/domain/repositories/profile_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class UpdateProfile extends UseCase<void, UpdateProfileParams> {
  final ProfileRepository _profileRepository;
  UpdateProfile(this._profileRepository);
  @override
  Future<Either<Failure, void>> call({required UpdateProfileParams params}) {
    return _profileRepository.updateProfile(params);
  }
}
