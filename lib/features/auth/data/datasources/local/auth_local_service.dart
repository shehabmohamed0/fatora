import 'package:fatora/core/constants/local_keys.dart';
import 'package:fatora/core/errors/exceptions/exceptions.dart';
import 'package:fatora/core/services/cache/cache_client.dart';
import 'package:fatora/features/auth/data/models/user/user_model.dart';
import 'package:injectable/injectable.dart';

abstract class AuthLocalService {
  ///get Current signin user
  ///
  ///throw [CacheException] if there is no user
  UserModel currentUser();
  void saveCurrentUser(UserModel userModel);
  void removeUser(UserModel userModel);
}

@LazySingleton(as: AuthLocalService)
class AuthLocalServiceImpl implements AuthLocalService {
  final CacheClient _cacheClient;
  AuthLocalServiceImpl(this._cacheClient);

  @override
  UserModel currentUser() {
    final userModel = _cacheClient.read<UserModel>(key: 'user');
    if (userModel == null) {
      throw CacheException();
    }
    return userModel;
  }

  @override
  void saveCurrentUser(UserModel userModel) {
    _cacheClient.write<UserModel>(key: LocalKeys.currentUser, value: userModel);
  }

  @override
  void removeUser(UserModel userModel) {}
}
