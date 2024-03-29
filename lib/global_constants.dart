import 'package:flutter/material.dart';

class GlobalConstants {
  static const List<Locale> supportedLocales = [
    Locale('en', 'US'),
    Locale('vi', 'VN'),
  ];
  static const String baseUrl = 'https://api.lua.cydeva.tech/api/v1/';
  static const String kTokenKey = 'TOKEN';
  static const String kLocaleKey = 'LOCALE';
}
