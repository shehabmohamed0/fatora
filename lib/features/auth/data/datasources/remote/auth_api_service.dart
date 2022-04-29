import 'package:fatora/features/auth/data/models/user/user_model.dart';
import 'package:fatora/features/auth/domain/entities/user.dart';
import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:fatora/core/extensions/to_user.dart';
import 'package:injectable/injectable.dart';

abstract class AuthApiService {
  Future<void> signInWithEmailAndPassword(String email, String password);
  Future<void> signUpWithEmailAndPassword(String email, String password);
  Stream<UserModel> get user;
  UserModel get currentUser;
  Future<void> signOut();
}

@LazySingleton(as: AuthApiService)
class AuthApiServiceImpl implements AuthApiService {
  FirebaseAuth firebaseAuth;
  AuthApiServiceImpl(this.firebaseAuth);

  @override
  Future<void> signInWithEmailAndPassword(String email, String password) async {
    await firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  @override
  Stream<UserModel> get user {
    return firebaseAuth.userChanges().map((user) {
      if (user == null) {
        return const UserModel(id: '');
      }
      return user.toUserModel();
    });
  }

  @override
  UserModel get currentUser {
    return firebaseAuth.currentUser.toUserModel();
  }

  @override
  Future<void> signUpWithEmailAndPassword(String email, String password) async {
    await firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  @override
  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }
}
