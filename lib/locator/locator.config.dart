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
import 'package:shared_preferences/shared_preferences.dart' as _i15;
import 'package:sms_autofill/sms_autofill.dart' as _i18;

import '../core/services/cache/cache_client.dart' as _i3;
import '../core/services/network/network_info.dart' as _i11;
import '../features/auth/data/datasources/local/auth_local_service.dart'
    as _i26;
import '../features/auth/data/datasources/remote/auth_api_service.dart' as _i25;
import '../features/auth/data/repositories/auth_repository_impl.dart' as _i28;
import '../features/auth/domain/repositories/auth_repository.dart' as _i27;
import '../features/auth/domain/usecases/link_email_and_password.dart' as _i29;
import '../features/auth/domain/usecases/log_out.dart' as _i32;
import '../features/auth/domain/usecases/phone_sign_up.dart' as _i30;
import '../features/auth/domain/usecases/sign_in_with_email_and_password.dart'
    as _i31;
import '../features/auth/domain/usecases/sign_in_with_facebook.dart' as _i33;
import '../features/auth/domain/usecases/sign_in_with_google.dart' as _i34;
import '../features/auth/domain/usecases/sign_in_with_phone.dart' as _i35;
import '../features/auth/domain/usecases/verify_phone_number.dart' as _i36;
import '../features/auth/presentation/bloc/app_status/app_bloc.dart' as _i38;
import '../features/auth/presentation/bloc/sign_in/email_form/email_form_cubit.dart'
    as _i40;
import '../features/auth/presentation/bloc/sign_in/login_form_selection/login_form_selection_cubit.dart'
    as _i10;
import '../features/auth/presentation/bloc/sign_in/phone/phone_sign_in_cubit.dart'
    as _i43;
import '../features/auth/presentation/bloc/sign_in/phone_form/phone_form_cubit.dart'
    as _i42;
import '../features/auth/presentation/bloc/sign_up/complete_form/complete_form_cubit.dart'
    as _i39;
import '../features/auth/presentation/bloc/sign_up/flow_cubit/sign_up_flow_cubit.dart'
    as _i16;
import '../features/auth/presentation/bloc/sign_up/otp_cubit/otp_cubit.dart'
    as _i41;
import '../features/auth/presentation/bloc/sign_up/sign_up_form/sign_up_form_cubit.dart'
    as _i17;
import '../features/auth/presentation/bloc/verifiy_phone/verifiy_phone_cubit.dart'
    as _i22;
import '../features/settings/data/datasources/profile_api_service.dart' as _i12;
import '../features/settings/data/repositories/profile_repository_impl.dart'
    as _i14;
import '../features/settings/domain/repositories/profile_repository.dart'
    as _i13;
import '../features/settings/domain/usecases/update_email.dart' as _i19;
import '../features/settings/domain/usecases/update_phone_number.dart' as _i21;
import '../features/settings/domain/usecases/update_profile.dart' as _i23;
import '../features/settings/presentation/bloc/account_info/account_info_cubit.dart'
    as _i24;
import '../features/settings/presentation/bloc/add_email/add_email_cubit.dart'
    as _i37;
import '../features/settings/presentation/bloc/change_phone/update_phone_cubit.dart'
    as _i44;
import '../features/settings/presentation/bloc/cubit/update_email_cubit.dart'
    as _i20;
