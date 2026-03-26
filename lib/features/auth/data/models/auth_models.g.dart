// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SendOtpRequestImpl _$$SendOtpRequestImplFromJson(Map<String, dynamic> json) =>
    _$SendOtpRequestImpl(
      email: json['email'] as String,
    );

Map<String, dynamic> _$$SendOtpRequestImplToJson(
        _$SendOtpRequestImpl instance) =>
    <String, dynamic>{
      'email': instance.email,
    };

_$VerifyOtpRequestImpl _$$VerifyOtpRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$VerifyOtpRequestImpl(
      email: json['email'] as String,
      otp: json['otp'] as String,
    );

Map<String, dynamic> _$$VerifyOtpRequestImplToJson(
        _$VerifyOtpRequestImpl instance) =>
    <String, dynamic>{
      'email': instance.email,
      'otp': instance.otp,
    };

_$AuthTokensImpl _$$AuthTokensImplFromJson(Map<String, dynamic> json) =>
    _$AuthTokensImpl(
      accessToken: json['access_token'] as String,
      refreshToken: json['refresh_token'] as String,
      tokenType: json['token_type'] as String? ?? 'bearer',
      accessTokenExpiresIn: (json['access_token_expires_in'] as num).toInt(),
      isNewUser: json['is_new_user'] as bool?,
    );

Map<String, dynamic> _$$AuthTokensImplToJson(_$AuthTokensImpl instance) =>
    <String, dynamic>{
      'access_token': instance.accessToken,
      'refresh_token': instance.refreshToken,
      'token_type': instance.tokenType,
      'access_token_expires_in': instance.accessTokenExpiresIn,
      'is_new_user': instance.isNewUser,
    };

_$UserProfileImpl _$$UserProfileImplFromJson(Map<String, dynamic> json) =>
    _$UserProfileImpl(
      id: json['id'] as String,
      email: json['email'] as String?,
      createdAt: json['created_at'] as String,
    );

Map<String, dynamic> _$$UserProfileImplToJson(_$UserProfileImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'created_at': instance.createdAt,
    };
