import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fatora/core/errors/exceptions/auth/google_sign_in_exceptions.dart';
import 'package:fatora/features/auth/data/models/user/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:fatora/core/extensions/to_user.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';

abstract class AuthApiService {
  Future<void> signInWithEmailAndPassword(String email, String password);
  Future<void> signInWithGoogle();
  Future<void> signInWithFacebook();
  Future<void> signUpWithEmailAndPassword(String email, String password);
  Stream<UserModel> get user;
  UserModel get currentUser;
  Future<void> signOut();
}

@LazySingleton(as: AuthApiService)
class AuthApiServiceImpl implements AuthApiService {
  FirebaseAuth firebaseAuth;
  GoogleSignIn googleSignIn;
  FacebookAuth facebookAuth;
  FirebaseFirestore firestore;
  AuthApiServiceImpl({
    required this.firebaseAuth,
    required this.googleSignIn,
    required this.facebookAuth,
    required this.firestore,
  });

  @override
  Future<void> signInWithEmailAndPassword(String email, String password) async {
    await firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  @override
  Future<void> signInWithGoogle() async {
    final googleUser = await googleSignIn.signIn();
    if (googleUser == null) {
      throw GoogleSignInCanceledException();
    }
    final googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    await firebaseAuth.signInWithCredential(credential);
  }

  @override
  Stream<UserModel> get user {
    return firebaseAuth.userChanges().map((user) {
      if (user == null) {
        return UserModel.empty;
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
    await Future.wait([
      firebaseAuth.signOut(),
      googleSignIn.signOut(),
      facebookAuth.logOut()
    ]);
  }

  @override
  Future<void> signInWithFacebook() async {
    final LoginResult response = await facebookAuth.login();
    if (response.status == LoginStatus.success) {
      // you are logged
      final AccessToken accessToken = response.accessToken!;
      final credential = FacebookAuthProvider.credential(accessToken.token);
      await firebaseAuth.signInWithCredential(credential);
    }
  }
}
