import 'package:get/get.dart';
import 'package:lua_app/controllers/profile_controller.dart';
import 'package:lua_app/enums.dart';
import 'package:lua_app/global_constants.dart';
import 'package:lua_app/route_names.dart';
import 'package:lua_app/service/auth_service.dart';

class LoginController extends GetxController {
  final AuthService _authService;

  LoginController(
    this._authService,
  );

  final List<LanguageKey> languages = [
    LanguageKey.vi,
    LanguageKey.en,
  ];

  final Rx<LanguageKey> selectedLanguage = LanguageKey.vi.obs;

  @override
  void onInit() {
    super.onInit();
    selectedLanguage.value =
        Get.locale?.languageCode == 'vi' ? LanguageKey.vi : LanguageKey.en;
  }

  void changeLanguage(LanguageKey language) {
    selectedLanguage.value = language;
    Get.updateLocale(
      language == LanguageKey.vi
          ? GlobalConstants.supportedLocales[1]
          : GlobalConstants.supportedLocales[0],
    );
    _authService.saveLocale(
      language == LanguageKey.vi ? 'vi' : 'en',
    );
  }

  void signInWithGoogle() async {
    try {
      final res = await _authService.signInWithGoogle();
      if (res != null) {
        Get.find<ProfileController>().updateUser(
          res,
        );
        Get.offNamed(
          RouteNames.pickTopic,
        );
      } else {
        Get.snackbar(
          'Error',
          'Sign in failed',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
