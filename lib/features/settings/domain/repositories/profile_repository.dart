import 'package:fatora/features/auth/domain/entities/user.dart';

abstract class ProfileRepository {
  Future<User> getUserProfile();
}
