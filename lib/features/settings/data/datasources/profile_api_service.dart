import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fatora/core/constants/firestore_path.dart';
import 'package:fatora/features/auth/data/models/user/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:injectable/injectable.dart';

abstract class ProfileApiService {
  Future<UserModel> getUser();
}

@LazySingleton(as: ProfileApiService)
class ProfileApiServiceImpl implements ProfileApiService {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;
  ProfileApiServiceImpl(this.firebaseAuth, this.firestore);
  @override
  Future<UserModel> getUser() async {
    final userID = firebaseAuth.currentUser!.uid;
    final userRef = firestore.doc(FirestorePath.user(userID));
    final userDoc = await userRef.get();
    return UserModel.fromFireStore(userDoc);
  }
}
