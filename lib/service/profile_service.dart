import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:lua_app/data_source/profile_data_source.dart';
import 'package:lua_app/models/response/general_response.dart';
import 'package:lua_app/models/response/login_response_data.dart';

@lazySingleton
class ProfileService {
  final ProfileDataSource _profileDataSource;

  ProfileService(this._profileDataSource);

  Future<GeneralResponse<UserData>?> updateProfile({
    required String fullName,
    required String phoneNumber,
    required String gender,
    required String address,
    required String email,
    String? avatar,
  }) async {
    final avatarFile = avatar != null ? File(avatar) : null;
    final res = await _profileDataSource.updateProfile(
      fullName: fullName,
      phoneNumber: phoneNumber,
      gender: gender,
      address: address,
      email: email,
      avatar: avatarFile,
    );
    return res;
  }
}
