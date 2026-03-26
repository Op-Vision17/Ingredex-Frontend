// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'history_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

HistoryItem _$HistoryItemFromJson(Map<String, dynamic> json) {
  return _HistoryItem.fromJson(json);
}

/// @nodoc
mixin _$HistoryItem {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'product_name')
  String? get productName => throw _privateConstructorUsedError;
  String? get barcode => throw _privateConstructorUsedError;
  @JsonKey(name: 'analysis_result')
  Map<String, dynamic>? get analysisResult =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'scan_type')
  String get scanType => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  String get createdAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $HistoryItemCopyWith<HistoryItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HistoryItemCopyWith<$Res> {
  factory $HistoryItemCopyWith(
          HistoryItem value, $Res Function(HistoryItem) then) =
      _$HistoryItemCopyWithImpl<$Res, HistoryItem>;
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'product_name') String? productName,
      String? barcode,
      @JsonKey(name: 'analysis_result') Map<String, dynamic>? analysisResult,
      @JsonKey(name: 'scan_type') String scanType,
      @JsonKey(name: 'created_at') String createdAt});
}

/// @nodoc
class _$HistoryItemCopyWithImpl<$Res, $Val extends HistoryItem>
    implements $HistoryItemCopyWith<$Res> {
  _$HistoryItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? productName = freezed,
    Object? barcode = freezed,
    Object? analysisResult = freezed,
    Object? scanType = null,
    Object? createdAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      productName: freezed == productName
          ? _value.productName
          : productName // ignore: cast_nullable_to_non_nullable
              as String?,
      barcode: freezed == barcode
          ? _value.barcode
          : barcode // ignore: cast_nullable_to_non_nullable
              as String?,
      analysisResult: freezed == analysisResult
          ? _value.analysisResult
          : analysisResult // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      scanType: null == scanType
          ? _value.scanType
          : scanType // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$HistoryItemImplCopyWith<$Res>
    implements $HistoryItemCopyWith<$Res> {
  factory _$$HistoryItemImplCopyWith(
          _$HistoryItemImpl value, $Res Function(_$HistoryItemImpl) then) =
      __$$HistoryItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'product_name') String? productName,
      String? barcode,
      @JsonKey(name: 'analysis_result') Map<String, dynamic>? analysisResult,
      @JsonKey(name: 'scan_type') String scanType,
      @JsonKey(name: 'created_at') String createdAt});
}

