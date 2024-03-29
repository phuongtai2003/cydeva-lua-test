import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lua_app/controllers/flash_controller.dart';
import 'package:lua_app/controllers/login_controller.dart';
import 'package:lua_app/controllers/main_controller.dart';
import 'package:lua_app/controllers/profile_controller.dart';
import 'package:lua_app/controllers/select_topics_controller.dart';
import 'package:lua_app/di/di_config.dart';
import 'package:lua_app/firebase_options.dart';
import 'package:lua_app/generated/locales.g.dart';
import 'package:lua_app/global_colors.dart';
import 'package:lua_app/global_constants.dart';
import 'package:lua_app/route_names.dart';
import 'package:lua_app/screens/flash/flash_screen.dart';
import 'package:lua_app/screens/login/login_screen.dart';
import 'package:lua_app/screens/main/edit_profile_screen.dart';
import 'package:lua_app/screens/main/main_bottom_navbar.dart';
import 'package:lua_app/screens/select_topics/select_topics_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:lua_app/service/auth_service.dart';
import 'package:lua_app/service/profile_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      translationsKeys: AppTranslation.translations,
      transitionDuration: const Duration(milliseconds: 300),
      defaultTransition: Transition.rightToLeft,
      supportedLocales: GlobalConstants.supportedLocales,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      initialBinding: BindingsBuilder(
        () {
          Get.put(
            ProfileController(
              getIt.get<AuthService>(),
              getIt.get<ImagePicker>(),
              getIt.get<ProfileService>(),
            ),
          );
        },
      ),
      fallbackLocale: GlobalConstants.supportedLocales[0],
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(seedColor: GlobalColors.primaryColor),
        primaryColor: GlobalColors.primaryColor,
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      getPages: [
        GetPage(
          name: RouteNames.flash,
          bindings: [
            BindingsBuilder<FlashController>(
              () {
                Get.put(
                  FlashController(
                    getIt.get<AuthService>(),
                  ),
                );
              },
            )
          ],
          page: () => const FlashScreen(),
        ),
        GetPage(
          name: RouteNames.pickTopic,
          bindings: [
            BindingsBuilder<SelectTopicsController>(
              () {
                Get.put(
                  SelectTopicsController(),
                );
              },
            )
          ],
          page: () => const SelectTopicsScreen(),
        ),
        GetPage(
          name: RouteNames.login,
          bindings: [
            BindingsBuilder<LoginController>(
              () {
                Get.put(
                  LoginController(getIt.get<AuthService>()),
                );
              },
            ),
          ],
          page: () => const LoginScreen(),
        ),
        GetPage(
          name: RouteNames.main,
          bindings: [
            BindingsBuilder(
              () {
                Get.put(
                  MainController(),
                );
              },
            )
          ],
          page: () => const MainBottomNavbar(),
        ),
        GetPage(
          name: RouteNames.editProfile,
          page: () => const EditProfileScreen(),
        ),
      ],
    );
  }
}
