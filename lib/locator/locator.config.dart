// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:cloud_firestore/cloud_firestore.dart' as _i6;
import 'package:firebase_auth/firebase_auth.dart' as _i5;
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart' as _i4;
import 'package:get_it/get_it.dart' as _i1;
import 'package:google_sign_in/google_sign_in.dart' as _i7;
import 'package:injectable/injectable.dart' as _i2;
import 'package:internet_connection_checker/internet_connection_checker.dart'
    as _i8;
import 'package:shared_preferences/shared_preferences.dart' as _i10;

import '../core/services/cache/cache_client.dart' as _i3;
import '../core/services/network/network_info.dart' as _i9;
import '../features/auth/data/datasources/local/auth_local_service.dart'
    as _i12;
import '../features/auth/data/datasources/remote/auth_api_service.dart' as _i11;
import '../features/auth/data/repositories/auth_repository_impl.dart' as _i14;
import '../features/auth/domain/repositories/auth_repository.dart' as _i13;
import '../features/auth/domain/usecases/log_out.dart' as _i16;
import '../features/auth/domain/usecases/sign_in_with_email_and_password.dart'
    as _i15;
import '../features/auth/domain/usecases/sign_in_with_facebook.dart' as _i17;
import '../features/auth/domain/usecases/sign_in_with_google.dart' as _i18;
import '../features/auth/domain/usecases/sign_up.dart' as _i19;
import '../features/auth/presentation/bloc/app_status/app_bloc.dart' as _i21;
import '../features/auth/presentation/bloc/sign_in/sign_in_cubit.dart' as _i22;
import '../features/auth/presentation/bloc/sign_up/sign_up_cubit.dart' as _i20;
import 'register_module.dart' as _i23; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
Future<_i1.GetIt> $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) async {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final registerModule = _$RegisterModule();
  gh.lazySingleton<_i3.CacheClient>(() => _i3.CacheClient());
  gh.factory<_i4.FacebookAuth>(() => registerModule.facebookSignIn);
  gh.factory<_i5.FirebaseAuth>(() => registerModule.auth);
  gh.factory<_i6.FirebaseFirestore>(() => registerModule.firestore);
  gh.factory<_i7.GoogleSignIn>(() => registerModule.googleSignIn);
  gh.factory<_i8.InternetConnectionChecker>(
      () => registerModule.internetConnectionChecker);
  gh.lazySingleton<_i9.NetworkInfo>(
      () => _i9.NetworkInfoImpl(get<_i8.InternetConnectionChecker>()));
  await gh.factoryAsync<_i10.SharedPreferences>(() => registerModule.prefs,
      preResolve: true);
  gh.lazySingleton<_i11.AuthApiService>(() => _i11.AuthApiServiceImpl(
      firebaseAuth: get<_i5.FirebaseAuth>(),
      googleSignIn: get<_i7.GoogleSignIn>(),
      facebookAuth: get<_i4.FacebookAuth>(),
      firestore: get<_i6.FirebaseFirestore>()));
  gh.lazySingleton<_i12.AuthLocalService>(
      () => _i12.AuthLocalServiceImpl(get<_i3.CacheClient>()));
  gh.lazySingleton<_i13.AuthRepository>(() => _i14.AuthRepositoryImpl(
      authApiService: get<_i11.AuthApiService>(),
      authLocalService: get<_i12.AuthLocalService>(),
      networkInfo: get<_i9.NetworkInfo>()));
  gh.lazySingleton<_i15.SignInWithEmailAndPassword>(
      () => _i15.SignInWithEmailAndPassword(get<_i13.AuthRepository>()));
  gh.lazySingleton<_i16.SignInWithEmailAndPassword>(
      () => _i16.SignInWithEmailAndPassword(get<_i13.AuthRepository>()));
  gh.lazySingleton<_i17.SignInWithFacebook>(
      () => _i17.SignInWithFacebook(get<_i13.AuthRepository>()));
  gh.lazySingleton<_i18.SignInWithGoogle>(
      () => _i18.SignInWithGoogle(get<_i13.AuthRepository>()));
  gh.lazySingleton<_i19.SignUp>(() => _i19.SignUp(get<_i13.AuthRepository>()));
  gh.factory<_i20.SignUpCubit>(() => _i20.SignUpCubit(get<_i19.SignUp>()));
  gh.factory<_i21.AppBloc>(
      () => _i21.AppBloc(authRepository: get<_i13.AuthRepository>()));
  gh.factory<_i22.SignInCubit>(() => _i22.SignInCubit(
      signInWithEmailAndPassword: get<_i15.SignInWithEmailAndPassword>(),
      signInWithGoogle: get<_i18.SignInWithGoogle>(),
      signInWithFacebook: get<_i17.SignInWithFacebook>()));
  return get;
}

class _$RegisterModule extends _i23.RegisterModule {}
