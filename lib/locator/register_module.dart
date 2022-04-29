import 'package:firebase_auth/firebase_auth.dart';
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
}
