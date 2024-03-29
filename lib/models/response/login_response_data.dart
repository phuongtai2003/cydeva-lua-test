import 'package:json_annotation/json_annotation.dart';

part 'login_response_data.g.dart';

@JsonSerializable()
class LoginResponseData {
  final String token;
  @JsonKey(name: 'info')
  final UserData data;

  LoginResponseData({required this.token, required this.data});

  factory LoginResponseData.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseDataFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseDataToJson(this);
}

@JsonSerializable()
class UserData {
  final String id;
  @JsonKey(name: 'phone_number')
  final String phoneNumber;
  final String email;
  final String avatar;
  @JsonKey(name: 'full_name')
  final String fullName;
  final String gender;
  final String address;
  @JsonKey(name: 'date_of_birth')
  final String? dateOfBirth;
  @JsonKey(name: 'user_type')
  final String userType;
  @JsonKey(name: 'fav_content')
  final List<dynamic> favContent;
  final String introduction;
  @JsonKey(name: 'cover_image')
  final String? coverImage;
  @JsonKey(name: 'date_verified')
  final String? dateVerified;
  @JsonKey(name: 'is_register')
  final bool isRegister;

  UserData({
    required this.id,
    required this.phoneNumber,
    required this.email,
    required this.avatar,
    required this.fullName,
    required this.gender,
    required this.address,
    required this.dateOfBirth,
    required this.userType,
    required this.favContent,
    required this.introduction,
    this.coverImage,
    this.dateVerified,
    required this.isRegister,
  });

  factory UserData.fromJson(Map<String, dynamic> json) =>
      _$UserDataFromJson(json);

  Map<String, dynamic> toJson() => _$UserDataToJson(this);
}
