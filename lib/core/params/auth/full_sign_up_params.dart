import 'package:firebase_auth/firebase_auth.dart';

class FullSignUpParams {
  final String name;
  final String email;
  final String password;
  final String phoneNumber;
  final AuthCredential phoneCredetial;
  FullSignUpParams(
      {required this.name,
      required this.email,
      required this.password,
      required this.phoneNumber,
      required this.phoneCredetial});
}
