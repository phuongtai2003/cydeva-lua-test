import 'package:get/get.dart';
import 'package:lua_app/controllers/profile_controller.dart';
import 'package:lua_app/route_names.dart';
import 'package:lua_app/service/auth_service.dart';

class FlashController extends GetxController {
  final AuthService _authService;

  FlashController(this._authService);

  @override
  void onInit() async {
    super.onInit();
    Get.updateLocale(
      _authService.getLocale(),
    );
    await Future.delayed(const Duration(seconds: 2), () async {
      final res = await _authService.getUserData();
      if (res == null) {
        Get.offNamed(RouteNames.login);
      } else {
        Get.find<ProfileController>().updateUser(res);
        Get.offNamed(RouteNames.main);
      }
    });
  }
}
