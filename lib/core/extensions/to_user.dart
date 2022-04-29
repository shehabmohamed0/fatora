import 'package:fatora/features/auth/data/models/user/user_model.dart';
import 'package:fatora/features/auth/domain/entities/user.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

extension UserExtention on auth.User? {
  UserModel toUserModel() {
    final user = this;
    if (user != null) {
      return UserModel(
          id: user.uid,
          name: user.displayName,
          email: user.email,
          photoURL: user.photoURL);
    } else {
      return UserModel(id: '');
    }
  }
}
