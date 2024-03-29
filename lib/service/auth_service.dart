import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lua_app/app_prefs/app_prefs.dart';
import 'package:lua_app/data_source/auth_data_source.dart';
import 'package:lua_app/global_constants.dart';
import 'package:lua_app/models/request/login_request.dart';
import 'package:lua_app/models/response/login_response_data.dart';

@lazySingleton
class AuthService {
  final GoogleSignIn _googleSignIn;
  final AuthDataSource _authDataSource;
  final AppPrefs _appPrefs;

  AuthService(
    this._googleSignIn,
    this._authDataSource,
    this._appPrefs,
  );
  Future<UserData?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;

      final res = await _authDataSource.login(
        request: LoginRequest(
          token: googleAuth.idToken ?? '',
          provider: 'google',
        ),
      );
      if (res.statusCode == 200) {
        await _appPrefs.setToken(res.data.token);
        _googleSignIn.signOut();
        return res.data.data;
      } else {
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }

  Locale getLocale() {
    final locale = _appPrefs.getLocale();
    if (locale == null) {
      return GlobalConstants.supportedLocales[0];
    }
    return Locale(locale);
  }

  void saveLocale(String locale) async {
    await _appPrefs.saveLocale(locale);
  }

  Future<void> signOut() async {
    try {
      await _googleSignIn.signOut();
      await FirebaseAuth.instance.signOut();
      await _appPrefs.logout();
    } catch (e) {
      rethrow;
    }
  }

  Future<UserData?> getUserData() async {
    if (_appPrefs.getToken() != null) {
      final res = await _authDataSource.getUserData();
      if (res.statusCode == 200) {
        return res.data;
      } else {
        return null;
      }
    }
    return null;
  }
}
