import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:lua_app/app_prefs/app_prefs.dart';
import 'package:lua_app/data_source/auth_data_source.dart';
import 'package:lua_app/data_source/profile_data_source.dart';
import 'package:lua_app/di/di_config.config.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: r'$initGetIt',
  preferRelativeImports: true,
  asExtension: false,
)
Future<void> configureDependencies() async => await $initGetIt(getIt);

@module
abstract class AppModule {
  @preResolve
  Future<AppPrefs> get appPrefs => AppPrefs().initialize();

  @lazySingleton
  ImagePicker get imagePicker => ImagePicker();

  @lazySingleton
  GoogleSignIn get googleSignIn => GoogleSignIn();

  @lazySingleton
  Dio get dio {
    final dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 30),
      ),
    );

    dio.interceptors.add(_createAuthInterceptor(getIt.get<AppPrefs>()));

    if (kDebugMode) {
      dio.interceptors
          .add(LogInterceptor(requestBody: true, responseBody: true));
    }

    return dio;
  }

  Interceptor _createAuthInterceptor(AppPrefs appPrefs) {
    return InterceptorsWrapper(
      onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
        final token = appPrefs.getToken();

        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(options);
      },
    );
  }

  @lazySingleton
  AuthDataSource get authDataSource => AuthDataSource(getIt<Dio>());

  @lazySingleton
  ProfileDataSource get profileDataSource => ProfileDataSource(getIt<Dio>());
}
