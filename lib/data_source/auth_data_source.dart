import 'package:lua_app/global_constants.dart';
import 'package:lua_app/models/request/login_request.dart';
import 'package:lua_app/models/response/general_response.dart';
import 'package:lua_app/models/response/login_response_data.dart';
import 'package:retrofit/http.dart';
import 'package:dio/dio.dart';

part 'auth_data_source.g.dart';

@RestApi(baseUrl: GlobalConstants.baseUrl)
abstract class AuthDataSource {
  factory AuthDataSource(Dio dio, {String baseUrl}) = _AuthDataSource;

  @POST('auth/mb/login/social/')
  Future<GeneralResponse<LoginResponseData>> login({
    @Body() required LoginRequest request,
  });

  @GET('auth/mb/user/detail/')
  Future<GeneralResponse<UserData>> getUserData();
}
