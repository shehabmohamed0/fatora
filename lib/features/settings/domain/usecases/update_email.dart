import 'package:fatora/core/errors/failures/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:fatora/core/usecase/usecase.dart';
import 'package:fatora/features/settings/domain/repositories/profile_repository.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/params/settings/update_email.dart';
@lazySingleton
class UpdateEmail extends UseCase<void, UpdateEmailParams> {
  final ProfileRepository repository;
  UpdateEmail(this.repository);
  @override
  Future<Either<Failure, void>> call({required UpdateEmailParams params}) {

      return repository.updateEmail(params);
  }
}
