// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:cloud_firestore/cloud_firestore.dart' as _i7;
import 'package:cloud_functions/cloud_functions.dart' as _i8;
import 'package:firebase_auth/firebase_auth.dart' as _i6;
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart' as _i5;
import 'package:get_it/get_it.dart' as _i1;
import 'package:google_sign_in/google_sign_in.dart' as _i9;
import 'package:injectable/injectable.dart' as _i2;
import 'package:internet_connection_checker/internet_connection_checker.dart'
    as _i10;
import 'package:shared_preferences/shared_preferences.dart' as _i16;
import 'package:sms_autofill/sms_autofill.dart' as _i19;

import '../core/services/cache/cache_client.dart' as _i4;
import '../core/services/network/network_info.dart' as _i12;
import '../features/auth/data/datasources/local/auth_local_service.dart'
    as _i24;
import '../features/auth/data/datasources/remote/auth_api_service.dart' as _i23;
import '../features/auth/data/repositories/auth_repository_impl.dart' as _i26;
import '../features/auth/domain/repositories/auth_repository.dart' as _i25;
import '../features/auth/domain/usecases/link_email_and_password.dart' as _i27;
import '../features/auth/domain/usecases/log_out.dart' as _i30;
import '../features/auth/domain/usecases/phone_sign_up.dart' as _i28;
import '../features/auth/domain/usecases/sign_in_with_email_and_password.dart'
    as _i29;
import '../features/auth/domain/usecases/sign_in_with_facebook.dart' as _i31;
import '../features/auth/domain/usecases/sign_in_with_google.dart' as _i32;
import '../features/auth/domain/usecases/sign_in_with_phone.dart' as _i33;
import '../features/auth/domain/usecases/verify_phone_number.dart' as _i35;
import '../features/auth/presentation/bloc/app_status/app_bloc.dart' as _i36;
import '../features/auth/presentation/bloc/sign_in/email_form/email_form_cubit.dart'
    as _i39;
import '../features/auth/presentation/bloc/sign_in/login_form_selection/login_form_selection_cubit.dart'
    as _i11;
import '../features/auth/presentation/bloc/sign_in/phone/phone_sign_in_cubit.dart'
    as _i42;
import '../features/auth/presentation/bloc/sign_in/phone_form/phone_form_cubit.dart'
    as _i41;
import '../features/auth/presentation/bloc/sign_up/complete_form/complete_form_cubit.dart'
    as _i38;
import '../features/auth/presentation/bloc/sign_up/flow_cubit/sign_up_flow_cubit.dart'
    as _i17;
import '../features/auth/presentation/bloc/sign_up/otp_cubit/otp_cubit.dart'
    as _i40;
import '../features/auth/presentation/bloc/sign_up/sign_up_form/sign_up_form_cubit.dart'
    as _i18;
import '../features/auth/presentation/bloc/verifiy_phone/verifiy_phone_cubit.dart'
    as _i34;
import '../features/settings/data/datasources/profile_api_service.dart' as _i13;
import '../features/settings/data/repositories/profile_repository_impl.dart'
    as _i15;
import '../features/settings/domain/repositories/profile_repository.dart'
    as _i14;
import '../features/settings/domain/usecases/update_phone_number.dart' as _i20;
import '../features/settings/domain/usecases/update_profile.dart' as _i21;
import '../features/settings/presentation/bloc/account_info/account_info_cubit.dart'
    as _i22;
import '../features/settings/presentation/bloc/add_email/add_email_cubit.dart'
    as _i3;
import '../features/settings/presentation/bloc/change_phone/change_phone_cubit.dart'
    as _i37;
