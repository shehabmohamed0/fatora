import 'package:dartz/dartz.dart';
import 'package:fatora/core/errors/failures/failures.dart';
import 'package:fatora/core/params/settings/update_phone_params.dart';
import 'package:fatora/features/settings/domain/repositories/profile_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:fatora/core/usecase/usecase.dart';

@lazySingleton
class UpdatePhoneNumber extends UseCase<void, UpdatePhoneNumberParams> {
  final ProfileRepository _profileRepository;
  UpdatePhoneNumber(this._profileRepository);
  @override
  Future<Either<Failure, void>> call({required UpdatePhoneNumberParams params}) {
    return _profileRepository.updatePhone(params);
  }
}
