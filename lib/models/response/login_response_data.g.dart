// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResponseData _$LoginResponseDataFromJson(Map<String, dynamic> json) =>
    LoginResponseData(
      token: json['token'] as String,
      data: UserData.fromJson(json['info'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LoginResponseDataToJson(LoginResponseData instance) =>
    <String, dynamic>{
      'token': instance.token,
      'info': instance.data,
    };

UserData _$UserDataFromJson(Map<String, dynamic> json) => UserData(
      id: json['id'] as String,
      phoneNumber: json['phone_number'] as String,
      email: json['email'] as String,
      avatar: json['avatar'] as String,
      fullName: json['full_name'] as String,
      gender: json['gender'] as String,
      address: json['address'] as String,
      dateOfBirth: json['date_of_birth'] as String?,
      userType: json['user_type'] as String,
      favContent: json['fav_content'] as List<dynamic>,
      introduction: json['introduction'] as String,
      coverImage: json['cover_image'] as String?,
      dateVerified: json['date_verified'] as String?,
      isRegister: json['is_register'] as bool,
    );

Map<String, dynamic> _$UserDataToJson(UserData instance) => <String, dynamic>{
      'id': instance.id,
      'phone_number': instance.phoneNumber,
      'email': instance.email,
      'avatar': instance.avatar,
      'full_name': instance.fullName,
      'gender': instance.gender,
      'address': instance.address,
      'date_of_birth': instance.dateOfBirth,
      'user_type': instance.userType,
      'fav_content': instance.favContent,
      'introduction': instance.introduction,
      'cover_image': instance.coverImage,
      'date_verified': instance.dateVerified,
      'is_register': instance.isRegister,
    };