import 'register_module.dart' as _i43; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
Future<_i1.GetIt> $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) async {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final registerModule = _$RegisterModule();
  gh.factory<_i3.AddEmailCubit>(() => _i3.AddEmailCubit());
  gh.lazySingleton<_i4.CacheClient>(() => _i4.CacheClient());
  gh.factory<_i5.FacebookAuth>(() => registerModule.facebookSignIn);
  gh.factory<_i6.FirebaseAuth>(() => registerModule.auth);
  gh.factory<_i7.FirebaseFirestore>(() => registerModule.firestore);
  gh.factory<_i8.FirebaseFunctions>(() => registerModule.cloudFunctions);
  gh.factory<_i9.GoogleSignIn>(() => registerModule.googleSignIn);
  gh.factory<_i10.InternetConnectionChecker>(
      () => registerModule.internetConnectionChecker);
  gh.factory<_i11.LoginFormSelectionCubit>(
      () => _i11.LoginFormSelectionCubit());
  gh.lazySingleton<_i12.NetworkInfo>(
      () => _i12.NetworkInfoImpl(get<_i10.InternetConnectionChecker>()));
  gh.lazySingleton<_i13.ProfileApiService>(() => _i13.ProfileApiServiceImpl(
      get<_i6.FirebaseAuth>(), get<_i7.FirebaseFirestore>()));
  gh.lazySingleton<_i14.ProfileRepository>(() => _i15.ProfileRepositoryImpl(
      get<_i13.ProfileApiService>(), get<_i12.NetworkInfo>()));
  await gh.factoryAsync<_i16.SharedPreferences>(() => registerModule.prefs,
      preResolve: true);
  gh.factory<_i17.SignUpFlowCubit>(() => _i17.SignUpFlowCubit());
  gh.factory<_i18.SignUpFormCubit>(() => _i18.SignUpFormCubit());
  gh.factory<_i19.SmsAutoFill>(() => registerModule.smsAutoFill);
  gh.lazySingleton<_i20.UpdatePhoneNumber>(
      () => _i20.UpdatePhoneNumber(get<_i14.ProfileRepository>()));
  gh.lazySingleton<_i21.UpdateProfile>(
      () => _i21.UpdateProfile(get<_i14.ProfileRepository>()));
  gh.factory<_i22.AccountInfoCubit>(
      () => _i22.AccountInfoCubit(get<_i21.UpdateProfile>()));
  gh.lazySingleton<_i23.AuthApiService>(() => _i23.AuthApiServiceImpl(
      firebaseAuth: get<_i6.FirebaseAuth>(),
      googleSignIn: get<_i9.GoogleSignIn>(),
      facebookAuth: get<_i5.FacebookAuth>(),
      firestore: get<_i7.FirebaseFirestore>(),
      cloudFunctions: get<_i8.FirebaseFunctions>()));
  gh.lazySingleton<_i24.AuthLocalService>(
      () => _i24.AuthLocalServiceImpl(get<_i4.CacheClient>()));
  gh.lazySingleton<_i25.AuthRepository>(() => _i26.AuthRepositoryImpl(
      authApiService: get<_i23.AuthApiService>(),
      authLocalService: get<_i24.AuthLocalService>(),
      networkInfo: get<_i12.NetworkInfo>()));
  gh.lazySingleton<_i27.LinkEmailAndPassword>(
      () => _i27.LinkEmailAndPassword(get<_i25.AuthRepository>()));
  gh.lazySingleton<_i28.PhoneSignUp>(
      () => _i28.PhoneSignUp(get<_i25.AuthRepository>()));
  gh.lazySingleton<_i29.SignInWithEmailAndPassword>(
      () => _i29.SignInWithEmailAndPassword(get<_i25.AuthRepository>()));
  gh.lazySingleton<_i30.SignInWithEmailAndPassword>(
      () => _i30.SignInWithEmailAndPassword(get<_i25.AuthRepository>()));
  gh.lazySingleton<_i31.SignInWithFacebook>(
      () => _i31.SignInWithFacebook(get<_i25.AuthRepository>()));
  gh.lazySingleton<_i32.SignInWithGoogle>(
      () => _i32.SignInWithGoogle(get<_i25.AuthRepository>()));
  gh.lazySingleton<_i33.SignInWithPhone>(
      () => _i33.SignInWithPhone(get<_i25.AuthRepository>()));
  gh.factory<_i34.PhoneSignUpVerificationCubit>(() =>
      _i34.PhoneSignUpVerificationCubit(get<_i28.PhoneSignUp>(), get<_i19.SmsAutoFill>()));
  gh.factory<_i34.UpdatePhoneVerificationCubit>(() => _i34.UpdatePhoneVerificationCubit(
      get<_i20.UpdatePhoneNumber>(), get<_i19.SmsAutoFill>()));
  gh.lazySingleton<_i35.VerifyPhoneNumber>(
      () => _i35.VerifyPhoneNumber(get<_i25.AuthRepository>()));
  gh.factory<_i36.AppBloc>(
      () => _i36.AppBloc(authRepository: get<_i25.AuthRepository>()));
  gh.factory<_i37.ChangePhoneCubit>(() => _i37.ChangePhoneCubit(
      get<_i35.VerifyPhoneNumber>(), get<_i20.UpdatePhoneNumber>()));
  gh.factory<_i38.CompleteFormCubit>(
      () => _i38.CompleteFormCubit(get<_i27.LinkEmailAndPassword>()));
  gh.factory<_i39.EmailFormCubit>(
      () => _i39.EmailFormCubit(get<_i29.SignInWithEmailAndPassword>()));
  gh.factory<_i40.OTPCubit>(() => _i40.OTPCubit(
      verifyPhoneNumber: get<_i35.VerifyPhoneNumber>(),
      phoneSignUp: get<_i28.PhoneSignUp>()));
  gh.factory<_i41.PhoneFormCubit>(
      () => _i41.PhoneFormCubit(get<_i35.VerifyPhoneNumber>()));
  gh.factory<_i42.PhoneSignInCubit>(() => _i42.PhoneSignInCubit(
      get<_i35.VerifyPhoneNumber>(), get<_i33.SignInWithPhone>()));
  gh.factory<_i34.PhoneSignInVerificationCubit>(() => _i34.PhoneSignInVerificationCubit(
      get<_i33.SignInWithPhone>(), get<_i19.SmsAutoFill>()));
  return get;
}

class _$RegisterModule extends _i43.RegisterModule {}
