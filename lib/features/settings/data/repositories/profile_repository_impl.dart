import 'package:fatora/features/settings/data/datasources/profile_api_service.dart';
import 'package:fatora/features/auth/domain/entities/user.dart';
import 'package:fatora/features/settings/domain/repositories/profile_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ProfileRepository)
class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileApiService _profileApiService;

  ProfileRepositoryImpl(this._profileApiService);
  @override
  Future<User> getUserProfile() async {
    return await _profileApiService.getUser();
  }
}