/// @nodoc
class __$$HistoryItemImplCopyWithImpl<$Res>
    extends _$HistoryItemCopyWithImpl<$Res, _$HistoryItemImpl>
    implements _$$HistoryItemImplCopyWith<$Res> {
  __$$HistoryItemImplCopyWithImpl(
      _$HistoryItemImpl _value, $Res Function(_$HistoryItemImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? productName = freezed,
    Object? barcode = freezed,
    Object? analysisResult = freezed,
    Object? scanType = null,
    Object? createdAt = null,
  }) {
    return _then(_$HistoryItemImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      productName: freezed == productName
          ? _value.productName
          : productName // ignore: cast_nullable_to_non_nullable
              as String?,
      barcode: freezed == barcode
          ? _value.barcode
          : barcode // ignore: cast_nullable_to_non_nullable
              as String?,
      analysisResult: freezed == analysisResult
          ? _value._analysisResult
          : analysisResult // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      scanType: null == scanType
          ? _value.scanType
          : scanType // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$HistoryItemImpl implements _HistoryItem {
  const _$HistoryItemImpl(
      {required this.id,
      @JsonKey(name: 'product_name') this.productName,
      this.barcode,
      @JsonKey(name: 'analysis_result')
      final Map<String, dynamic>? analysisResult,
      @JsonKey(name: 'scan_type') required this.scanType,
      @JsonKey(name: 'created_at') required this.createdAt})
      : _analysisResult = analysisResult;

  factory _$HistoryItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$HistoryItemImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'product_name')
  final String? productName;
  @override
  final String? barcode;
  final Map<String, dynamic>? _analysisResult;
  @override
  @JsonKey(name: 'analysis_result')
  Map<String, dynamic>? get analysisResult {
    final value = _analysisResult;
    if (value == null) return null;
    if (_analysisResult is EqualUnmodifiableMapView) return _analysisResult;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  @JsonKey(name: 'scan_type')
  final String scanType;
  @override
  @JsonKey(name: 'created_at')
  final String createdAt;

  @override
  String toString() {
    return 'HistoryItem(id: $id, productName: $productName, barcode: $barcode, analysisResult: $analysisResult, scanType: $scanType, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HistoryItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.productName, productName) ||
                other.productName == productName) &&
            (identical(other.barcode, barcode) || other.barcode == barcode) &&
            const DeepCollectionEquality()
                .equals(other._analysisResult, _analysisResult) &&
            (identical(other.scanType, scanType) ||
                other.scanType == scanType) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      productName,
      barcode,
      const DeepCollectionEquality().hash(_analysisResult),
      scanType,
      createdAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$HistoryItemImplCopyWith<_$HistoryItemImpl> get copyWith =>
      __$$HistoryItemImplCopyWithImpl<_$HistoryItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HistoryItemImplToJson(
      this,
    );
  }
}

abstract class _HistoryItem implements HistoryItem {
  const factory _HistoryItem(
          {required final String id,
          @JsonKey(name: 'product_name') final String? productName,
          final String? barcode,
          @JsonKey(name: 'analysis_result')
          final Map<String, dynamic>? analysisResult,
          @JsonKey(name: 'scan_type') required final String scanType,
          @JsonKey(name: 'created_at') required final String createdAt}) =
      _$HistoryItemImpl;

  factory _HistoryItem.fromJson(Map<String, dynamic> json) =
      _$HistoryItemImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'product_name')
  String? get productName;
  @override
  String? get barcode;
  @override
  @JsonKey(name: 'analysis_result')
  Map<String, dynamic>? get analysisResult;
  @override
  @JsonKey(name: 'scan_type')
  String get scanType;
  @override
  @JsonKey(name: 'created_at')
  String get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$HistoryItemImplCopyWith<_$HistoryItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

HistoryDetail _$HistoryDetailFromJson(Map<String, dynamic> json) {
  return _HistoryDetail.fromJson(json);
}

/// @nodoc
mixin _$HistoryDetail {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'product_name')
  String? get productName => throw _privateConstructorUsedError;
  String? get barcode => throw _privateConstructorUsedError;
  @JsonKey(name: 'raw_ingredients')
  String? get rawIngredients => throw _privateConstructorUsedError;
  @JsonKey(name: 'analysis_result')
  Map<String, dynamic>? get analysisResult =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'scan_type')
  String get scanType => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  String get createdAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $HistoryDetailCopyWith<HistoryDetail> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HistoryDetailCopyWith<$Res> {
  factory $HistoryDetailCopyWith(
          HistoryDetail value, $Res Function(HistoryDetail) then) =
      _$HistoryDetailCopyWithImpl<$Res, HistoryDetail>;
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'product_name') String? productName,
      String? barcode,
      @JsonKey(name: 'raw_ingredients') String? rawIngredients,
      @JsonKey(name: 'analysis_result') Map<String, dynamic>? analysisResult,
      @JsonKey(name: 'scan_type') String scanType,
      @JsonKey(name: 'created_at') String createdAt});
}

/// @nodoc
class _$HistoryDetailCopyWithImpl<$Res, $Val extends HistoryDetail>
    implements $HistoryDetailCopyWith<$Res> {
  _$HistoryDetailCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? productName = freezed,
    Object? barcode = freezed,
    Object? rawIngredients = freezed,
    Object? analysisResult = freezed,
    Object? scanType = null,
    Object? createdAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      productName: freezed == productName
          ? _value.productName
          : productName // ignore: cast_nullable_to_non_nullable
              as String?,
      barcode: freezed == barcode
          ? _value.barcode
          : barcode // ignore: cast_nullable_to_non_nullable
              as String?,
      rawIngredients: freezed == rawIngredients
          ? _value.rawIngredients
          : rawIngredients // ignore: cast_nullable_to_non_nullable
              as String?,
      analysisResult: freezed == analysisResult
          ? _value.analysisResult
          : analysisResult // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      scanType: null == scanType
          ? _value.scanType
          : scanType // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$HistoryDetailImplCopyWith<$Res>
    implements $HistoryDetailCopyWith<$Res> {
  factory _$$HistoryDetailImplCopyWith(
          _$HistoryDetailImpl value, $Res Function(_$HistoryDetailImpl) then) =
      __$$HistoryDetailImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'product_name') String? productName,
      String? barcode,
      @JsonKey(name: 'raw_ingredients') String? rawIngredients,
      @JsonKey(name: 'analysis_result') Map<String, dynamic>? analysisResult,
      @JsonKey(name: 'scan_type') String scanType,
      @JsonKey(name: 'created_at') String createdAt});
}

