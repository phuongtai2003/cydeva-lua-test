import 'dart:io';

import 'package:dio/dio.dart';
import 'package:lua_app/global_constants.dart';
import 'package:lua_app/models/response/general_response.dart';
import 'package:lua_app/models/response/login_response_data.dart';
import 'package:retrofit/http.dart';

part 'profile_data_source.g.dart';

@RestApi(baseUrl: GlobalConstants.baseUrl)
abstract class ProfileDataSource {
  factory ProfileDataSource(Dio dio, {String baseUrl}) = _ProfileDataSource;

  @PUT('auth/mb/user/update/')
  @MultiPart()
  Future<GeneralResponse<UserData>> updateProfile({
    @Part(name: 'full_name') required String fullName,
    @Part(name: 'phone_number') required String phoneNumber,
    @Part(name: 'gender') required String gender,
    @Part(name: 'address') required String address,
    @Part(name: 'email') required String email,
    @Part(name: 'avatar') File? avatar,
  });
}
