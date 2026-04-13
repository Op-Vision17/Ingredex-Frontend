// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

HealthProfile _$HealthProfileFromJson(Map<String, dynamic> json) {
  return _HealthProfile.fromJson(json);
}

/// @nodoc
mixin _$HealthProfile {
  List<String> get allergies => throw _privateConstructorUsedError;
  @JsonKey(name: 'medical_conditions')
  List<String> get medicalConditions => throw _privateConstructorUsedError;
  @JsonKey(name: 'diet_recommendations')
  String get dietRecommendations => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $HealthProfileCopyWith<HealthProfile> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HealthProfileCopyWith<$Res> {
  factory $HealthProfileCopyWith(
          HealthProfile value, $Res Function(HealthProfile) then) =
      _$HealthProfileCopyWithImpl<$Res, HealthProfile>;
  @useResult
  $Res call(
      {List<String> allergies,
      @JsonKey(name: 'medical_conditions') List<String> medicalConditions,
      @JsonKey(name: 'diet_recommendations') String dietRecommendations});
}

/// @nodoc
class _$HealthProfileCopyWithImpl<$Res, $Val extends HealthProfile>
    implements $HealthProfileCopyWith<$Res> {
  _$HealthProfileCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? allergies = null,
    Object? medicalConditions = null,
    Object? dietRecommendations = null,
  }) {
    return _then(_value.copyWith(
      allergies: null == allergies
          ? _value.allergies
          : allergies // ignore: cast_nullable_to_non_nullable
              as List<String>,
      medicalConditions: null == medicalConditions
          ? _value.medicalConditions
          : medicalConditions // ignore: cast_nullable_to_non_nullable
              as List<String>,
      dietRecommendations: null == dietRecommendations
          ? _value.dietRecommendations
          : dietRecommendations // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$HealthProfileImplCopyWith<$Res>
    implements $HealthProfileCopyWith<$Res> {
  factory _$$HealthProfileImplCopyWith(
          _$HealthProfileImpl value, $Res Function(_$HealthProfileImpl) then) =
      __$$HealthProfileImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<String> allergies,
      @JsonKey(name: 'medical_conditions') List<String> medicalConditions,
      @JsonKey(name: 'diet_recommendations') String dietRecommendations});
}

/// @nodoc
class __$$HealthProfileImplCopyWithImpl<$Res>
    extends _$HealthProfileCopyWithImpl<$Res, _$HealthProfileImpl>
    implements _$$HealthProfileImplCopyWith<$Res> {
  __$$HealthProfileImplCopyWithImpl(
      _$HealthProfileImpl _value, $Res Function(_$HealthProfileImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? allergies = null,
    Object? medicalConditions = null,
    Object? dietRecommendations = null,
  }) {
    return _then(_$HealthProfileImpl(
      allergies: null == allergies
          ? _value._allergies
          : allergies // ignore: cast_nullable_to_non_nullable
              as List<String>,
      medicalConditions: null == medicalConditions
          ? _value._medicalConditions
          : medicalConditions // ignore: cast_nullable_to_non_nullable
              as List<String>,
      dietRecommendations: null == dietRecommendations
          ? _value.dietRecommendations
          : dietRecommendations // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$HealthProfileImpl implements _HealthProfile {
  const _$HealthProfileImpl(
      {final List<String> allergies = const <String>[],
      @JsonKey(name: 'medical_conditions')
      final List<String> medicalConditions = const <String>[],
      @JsonKey(name: 'diet_recommendations') this.dietRecommendations = ''})
      : _allergies = allergies,
        _medicalConditions = medicalConditions;

  factory _$HealthProfileImpl.fromJson(Map<String, dynamic> json) =>
      _$$HealthProfileImplFromJson(json);

  final List<String> _allergies;
  @override
  @JsonKey()
  List<String> get allergies {
    if (_allergies is EqualUnmodifiableListView) return _allergies;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_allergies);
  }

  final List<String> _medicalConditions;
  @override
  @JsonKey(name: 'medical_conditions')
  List<String> get medicalConditions {
    if (_medicalConditions is EqualUnmodifiableListView)
      return _medicalConditions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_medicalConditions);
  }

  @override
  @JsonKey(name: 'diet_recommendations')
  final String dietRecommendations;

  @override
  String toString() {
    return 'HealthProfile(allergies: $allergies, medicalConditions: $medicalConditions, dietRecommendations: $dietRecommendations)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HealthProfileImpl &&
            const DeepCollectionEquality()
                .equals(other._allergies, _allergies) &&
            const DeepCollectionEquality()
                .equals(other._medicalConditions, _medicalConditions) &&
            (identical(other.dietRecommendations, dietRecommendations) ||
                other.dietRecommendations == dietRecommendations));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_allergies),
      const DeepCollectionEquality().hash(_medicalConditions),
      dietRecommendations);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$HealthProfileImplCopyWith<_$HealthProfileImpl> get copyWith =>
      __$$HealthProfileImplCopyWithImpl<_$HealthProfileImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HealthProfileImplToJson(
      this,
    );
  }
}

abstract class _HealthProfile implements HealthProfile {
  const factory _HealthProfile(
      {final List<String> allergies,
      @JsonKey(name: 'medical_conditions') final List<String> medicalConditions,
      @JsonKey(name: 'diet_recommendations')
      final String dietRecommendations}) = _$HealthProfileImpl;

  factory _HealthProfile.fromJson(Map<String, dynamic> json) =
      _$HealthProfileImpl.fromJson;

  @override
  List<String> get allergies;
  @override
  @JsonKey(name: 'medical_conditions')
  List<String> get medicalConditions;
  @override
  @JsonKey(name: 'diet_recommendations')
  String get dietRecommendations;
  @override
  @JsonKey(ignore: true)
  _$$HealthProfileImplCopyWith<_$HealthProfileImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
