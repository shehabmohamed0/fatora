// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:firebase_auth/firebase_auth.dart' as _i4;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:internet_connection_checker/internet_connection_checker.dart'
    as _i5;
import 'package:shared_preferences/shared_preferences.dart' as _i7;

import '../core/services/cache/cache_client.dart' as _i3;
import '../core/services/network/network_info.dart' as _i6;
import '../features/auth/data/datasources/local/auth_local_service.dart' as _i9;
import '../features/auth/data/datasources/remote/auth_api_service.dart' as _i8;
import '../features/auth/data/repositories/auth_repository_impl.dart' as _i11;
import '../features/auth/domain/repositories/auth_repository.dart' as _i10;
import '../features/auth/domain/usecases/log_out.dart' as _i13;
import '../features/auth/domain/usecases/sign_in_with_google.dart'
    as _i14;
import '../features/auth/domain/usecases/sign_in_with_email_and_password.dart'
    as _i12;
import '../features/auth/domain/usecases/sign_up_with_email_and_password.dart'
    as _i15;
import '../features/auth/presentation/bloc/app_status/app_bloc.dart' as _i16;
import '../features/auth/presentation/bloc/sign_in/sign_in_cubit.dart' as _i17;
import '../features/auth/presentation/bloc/sign_up/sign_up_cubit.dart' as _i18;
import 'register_module.dart' as _i19; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
Future<_i1.GetIt> $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) async {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final registerModule = _$RegisterModule();
  gh.lazySingleton<_i3.CacheClient>(() => _i3.CacheClient());
  gh.factory<_i4.FirebaseAuth>(() => registerModule.auth);
  gh.factory<_i5.InternetConnectionChecker>(
      () => registerModule.internetConnectionChecker);
  gh.lazySingleton<_i6.NetworkInfo>(
      () => _i6.NetworkInfoImpl(get<_i5.InternetConnectionChecker>()));
  await gh.factoryAsync<_i7.SharedPreferences>(() => registerModule.prefs,
      preResolve: true);
  gh.lazySingleton<_i8.AuthApiService>(
      () => _i8.AuthApiServiceImpl(get<_i4.FirebaseAuth>()));
  gh.lazySingleton<_i9.AuthLocalService>(
      () => _i9.AuthLocalServiceImpl(get<_i3.CacheClient>()));
  gh.lazySingleton<_i10.AuthRepository>(() => _i11.AuthRepositoryImpl(
      authApiService: get<_i8.AuthApiService>(),
      authLocalService: get<_i9.AuthLocalService>(),
      networkInfo: get<_i6.NetworkInfo>()));
  gh.lazySingleton<_i12.SignInWithEmailAndPassword>(
      () => _i12.SignInWithEmailAndPassword(get<_i10.AuthRepository>()));
  gh.lazySingleton<_i13.SignInWithEmailAndPassword>(
      () => _i13.SignInWithEmailAndPassword(get<_i10.AuthRepository>()));
  gh.lazySingleton<_i14.SignInWithGoogle>(
      () => _i14.SignInWithGoogle(get<_i10.AuthRepository>()));
  gh.lazySingleton<_i15.SignUpWithEmailAndPassword>(
      () => _i15.SignUpWithEmailAndPassword(get<_i10.AuthRepository>()));
  gh.factory<_i16.AppBloc>(
      () => _i16.AppBloc(authRepository: get<_i10.AuthRepository>()));
  gh.factory<_i17.SignInCubit>(
      () => _i17.SignInCubit(get<_i12.SignInWithEmailAndPassword>()));
  gh.factory<_i18.SignUpCubit>(
      () => _i18.SignUpCubit(get<_i15.SignUpWithEmailAndPassword>()));
  return get;
}

class _$RegisterModule extends _i19.RegisterModule {}
