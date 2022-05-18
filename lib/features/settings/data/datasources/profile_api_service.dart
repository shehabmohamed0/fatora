import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fatora/core/constants/firestore_path.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

abstract class ProfileApiService {
  Future<void> updateProfile(
      {String? name, DateTime? birthDate, String? gender});

  Future<void> updatePhoneNumber(
      String phoneNumber, PhoneAuthCredential phoneCredential);
}

@LazySingleton(as: ProfileApiService)
class ProfileApiServiceImpl implements ProfileApiService {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;
  ProfileApiServiceImpl(this.firebaseAuth, this.firestore);

  @override
  Future<void> updateProfile(
      {String? name, DateTime? birthDate, String? gender}) {
    final userId = firebaseAuth.currentUser!.uid;
    final userDoc = firestore.doc(FirestorePath.user(userId));
    return userDoc.update({
      'name': name,
      'birthDate': birthDate?.toIso8601String(),
      'gender': gender != null
          ? gender.isEmpty
              ? null
              : gender
          : null,
    });
  }

  @override
  Future<void> updatePhoneNumber(
      String phoneNumber, PhoneAuthCredential phoneCredential) async {
    final user = firebaseAuth.currentUser!;
    await user.updatePhoneNumber(phoneCredential);
    final userDoc = firestore.doc(FirestorePath.user(user.uid));
    userDoc.update({
      'phoneNumber': phoneNumber,
    });
  }
}
