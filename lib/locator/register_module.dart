import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

@module
abstract class RegisterModule {
  @preResolve
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();

  @injectable
  FirebaseAuth get auth => FirebaseAuth.instance;

  @injectable
  InternetConnectionChecker get internetConnectionChecker =>
      InternetConnectionChecker();

  @injectable
  GoogleSignIn get googleSignIn => GoogleSignIn();

  @injectable
  FacebookAuth get facebookSignIn => FacebookAuth.i;
  @injectable
  FirebaseFirestore get firestore => FirebaseFirestore.instance;
}
