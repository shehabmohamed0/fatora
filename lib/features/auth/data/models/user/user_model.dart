import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fatora/features/auth/domain/entities/user.dart';
import 'package:json_annotation/json_annotation.dart';
part 'user_model.g.dart';

@JsonSerializable()
class UserModel extends User {
  const UserModel({
    required String id,
    required String name,
    String? email,
    String? photoURL,
    required String phoneNumber,
  }) : super(
            id: id,
            name: name,
            photoURL: photoURL,
            email: email,
            phoneNumber: phoneNumber);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  static const empty = UserModel(id: '', name: '', phoneNumber: '');

  factory UserModel.fromFireStore(
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
    return _$UserModelFromJson(documentSnapshot.data()!)
        .copyWith(id: documentSnapshot.id) as UserModel;
  }
}
