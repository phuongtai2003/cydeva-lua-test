import 'package:lua_app/app_prefs/base_prefs.dart';
import 'package:lua_app/global_constants.dart';

class AppPrefs extends BasePrefs {
  Future<AppPrefs> initialize() async {
    final prefs = AppPrefs();
    await prefs.init();
    return prefs;
  }

  Future<void> setToken(String? token) async {
    await setValueForKey(GlobalConstants.kTokenKey, token);
  }

  String? getToken() {
    return getValueForKey(GlobalConstants.kTokenKey);
  }

  Future<void> saveLocale(String locale) async {
    await setValueForKey(GlobalConstants.kLocaleKey, locale);
  }

  String? getLocale() {
    return getValueForKey(GlobalConstants.kLocaleKey);
  }

  Future<void> logout() async {
    await remove(key: GlobalConstants.kTokenKey);
  }
}