/// @nodoc
class __$$HistoryDetailImplCopyWithImpl<$Res>
    extends _$HistoryDetailCopyWithImpl<$Res, _$HistoryDetailImpl>
    implements _$$HistoryDetailImplCopyWith<$Res> {
  __$$HistoryDetailImplCopyWithImpl(
      _$HistoryDetailImpl _value, $Res Function(_$HistoryDetailImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? productName = freezed,
    Object? barcode = freezed,
    Object? rawIngredients = freezed,
    Object? analysisResult = freezed,
    Object? scanType = null,
    Object? createdAt = null,
  }) {
    return _then(_$HistoryDetailImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      productName: freezed == productName
          ? _value.productName
          : productName // ignore: cast_nullable_to_non_nullable
              as String?,
      barcode: freezed == barcode
          ? _value.barcode
          : barcode // ignore: cast_nullable_to_non_nullable
              as String?,
      rawIngredients: freezed == rawIngredients
          ? _value.rawIngredients
          : rawIngredients // ignore: cast_nullable_to_non_nullable
              as String?,
      analysisResult: freezed == analysisResult
          ? _value._analysisResult
          : analysisResult // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      scanType: null == scanType
          ? _value.scanType
          : scanType // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$HistoryDetailImpl implements _HistoryDetail {
  const _$HistoryDetailImpl(
      {required this.id,
      @JsonKey(name: 'product_name') this.productName,
      this.barcode,
      @JsonKey(name: 'raw_ingredients') this.rawIngredients,
      @JsonKey(name: 'analysis_result')
      final Map<String, dynamic>? analysisResult,
      @JsonKey(name: 'scan_type') required this.scanType,
      @JsonKey(name: 'created_at') required this.createdAt})
      : _analysisResult = analysisResult;

  factory _$HistoryDetailImpl.fromJson(Map<String, dynamic> json) =>
      _$$HistoryDetailImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'product_name')
  final String? productName;
  @override
  final String? barcode;
  @override
  @JsonKey(name: 'raw_ingredients')
  final String? rawIngredients;
  final Map<String, dynamic>? _analysisResult;
  @override
  @JsonKey(name: 'analysis_result')
  Map<String, dynamic>? get analysisResult {
    final value = _analysisResult;
    if (value == null) return null;
    if (_analysisResult is EqualUnmodifiableMapView) return _analysisResult;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  @JsonKey(name: 'scan_type')
  final String scanType;
  @override
  @JsonKey(name: 'created_at')
  final String createdAt;

  @override
  String toString() {
    return 'HistoryDetail(id: $id, productName: $productName, barcode: $barcode, rawIngredients: $rawIngredients, analysisResult: $analysisResult, scanType: $scanType, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HistoryDetailImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.productName, productName) ||
                other.productName == productName) &&
            (identical(other.barcode, barcode) || other.barcode == barcode) &&
            (identical(other.rawIngredients, rawIngredients) ||
                other.rawIngredients == rawIngredients) &&
            const DeepCollectionEquality()
                .equals(other._analysisResult, _analysisResult) &&
            (identical(other.scanType, scanType) ||
                other.scanType == scanType) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      productName,
      barcode,
      rawIngredients,
      const DeepCollectionEquality().hash(_analysisResult),
      scanType,
      createdAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$HistoryDetailImplCopyWith<_$HistoryDetailImpl> get copyWith =>
      __$$HistoryDetailImplCopyWithImpl<_$HistoryDetailImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HistoryDetailImplToJson(
      this,
    );
  }
}

abstract class _HistoryDetail implements HistoryDetail {
  const factory _HistoryDetail(
          {required final String id,
          @JsonKey(name: 'product_name') final String? productName,
          final String? barcode,
          @JsonKey(name: 'raw_ingredients') final String? rawIngredients,
          @JsonKey(name: 'analysis_result')
          final Map<String, dynamic>? analysisResult,
          @JsonKey(name: 'scan_type') required final String scanType,
          @JsonKey(name: 'created_at') required final String createdAt}) =
      _$HistoryDetailImpl;

  factory _HistoryDetail.fromJson(Map<String, dynamic> json) =
      _$HistoryDetailImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'product_name')
  String? get productName;
  @override
  String? get barcode;
  @override
  @JsonKey(name: 'raw_ingredients')
  String? get rawIngredients;
  @override
  @JsonKey(name: 'analysis_result')
  Map<String, dynamic>? get analysisResult;
  @override
  @JsonKey(name: 'scan_type')
  String get scanType;
  @override
  @JsonKey(name: 'created_at')
  String get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$HistoryDetailImplCopyWith<_$HistoryDetailImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

HistoryStats _$HistoryStatsFromJson(Map<String, dynamic> json) {
  return _HistoryStats.fromJson(json);
}

/// @nodoc
mixin _$HistoryStats {
  @JsonKey(name: 'total_scans')
  int get totalScans => throw _privateConstructorUsedError;
  @JsonKey(name: 'by_scan_type')
  Map<String, int> get byScanType => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $HistoryStatsCopyWith<HistoryStats> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HistoryStatsCopyWith<$Res> {
  factory $HistoryStatsCopyWith(
          HistoryStats value, $Res Function(HistoryStats) then) =
      _$HistoryStatsCopyWithImpl<$Res, HistoryStats>;
  @useResult
  $Res call(
      {@JsonKey(name: 'total_scans') int totalScans,
      @JsonKey(name: 'by_scan_type') Map<String, int> byScanType});
}

/// @nodoc
class _$HistoryStatsCopyWithImpl<$Res, $Val extends HistoryStats>
    implements $HistoryStatsCopyWith<$Res> {
  _$HistoryStatsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalScans = null,
    Object? byScanType = null,
  }) {
    return _then(_value.copyWith(
      totalScans: null == totalScans
          ? _value.totalScans
          : totalScans // ignore: cast_nullable_to_non_nullable
              as int,
      byScanType: null == byScanType
          ? _value.byScanType
          : byScanType // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$HistoryStatsImplCopyWith<$Res>
    implements $HistoryStatsCopyWith<$Res> {
  factory _$$HistoryStatsImplCopyWith(
          _$HistoryStatsImpl value, $Res Function(_$HistoryStatsImpl) then) =
      __$$HistoryStatsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'total_scans') int totalScans,
      @JsonKey(name: 'by_scan_type') Map<String, int> byScanType});
}

/// @nodoc
class __$$HistoryStatsImplCopyWithImpl<$Res>
    extends _$HistoryStatsCopyWithImpl<$Res, _$HistoryStatsImpl>
    implements _$$HistoryStatsImplCopyWith<$Res> {
  __$$HistoryStatsImplCopyWithImpl(
      _$HistoryStatsImpl _value, $Res Function(_$HistoryStatsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalScans = null,
    Object? byScanType = null,
  }) {
    return _then(_$HistoryStatsImpl(
      totalScans: null == totalScans
          ? _value.totalScans
          : totalScans // ignore: cast_nullable_to_non_nullable
              as int,
      byScanType: null == byScanType
          ? _value._byScanType
          : byScanType // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$HistoryStatsImpl implements _HistoryStats {
  const _$HistoryStatsImpl(
      {@JsonKey(name: 'total_scans') required this.totalScans,
      @JsonKey(name: 'by_scan_type')
      final Map<String, int> byScanType = const <String, int>{}})
      : _byScanType = byScanType;

  factory _$HistoryStatsImpl.fromJson(Map<String, dynamic> json) =>
      _$$HistoryStatsImplFromJson(json);

  @override
  @JsonKey(name: 'total_scans')
  final int totalScans;
  final Map<String, int> _byScanType;
  @override
  @JsonKey(name: 'by_scan_type')
  Map<String, int> get byScanType {
    if (_byScanType is EqualUnmodifiableMapView) return _byScanType;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_byScanType);
  }

  @override
  String toString() {
    return 'HistoryStats(totalScans: $totalScans, byScanType: $byScanType)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HistoryStatsImpl &&
            (identical(other.totalScans, totalScans) ||
                other.totalScans == totalScans) &&
            const DeepCollectionEquality()
                .equals(other._byScanType, _byScanType));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, totalScans,
      const DeepCollectionEquality().hash(_byScanType));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$HistoryStatsImplCopyWith<_$HistoryStatsImpl> get copyWith =>
      __$$HistoryStatsImplCopyWithImpl<_$HistoryStatsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HistoryStatsImplToJson(
      this,
    );
  }
}

abstract class _HistoryStats implements HistoryStats {
  const factory _HistoryStats(
          {@JsonKey(name: 'total_scans') required final int totalScans,
          @JsonKey(name: 'by_scan_type') final Map<String, int> byScanType}) =
      _$HistoryStatsImpl;

  factory _HistoryStats.fromJson(Map<String, dynamic> json) =
      _$HistoryStatsImpl.fromJson;

  @override
  @JsonKey(name: 'total_scans')
  int get totalScans;
  @override
  @JsonKey(name: 'by_scan_type')
  Map<String, int> get byScanType;
  @override
  @JsonKey(ignore: true)
  _$$HistoryStatsImplCopyWith<_$HistoryStatsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