import 'register_module.dart' as _i45; // ignore_for_file: unnecessary_lambdas

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
  gh.factory<_i10.LoginFormSelectionCubit>(
      () => _i10.LoginFormSelectionCubit());
  gh.lazySingleton<_i11.NetworkInfo>(
      () => _i11.NetworkInfoImpl(get<_i9.InternetConnectionChecker>()));
  gh.lazySingleton<_i12.ProfileApiService>(() => _i12.ProfileApiServiceImpl(
      get<_i5.FirebaseAuth>(), get<_i6.FirebaseFirestore>()));
  gh.lazySingleton<_i13.ProfileRepository>(() => _i14.ProfileRepositoryImpl(
      get<_i12.ProfileApiService>(), get<_i11.NetworkInfo>()));
  await gh.factoryAsync<_i15.SharedPreferences>(() => registerModule.prefs,
      preResolve: true);
  gh.factory<_i16.SignUpFlowCubit>(() => _i16.SignUpFlowCubit());
  gh.factory<_i17.SignUpFormCubit>(() => _i17.SignUpFormCubit());
  gh.factory<_i18.SmsAutoFill>(() => registerModule.smsAutoFill);
  gh.lazySingleton<_i19.UpdateEmail>(
      () => _i19.UpdateEmail(get<_i13.ProfileRepository>()));
  gh.factory<_i20.UpdateEmailCubit>(
      () => _i20.UpdateEmailCubit(get<_i19.UpdateEmail>()));
  gh.lazySingleton<_i21.UpdatePhoneNumber>(
      () => _i21.UpdatePhoneNumber(get<_i13.ProfileRepository>()));
  gh.factory<_i22.UpdatePhoneVerificationCubit>(() =>
      _i22.UpdatePhoneVerificationCubit(
          get<_i21.UpdatePhoneNumber>(), get<_i18.SmsAutoFill>()));
  gh.lazySingleton<_i23.UpdateProfile>(
      () => _i23.UpdateProfile(get<_i13.ProfileRepository>()));
  gh.factory<_i24.AccountInfoCubit>(
      () => _i24.AccountInfoCubit(get<_i23.UpdateProfile>()));
  gh.lazySingleton<_i25.AuthApiService>(() => _i25.AuthApiServiceImpl(
      firebaseAuth: get<_i5.FirebaseAuth>(),
      googleSignIn: get<_i8.GoogleSignIn>(),
      facebookAuth: get<_i4.FacebookAuth>(),
      firestore: get<_i6.FirebaseFirestore>(),
      cloudFunctions: get<_i7.FirebaseFunctions>()));
  gh.lazySingleton<_i26.AuthLocalService>(
      () => _i26.AuthLocalServiceImpl(get<_i3.CacheClient>()));
  gh.lazySingleton<_i27.AuthRepository>(() => _i28.AuthRepositoryImpl(
      authApiService: get<_i25.AuthApiService>(),
      authLocalService: get<_i26.AuthLocalService>(),
      networkInfo: get<_i11.NetworkInfo>()));
  gh.lazySingleton<_i29.LinkEmailAndPassword>(
      () => _i29.LinkEmailAndPassword(get<_i27.AuthRepository>()));
  gh.lazySingleton<_i30.PhoneSignUp>(
      () => _i30.PhoneSignUp(get<_i27.AuthRepository>()));
  gh.factory<_i22.PhoneSignUpVerificationCubit>(() =>
      _i22.PhoneSignUpVerificationCubit(
          get<_i30.PhoneSignUp>(), get<_i18.SmsAutoFill>()));
  gh.lazySingleton<_i31.SignInWithEmailAndPassword>(
      () => _i31.SignInWithEmailAndPassword(get<_i27.AuthRepository>()));
  gh.lazySingleton<_i32.SignInWithEmailAndPassword>(
      () => _i32.SignInWithEmailAndPassword(get<_i27.AuthRepository>()));
  gh.lazySingleton<_i33.SignInWithFacebook>(
      () => _i33.SignInWithFacebook(get<_i27.AuthRepository>()));
  gh.lazySingleton<_i34.SignInWithGoogle>(
      () => _i34.SignInWithGoogle(get<_i27.AuthRepository>()));
  gh.lazySingleton<_i35.SignInWithPhone>(
      () => _i35.SignInWithPhone(get<_i27.AuthRepository>()));
  gh.lazySingleton<_i36.VerifyPhoneNumber>(
      () => _i36.VerifyPhoneNumber(get<_i27.AuthRepository>()));
  gh.factory<_i37.AddEmailCubit>(
      () => _i37.AddEmailCubit(get<_i29.LinkEmailAndPassword>()));
  gh.factory<_i38.AppBloc>(
      () => _i38.AppBloc(authRepository: get<_i27.AuthRepository>()));
  gh.factory<_i39.CompleteFormCubit>(
      () => _i39.CompleteFormCubit(get<_i29.LinkEmailAndPassword>()));
  gh.factory<_i40.EmailFormCubit>(
      () => _i40.EmailFormCubit(get<_i31.SignInWithEmailAndPassword>()));
  gh.factory<_i41.OTPCubit>(() => _i41.OTPCubit(
      verifyPhoneNumber: get<_i36.VerifyPhoneNumber>(),
      phoneSignUp: get<_i30.PhoneSignUp>()));
  gh.factory<_i42.PhoneFormCubit>(
      () => _i42.PhoneFormCubit(get<_i36.VerifyPhoneNumber>()));
  gh.factory<_i43.PhoneSignInCubit>(() => _i43.PhoneSignInCubit(
      get<_i36.VerifyPhoneNumber>(), get<_i35.SignInWithPhone>()));
  gh.factory<_i22.PhoneSignInVerificationCubit>(() =>
      _i22.PhoneSignInVerificationCubit(
          get<_i35.SignInWithPhone>(), get<_i18.SmsAutoFill>()));
  gh.factory<_i44.UpdateePhoneCubit>(() => _i44.UpdateePhoneCubit(
      get<_i36.VerifyPhoneNumber>(), get<_i21.UpdatePhoneNumber>()));
  return get;
}

class _$RegisterModule extends _i45.RegisterModule {}
