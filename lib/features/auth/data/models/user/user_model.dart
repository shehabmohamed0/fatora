import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fatora/features/auth/domain/entities/user.dart';
import 'package:json_annotation/json_annotation.dart';
part 'user_model.g.dart';

@JsonSerializable()
class UserModel extends User {
  const UserModel({
    required String id,
    String? name,
    String? email,
    String? photoURL,
  }) : super(id: id, name: name, photoURL: photoURL, email: email);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  factory UserModel.fromFireStore(
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
    return _$UserModelFromJson(documentSnapshot.data()!)
        .copyWith(id: documentSnapshot.id) as UserModel;
  }

  
}
