// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:cloud_firestore/cloud_firestore.dart' as _i6;
import 'package:cloud_functions/cloud_functions.dart' as _i7;
import 'package:firebase_auth/firebase_auth.dart' as _i5;
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart' as _i4;
import 'package:get_it/get_it.dart' as _i1;
import 'package:google_sign_in/google_sign_in.dart' as _i8;
import 'package:injectable/injectable.dart' as _i2;
import 'package:internet_connection_checker/internet_connection_checker.dart'
    as _i9;
import 'package:shared_preferences/shared_preferences.dart' as _i14;

import '../core/services/cache/cache_client.dart' as _i3;
import '../core/services/network/network_info.dart' as _i10;
import '../features/auth/data/datasources/local/auth_local_service.dart'
    as _i18;
import '../features/auth/data/datasources/remote/auth_api_service.dart' as _i17;
import '../features/settings/data/datasources/profile_api_service.dart'
    as _i11;
import '../features/auth/data/repositories/auth_repository_impl.dart' as _i20;
import '../features/settings/data/repositories/profile_repository_impl.dart'
    as _i13;
import '../features/auth/domain/repositories/auth_repository.dart' as _i19;
import '../features/settings/domain/repositories/profile_repository.dart' as _i12;
import '../features/auth/domain/usecases/link_email_and_password.dart' as _i21;
import '../features/auth/domain/usecases/log_out.dart' as _i24;
import '../features/auth/domain/usecases/phone_sign_up.dart' as _i22;
import '../features/auth/domain/usecases/sign_in_with_email_and_password.dart'
    as _i23;
import '../features/auth/domain/usecases/sign_in_with_facebook.dart' as _i25;
import '../features/auth/domain/usecases/sign_in_with_google.dart' as _i26;
import '../features/auth/domain/usecases/sign_in_with_phone.dart' as _i27;
import '../features/auth/domain/usecases/verify_phone_number.dart' as _i28;
import '../features/auth/presentation/bloc/app_status/app_bloc.dart' as _i29;
import '../features/auth/presentation/bloc/sign_in/phone/phone_sign_in_cubit.dart'
    as _i32;
import '../features/auth/presentation/bloc/sign_in/sign_in_cubit.dart' as _i33;
import '../features/auth/presentation/bloc/sign_up/complete_form/complete_form_cubit.dart'
    as _i30;
import '../features/auth/presentation/bloc/sign_up/flow_cubit/sign_up_flow_cubit.dart'
    as _i15;
import '../features/auth/presentation/bloc/sign_up/otp_cubit/otp_cubit.dart'
    as _i31;
import '../features/auth/presentation/bloc/sign_up/sign_up_form/sign_up_form_cubit.dart'
    as _i16;
import 'register_module.dart' as _i34; // ignore_for_file: unnecessary_lambdas

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
  gh.factory<_i7.FirebaseFunctions>(() => registerModule.cloudFunctions);
  gh.factory<_i8.GoogleSignIn>(() => registerModule.googleSignIn);
  gh.factory<_i9.InternetConnectionChecker>(
      () => registerModule.internetConnectionChecker);
  gh.lazySingleton<_i10.NetworkInfo>(
      () => _i10.NetworkInfoImpl(get<_i9.InternetConnectionChecker>()));
  gh.lazySingleton<_i11.ProfileApiService>(() => _i11.ProfileApiServiceImpl(
      get<_i5.FirebaseAuth>(), get<_i6.FirebaseFirestore>()));
  gh.lazySingleton<_i12.ProfileRepository>(
      () => _i13.ProfileRepositoryImpl(get<_i11.ProfileApiService>()));
  await gh.factoryAsync<_i14.SharedPreferences>(() => registerModule.prefs,
      preResolve: true);
  gh.factory<_i15.SignUpFlowCubit>(() => _i15.SignUpFlowCubit());
  gh.factory<_i16.SignUpFormCubit>(() => _i16.SignUpFormCubit());
  gh.lazySingleton<_i17.AuthApiService>(() => _i17.AuthApiServiceImpl(
      firebaseAuth: get<_i5.FirebaseAuth>(),
      googleSignIn: get<_i8.GoogleSignIn>(),
      facebookAuth: get<_i4.FacebookAuth>(),
      firestore: get<_i6.FirebaseFirestore>(),
      cloudFunctions: get<_i7.FirebaseFunctions>()));
  gh.lazySingleton<_i18.AuthLocalService>(
      () => _i18.AuthLocalServiceImpl(get<_i3.CacheClient>()));
  gh.lazySingleton<_i19.AuthRepository>(() => _i20.AuthRepositoryImpl(
      authApiService: get<_i17.AuthApiService>(),
      authLocalService: get<_i18.AuthLocalService>(),
      networkInfo: get<_i10.NetworkInfo>()));
  gh.lazySingleton<_i21.LinkEmailAndPassword>(
      () => _i21.LinkEmailAndPassword(get<_i19.AuthRepository>()));
  gh.lazySingleton<_i22.PhoneSignUp>(
      () => _i22.PhoneSignUp(get<_i19.AuthRepository>()));
  gh.lazySingleton<_i23.SignInWithEmailAndPassword>(
      () => _i23.SignInWithEmailAndPassword(get<_i19.AuthRepository>()));
  gh.lazySingleton<_i24.SignInWithEmailAndPassword>(
      () => _i24.SignInWithEmailAndPassword(get<_i19.AuthRepository>()));
  gh.lazySingleton<_i25.SignInWithFacebook>(
      () => _i25.SignInWithFacebook(get<_i19.AuthRepository>()));
  gh.lazySingleton<_i26.SignInWithGoogle>(
      () => _i26.SignInWithGoogle(get<_i19.AuthRepository>()));
  gh.lazySingleton<_i27.SignInWithPhone>(
      () => _i27.SignInWithPhone(get<_i19.AuthRepository>()));
  gh.lazySingleton<_i28.VerifyPhoneNumber>(
      () => _i28.VerifyPhoneNumber(get<_i19.AuthRepository>()));
  gh.factory<_i29.AppBloc>(
      () => _i29.AppBloc(authRepository: get<_i19.AuthRepository>()));
  gh.factory<_i30.CompleteFormCubit>(
      () => _i30.CompleteFormCubit(get<_i21.LinkEmailAndPassword>()));
  gh.factory<_i31.OTPCubit>(() => _i31.OTPCubit(
      verifyPhoneNumber: get<_i28.VerifyPhoneNumber>(),
      phoneSignUp: get<_i22.PhoneSignUp>()));
  gh.factory<_i32.PhoneSignInCubit>(() => _i32.PhoneSignInCubit(
      get<_i28.VerifyPhoneNumber>(), get<_i27.SignInWithPhone>()));
  gh.factory<_i33.SignInCubit>(() => _i33.SignInCubit(
      signInWithEmailAndPassword: get<_i23.SignInWithEmailAndPassword>(),
      signInWithGoogle: get<_i26.SignInWithGoogle>(),
      signInWithFacebook: get<_i25.SignInWithFacebook>()));
  return get;
}

class _$RegisterModule extends _i34.RegisterModule {}
