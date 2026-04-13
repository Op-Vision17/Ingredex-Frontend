import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_models.freezed.dart';
part 'profile_models.g.dart';

@freezed
class HealthProfile with _$HealthProfile {
  const factory HealthProfile({
    @Default(<String>[]) List<String> allergies,
    @JsonKey(name: 'medical_conditions') @Default(<String>[]) List<String> medicalConditions,
    @JsonKey(name: 'diet_recommendations') @Default('') String dietRecommendations,
  }) = _HealthProfile;

  factory HealthProfile.fromJson(Map<String, dynamic> json) =>
      _$HealthProfileFromJson(json);
}
