// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:cloud_firestore/cloud_firestore.dart' as _i7;
import 'package:firebase_auth/firebase_auth.dart' as _i6;
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart' as _i5;
import 'package:get_it/get_it.dart' as _i1;
import 'package:google_sign_in/google_sign_in.dart' as _i8;
import 'package:injectable/injectable.dart' as _i2;
import 'package:internet_connection_checker/internet_connection_checker.dart'
    as _i9;
import 'package:shared_preferences/shared_preferences.dart' as _i11;

import '../core/services/cache/cache_client.dart' as _i3;
import '../core/services/network/network_info.dart' as _i10;
import '../features/auth/data/datasources/local/auth_local_service.dart'
    as _i14;
import '../features/auth/data/datasources/remote/auth_api_service.dart' as _i13;
import '../features/auth/data/repositories/auth_repository_impl.dart' as _i16;
import '../features/auth/domain/repositories/auth_repository.dart' as _i15;
import '../features/auth/domain/usecases/full_sign_up.dart' as _i17;
import '../features/auth/domain/usecases/log_out.dart' as _i20;
import '../features/auth/domain/usecases/phone_sign_up.dart' as _i18;
import '../features/auth/domain/usecases/sign_in_with_email_and_password.dart'
    as _i19;
import '../features/auth/domain/usecases/sign_in_with_facebook.dart' as _i21;
import '../features/auth/domain/usecases/sign_in_with_google.dart' as _i22;
import '../features/auth/domain/usecases/verify_phone_number.dart' as _i24;
import '../features/auth/presentation/bloc/app_status/app_bloc.dart' as _i25;
import '../features/auth/presentation/bloc/sign_in/sign_in_cubit.dart' as _i27;
import '../features/auth/presentation/bloc/sign_up/complete_form/complete_form_cubit.dart'
    as _i4;
import '../features/auth/presentation/bloc/sign_up/flow_cubit/sign_up_flow_cubit.dart'
    as _i12;
import '../features/auth/presentation/bloc/sign_up/otp_cubit/otp_cubit.dart'
    as _i26;
import '../features/auth/presentation/bloc/sign_up/sign_up_form/sign_up_form_cubit.dart'
    as _i23;
import 'register_module.dart' as _i28; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
Future<_i1.GetIt> $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) async {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final registerModule = _$RegisterModule();
  gh.lazySingleton<_i3.CacheClient>(() => _i3.CacheClient());
  gh.factory<_i4.CompleteFormCubit>(() => _i4.CompleteFormCubit());
  gh.factory<_i5.FacebookAuth>(() => registerModule.facebookSignIn);
  gh.factory<_i6.FirebaseAuth>(() => registerModule.auth);
  gh.factory<_i7.FirebaseFirestore>(() => registerModule.firestore);
  gh.factory<_i8.GoogleSignIn>(() => registerModule.googleSignIn);
  gh.factory<_i9.InternetConnectionChecker>(
      () => registerModule.internetConnectionChecker);
  gh.lazySingleton<_i10.NetworkInfo>(
      () => _i10.NetworkInfoImpl(get<_i9.InternetConnectionChecker>()));
  await gh.factoryAsync<_i11.SharedPreferences>(() => registerModule.prefs,
      preResolve: true);
  gh.factory<_i12.SignUpFlowCubit>(() => _i12.SignUpFlowCubit());
  gh.lazySingleton<_i13.AuthApiService>(() => _i13.AuthApiServiceImpl(
      firebaseAuth: get<_i6.FirebaseAuth>(),
      googleSignIn: get<_i8.GoogleSignIn>(),
      facebookAuth: get<_i5.FacebookAuth>(),
      firestore: get<_i7.FirebaseFirestore>()));
  gh.lazySingleton<_i14.AuthLocalService>(
      () => _i14.AuthLocalServiceImpl(get<_i3.CacheClient>()));
  gh.lazySingleton<_i15.AuthRepository>(() => _i16.AuthRepositoryImpl(
      authApiService: get<_i13.AuthApiService>(),
      authLocalService: get<_i14.AuthLocalService>(),
      networkInfo: get<_i10.NetworkInfo>()));
  gh.lazySingleton<_i17.FullSignUp>(
      () => _i17.FullSignUp(get<_i15.AuthRepository>()));
  gh.lazySingleton<_i18.PhoneSignUp>(
      () => _i18.PhoneSignUp(get<_i15.AuthRepository>()));
  gh.lazySingleton<_i19.SignInWithEmailAndPassword>(
      () => _i19.SignInWithEmailAndPassword(get<_i15.AuthRepository>()));
  gh.lazySingleton<_i20.SignInWithEmailAndPassword>(
      () => _i20.SignInWithEmailAndPassword(get<_i15.AuthRepository>()));
  gh.lazySingleton<_i21.SignInWithFacebook>(
      () => _i21.SignInWithFacebook(get<_i15.AuthRepository>()));
  gh.lazySingleton<_i22.SignInWithGoogle>(
      () => _i22.SignInWithGoogle(get<_i15.AuthRepository>()));
  gh.factory<_i23.SignUpFormCubit>(() =>
      _i23.SignUpFormCubit(get<_i17.FullSignUp>(), get<_i18.PhoneSignUp>()));
  gh.lazySingleton<_i24.VerifyPhoneNumber>(
      () => _i24.VerifyPhoneNumber(get<_i15.AuthRepository>()));
  gh.factory<_i25.AppBloc>(
      () => _i25.AppBloc(authRepository: get<_i15.AuthRepository>()));
  gh.factory<_i26.OTPCubit>(() => _i26.OTPCubit(
      verifyPhoneNumber: get<_i24.VerifyPhoneNumber>(),
      phoneSignUp: get<_i18.PhoneSignUp>()));
  gh.factory<_i27.SignInCubit>(() => _i27.SignInCubit(
      signInWithEmailAndPassword: get<_i19.SignInWithEmailAndPassword>(),
      signInWithGoogle: get<_i22.SignInWithGoogle>(),
      signInWithFacebook: get<_i21.SignInWithFacebook>()));
  return get;
}

class _$RegisterModule extends _i28.RegisterModule {}
