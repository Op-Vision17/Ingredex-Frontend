// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$HealthProfileImpl _$$HealthProfileImplFromJson(Map<String, dynamic> json) =>
    _$HealthProfileImpl(
      allergies: (json['allergies'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
      medicalConditions: (json['medical_conditions'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
      dietRecommendations: json['diet_recommendations'] as String? ?? '',
    );

Map<String, dynamic> _$$HealthProfileImplToJson(_$HealthProfileImpl instance) =>
    <String, dynamic>{
      'allergies': instance.allergies,
      'medical_conditions': instance.medicalConditions,
      'diet_recommendations': instance.dietRecommendations,
    };
