// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i5;
import 'package:get_it/get_it.dart' as _i1;
import 'package:google_sign_in/google_sign_in.dart' as _i6;
import 'package:image_picker/image_picker.dart' as _i7;
import 'package:injectable/injectable.dart' as _i2;

import '../app_prefs/app_prefs.dart' as _i3;
import '../data_source/auth_data_source.dart' as _i4;
import '../data_source/profile_data_source.dart' as _i8;
import '../service/auth_service.dart' as _i10;
import '../service/profile_service.dart' as _i9;
import 'di_config.dart' as _i11;

// initializes the registration of main-scope dependencies inside of GetIt
Future<_i1.GetIt> $initGetIt(
  _i1.GetIt getIt, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) async {
  final gh = _i2.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  final appModule = _$AppModule();
  await gh.factoryAsync<_i3.AppPrefs>(
    () => appModule.appPrefs,
    preResolve: true,
  );
  gh.lazySingleton<_i4.AuthDataSource>(() => appModule.authDataSource);
  gh.lazySingleton<_i5.Dio>(() => appModule.dio);
  gh.lazySingleton<_i6.GoogleSignIn>(() => appModule.googleSignIn);
  gh.lazySingleton<_i7.ImagePicker>(() => appModule.imagePicker);
  gh.lazySingleton<_i8.ProfileDataSource>(() => appModule.profileDataSource);
  gh.lazySingleton<_i9.ProfileService>(
      () => _i9.ProfileService(gh<_i8.ProfileDataSource>()));
  gh.lazySingleton<_i10.AuthService>(() => _i10.AuthService(
        gh<_i6.GoogleSignIn>(),
        gh<_i4.AuthDataSource>(),
        gh<_i3.AppPrefs>(),
      ));
  return getIt;
}

class _$AppModule extends _i11.AppModule {}
