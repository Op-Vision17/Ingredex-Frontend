// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'scan_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

BarcodeResult _$BarcodeResultFromJson(Map<String, dynamic> json) {
  return _BarcodeResult.fromJson(json);
}

/// @nodoc
mixin _$BarcodeResult {
  @JsonKey(name: 'product_name')
  String? get productName => throw _privateConstructorUsedError;
  String? get ingredients => throw _privateConstructorUsedError;
  String get barcode => throw _privateConstructorUsedError;
  String get source => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BarcodeResultCopyWith<BarcodeResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BarcodeResultCopyWith<$Res> {
  factory $BarcodeResultCopyWith(
          BarcodeResult value, $Res Function(BarcodeResult) then) =
      _$BarcodeResultCopyWithImpl<$Res, BarcodeResult>;
  @useResult
  $Res call(
      {@JsonKey(name: 'product_name') String? productName,
      String? ingredients,
      String barcode,
      String source});
}

/// @nodoc
class _$BarcodeResultCopyWithImpl<$Res, $Val extends BarcodeResult>
    implements $BarcodeResultCopyWith<$Res> {
  _$BarcodeResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? productName = freezed,
    Object? ingredients = freezed,
    Object? barcode = null,
    Object? source = null,
  }) {
    return _then(_value.copyWith(
      productName: freezed == productName
          ? _value.productName
          : productName // ignore: cast_nullable_to_non_nullable
              as String?,
      ingredients: freezed == ingredients
          ? _value.ingredients
          : ingredients // ignore: cast_nullable_to_non_nullable
              as String?,
      barcode: null == barcode
          ? _value.barcode
          : barcode // ignore: cast_nullable_to_non_nullable
              as String,
      source: null == source
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BarcodeResultImplCopyWith<$Res>
    implements $BarcodeResultCopyWith<$Res> {
  factory _$$BarcodeResultImplCopyWith(
          _$BarcodeResultImpl value, $Res Function(_$BarcodeResultImpl) then) =
      __$$BarcodeResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'product_name') String? productName,
      String? ingredients,
      String barcode,
      String source});
}

/// @nodoc
class __$$BarcodeResultImplCopyWithImpl<$Res>
    extends _$BarcodeResultCopyWithImpl<$Res, _$BarcodeResultImpl>
    implements _$$BarcodeResultImplCopyWith<$Res> {
  __$$BarcodeResultImplCopyWithImpl(
      _$BarcodeResultImpl _value, $Res Function(_$BarcodeResultImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? productName = freezed,
    Object? ingredients = freezed,
    Object? barcode = null,
    Object? source = null,
  }) {
    return _then(_$BarcodeResultImpl(
      productName: freezed == productName
          ? _value.productName
          : productName // ignore: cast_nullable_to_non_nullable
              as String?,
      ingredients: freezed == ingredients
          ? _value.ingredients
          : ingredients // ignore: cast_nullable_to_non_nullable
              as String?,
      barcode: null == barcode
          ? _value.barcode
          : barcode // ignore: cast_nullable_to_non_nullable
              as String,
      source: null == source
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BarcodeResultImpl implements _BarcodeResult {
  const _$BarcodeResultImpl(
      {@JsonKey(name: 'product_name') this.productName,
      this.ingredients,
      required this.barcode,
      required this.source});

  factory _$BarcodeResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$BarcodeResultImplFromJson(json);

  @override
  @JsonKey(name: 'product_name')
  final String? productName;
  @override
  final String? ingredients;
  @override
  final String barcode;
  @override
  final String source;

  @override
  String toString() {
    return 'BarcodeResult(productName: $productName, ingredients: $ingredients, barcode: $barcode, source: $source)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BarcodeResultImpl &&
            (identical(other.productName, productName) ||
                other.productName == productName) &&
            (identical(other.ingredients, ingredients) ||
                other.ingredients == ingredients) &&
            (identical(other.barcode, barcode) || other.barcode == barcode) &&
            (identical(other.source, source) || other.source == source));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, productName, ingredients, barcode, source);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BarcodeResultImplCopyWith<_$BarcodeResultImpl> get copyWith =>
      __$$BarcodeResultImplCopyWithImpl<_$BarcodeResultImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BarcodeResultImplToJson(
      this,
    );
  }
}

abstract class _BarcodeResult implements BarcodeResult {
  const factory _BarcodeResult(
      {@JsonKey(name: 'product_name') final String? productName,
      final String? ingredients,
      required final String barcode,
      required final String source}) = _$BarcodeResultImpl;

  factory _BarcodeResult.fromJson(Map<String, dynamic> json) =
      _$BarcodeResultImpl.fromJson;

  @override
  @JsonKey(name: 'product_name')
  String? get productName;
  @override
  String? get ingredients;
  @override
  String get barcode;
  @override
  String get source;
  @override
  @JsonKey(ignore: true)
  _$$BarcodeResultImplCopyWith<_$BarcodeResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

OcrResult _$OcrResultFromJson(Map<String, dynamic> json) {
  return _OcrResult.fromJson(json);
}

/// @nodoc
mixin _$OcrResult {
  @JsonKey(name: 'extracted_text')
  String get extractedText => throw _privateConstructorUsedError;
  double get confidence => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OcrResultCopyWith<OcrResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OcrResultCopyWith<$Res> {
  factory $OcrResultCopyWith(OcrResult value, $Res Function(OcrResult) then) =
      _$OcrResultCopyWithImpl<$Res, OcrResult>;
  @useResult
  $Res call(
      {@JsonKey(name: 'extracted_text') String extractedText,
      double confidence});
}

/// @nodoc
class _$OcrResultCopyWithImpl<$Res, $Val extends OcrResult>
    implements $OcrResultCopyWith<$Res> {
  _$OcrResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? extractedText = null,
    Object? confidence = null,
  }) {
    return _then(_value.copyWith(
      extractedText: null == extractedText
          ? _value.extractedText
          : extractedText // ignore: cast_nullable_to_non_nullable
              as String,
      confidence: null == confidence
          ? _value.confidence
          : confidence // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OcrResultImplCopyWith<$Res>
    implements $OcrResultCopyWith<$Res> {
  factory _$$OcrResultImplCopyWith(
          _$OcrResultImpl value, $Res Function(_$OcrResultImpl) then) =
      __$$OcrResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'extracted_text') String extractedText,
      double confidence});
}

/// @nodoc
class __$$OcrResultImplCopyWithImpl<$Res>
    extends _$OcrResultCopyWithImpl<$Res, _$OcrResultImpl>
    implements _$$OcrResultImplCopyWith<$Res> {
  __$$OcrResultImplCopyWithImpl(
      _$OcrResultImpl _value, $Res Function(_$OcrResultImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? extractedText = null,
    Object? confidence = null,
  }) {
    return _then(_$OcrResultImpl(
      extractedText: null == extractedText
          ? _value.extractedText
          : extractedText // ignore: cast_nullable_to_non_nullable
              as String,
      confidence: null == confidence
          ? _value.confidence
          : confidence // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OcrResultImpl implements _OcrResult {
  const _$OcrResultImpl(
      {@JsonKey(name: 'extracted_text') required this.extractedText,
      required this.confidence});

  factory _$OcrResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$OcrResultImplFromJson(json);

  @override
  @JsonKey(name: 'extracted_text')
  final String extractedText;
  @override
  final double confidence;

  @override
  String toString() {
    return 'OcrResult(extractedText: $extractedText, confidence: $confidence)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OcrResultImpl &&
            (identical(other.extractedText, extractedText) ||
                other.extractedText == extractedText) &&
            (identical(other.confidence, confidence) ||
                other.confidence == confidence));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, extractedText, confidence);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OcrResultImplCopyWith<_$OcrResultImpl> get copyWith =>
      __$$OcrResultImplCopyWithImpl<_$OcrResultImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OcrResultImplToJson(
      this,
    );
  }
}

abstract class _OcrResult implements OcrResult {
  const factory _OcrResult(
      {@JsonKey(name: 'extracted_text') required final String extractedText,
      required final double confidence}) = _$OcrResultImpl;

  factory _OcrResult.fromJson(Map<String, dynamic> json) =
      _$OcrResultImpl.fromJson;

  @override
  @JsonKey(name: 'extracted_text')
  String get extractedText;
  @override
  double get confidence;
  @override
  @JsonKey(ignore: true)
  _$$OcrResultImplCopyWith<_$OcrResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

IngredientIssue _$IngredientIssueFromJson(Map<String, dynamic> json) {
  return _IngredientIssue.fromJson(json);
}

/// @nodoc
mixin _$IngredientIssue {
  String get ingredient => throw _privateConstructorUsedError;
  String get risk => throw _privateConstructorUsedError;
  String get reason => throw _privateConstructorUsedError;
  @JsonKey(name: 'source_domain')
  String get sourceDomain => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $IngredientIssueCopyWith<IngredientIssue> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IngredientIssueCopyWith<$Res> {
  factory $IngredientIssueCopyWith(
          IngredientIssue value, $Res Function(IngredientIssue) then) =
      _$IngredientIssueCopyWithImpl<$Res, IngredientIssue>;
  @useResult
  $Res call(
      {String ingredient,
      String risk,
      String reason,
      @JsonKey(name: 'source_domain') String sourceDomain});
}

/// @nodoc
class _$IngredientIssueCopyWithImpl<$Res, $Val extends IngredientIssue>
    implements $IngredientIssueCopyWith<$Res> {
  _$IngredientIssueCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ingredient = null,
    Object? risk = null,
    Object? reason = null,
    Object? sourceDomain = null,
  }) {
    return _then(_value.copyWith(
      ingredient: null == ingredient
          ? _value.ingredient
          : ingredient // ignore: cast_nullable_to_non_nullable
              as String,
      risk: null == risk
          ? _value.risk
          : risk // ignore: cast_nullable_to_non_nullable
              as String,
      reason: null == reason
          ? _value.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String,
      sourceDomain: null == sourceDomain
          ? _value.sourceDomain
          : sourceDomain // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$IngredientIssueImplCopyWith<$Res>
    implements $IngredientIssueCopyWith<$Res> {
  factory _$$IngredientIssueImplCopyWith(_$IngredientIssueImpl value,
          $Res Function(_$IngredientIssueImpl) then) =
      __$$IngredientIssueImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String ingredient,
      String risk,
      String reason,
      @JsonKey(name: 'source_domain') String sourceDomain});
}

/// @nodoc
class __$$IngredientIssueImplCopyWithImpl<$Res>
    extends _$IngredientIssueCopyWithImpl<$Res, _$IngredientIssueImpl>
    implements _$$IngredientIssueImplCopyWith<$Res> {
  __$$IngredientIssueImplCopyWithImpl(
      _$IngredientIssueImpl _value, $Res Function(_$IngredientIssueImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ingredient = null,
    Object? risk = null,
    Object? reason = null,
    Object? sourceDomain = null,
  }) {
    return _then(_$IngredientIssueImpl(
      ingredient: null == ingredient
          ? _value.ingredient
          : ingredient // ignore: cast_nullable_to_non_nullable
              as String,
      risk: null == risk
          ? _value.risk
          : risk // ignore: cast_nullable_to_non_nullable
              as String,
      reason: null == reason
          ? _value.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String,
      sourceDomain: null == sourceDomain
          ? _value.sourceDomain
          : sourceDomain // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$IngredientIssueImpl implements _IngredientIssue {
  const _$IngredientIssueImpl(
      {required this.ingredient,
      required this.risk,
      required this.reason,
      @JsonKey(name: 'source_domain') this.sourceDomain = ''});

  factory _$IngredientIssueImpl.fromJson(Map<String, dynamic> json) =>
      _$$IngredientIssueImplFromJson(json);

  @override
  final String ingredient;
  @override
  final String risk;
  @override
  final String reason;
  @override
  @JsonKey(name: 'source_domain')
  final String sourceDomain;

  @override
  String toString() {
    return 'IngredientIssue(ingredient: $ingredient, risk: $risk, reason: $reason, sourceDomain: $sourceDomain)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IngredientIssueImpl &&
            (identical(other.ingredient, ingredient) ||
                other.ingredient == ingredient) &&
            (identical(other.risk, risk) || other.risk == risk) &&
            (identical(other.reason, reason) || other.reason == reason) &&
            (identical(other.sourceDomain, sourceDomain) ||
                other.sourceDomain == sourceDomain));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, ingredient, risk, reason, sourceDomain);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$IngredientIssueImplCopyWith<_$IngredientIssueImpl> get copyWith =>
      __$$IngredientIssueImplCopyWithImpl<_$IngredientIssueImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$IngredientIssueImplToJson(
      this,
    );
  }
}

abstract class _IngredientIssue implements IngredientIssue {
  const factory _IngredientIssue(
          {required final String ingredient,
          required final String risk,
          required final String reason,
          @JsonKey(name: 'source_domain') final String sourceDomain}) =
      _$IngredientIssueImpl;

  factory _IngredientIssue.fromJson(Map<String, dynamic> json) =
      _$IngredientIssueImpl.fromJson;

  @override
  String get ingredient;
  @override
  String get risk;
  @override
  String get reason;
  @override
  @JsonKey(name: 'source_domain')
  String get sourceDomain;
  @override
  @JsonKey(ignore: true)
  _$$IngredientIssueImplCopyWith<_$IngredientIssueImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

GoodIngredient _$GoodIngredientFromJson(Map<String, dynamic> json) {
  return _GoodIngredient.fromJson(json);
}

/// @nodoc
mixin _$GoodIngredient {
  String get ingredient => throw _privateConstructorUsedError;
  String get benefit => throw _privateConstructorUsedError;
  @JsonKey(name: 'source_domain')
  String get sourceDomain => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GoodIngredientCopyWith<GoodIngredient> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GoodIngredientCopyWith<$Res> {
  factory $GoodIngredientCopyWith(
          GoodIngredient value, $Res Function(GoodIngredient) then) =
      _$GoodIngredientCopyWithImpl<$Res, GoodIngredient>;
  @useResult
  $Res call(
      {String ingredient,
      String benefit,
      @JsonKey(name: 'source_domain') String sourceDomain});
}

/// @nodoc
class _$GoodIngredientCopyWithImpl<$Res, $Val extends GoodIngredient>
    implements $GoodIngredientCopyWith<$Res> {
  _$GoodIngredientCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ingredient = null,
    Object? benefit = null,
    Object? sourceDomain = null,
  }) {
    return _then(_value.copyWith(
      ingredient: null == ingredient
          ? _value.ingredient
          : ingredient // ignore: cast_nullable_to_non_nullable
              as String,
      benefit: null == benefit
          ? _value.benefit
          : benefit // ignore: cast_nullable_to_non_nullable
              as String,
      sourceDomain: null == sourceDomain
          ? _value.sourceDomain
          : sourceDomain // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GoodIngredientImplCopyWith<$Res>
    implements $GoodIngredientCopyWith<$Res> {
  factory _$$GoodIngredientImplCopyWith(_$GoodIngredientImpl value,
          $Res Function(_$GoodIngredientImpl) then) =
      __$$GoodIngredientImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String ingredient,
      String benefit,
      @JsonKey(name: 'source_domain') String sourceDomain});
}

/// @nodoc
class __$$GoodIngredientImplCopyWithImpl<$Res>
    extends _$GoodIngredientCopyWithImpl<$Res, _$GoodIngredientImpl>
    implements _$$GoodIngredientImplCopyWith<$Res> {
  __$$GoodIngredientImplCopyWithImpl(
      _$GoodIngredientImpl _value, $Res Function(_$GoodIngredientImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ingredient = null,
    Object? benefit = null,
    Object? sourceDomain = null,
  }) {
    return _then(_$GoodIngredientImpl(
      ingredient: null == ingredient
          ? _value.ingredient
          : ingredient // ignore: cast_nullable_to_non_nullable
              as String,
      benefit: null == benefit
          ? _value.benefit
          : benefit // ignore: cast_nullable_to_non_nullable
              as String,
      sourceDomain: null == sourceDomain
          ? _value.sourceDomain
          : sourceDomain // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GoodIngredientImpl implements _GoodIngredient {
  const _$GoodIngredientImpl(
      {required this.ingredient,
      required this.benefit,
      @JsonKey(name: 'source_domain') this.sourceDomain = ''});

  factory _$GoodIngredientImpl.fromJson(Map<String, dynamic> json) =>
      _$$GoodIngredientImplFromJson(json);

  @override
  final String ingredient;
  @override
  final String benefit;
  @override
  @JsonKey(name: 'source_domain')
  final String sourceDomain;

  @override
  String toString() {
    return 'GoodIngredient(ingredient: $ingredient, benefit: $benefit, sourceDomain: $sourceDomain)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GoodIngredientImpl &&
            (identical(other.ingredient, ingredient) ||
                other.ingredient == ingredient) &&
            (identical(other.benefit, benefit) || other.benefit == benefit) &&
            (identical(other.sourceDomain, sourceDomain) ||
                other.sourceDomain == sourceDomain));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, ingredient, benefit, sourceDomain);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GoodIngredientImplCopyWith<_$GoodIngredientImpl> get copyWith =>
      __$$GoodIngredientImplCopyWithImpl<_$GoodIngredientImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GoodIngredientImplToJson(
      this,
    );
  }
}

abstract class _GoodIngredient implements GoodIngredient {
  const factory _GoodIngredient(
          {required final String ingredient,
          required final String benefit,
          @JsonKey(name: 'source_domain') final String sourceDomain}) =
      _$GoodIngredientImpl;

  factory _GoodIngredient.fromJson(Map<String, dynamic> json) =
      _$GoodIngredientImpl.fromJson;

  @override
  String get ingredient;
  @override
  String get benefit;
  @override
  @JsonKey(name: 'source_domain')
  String get sourceDomain;
  @override
  @JsonKey(ignore: true)
  _$$GoodIngredientImplCopyWith<_$GoodIngredientImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Alternative _$AlternativeFromJson(Map<String, dynamic> json) {
  return _Alternative.fromJson(json);
}

/// @nodoc
mixin _$Alternative {
  String get name => throw _privateConstructorUsedError;
  String get reason => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AlternativeCopyWith<Alternative> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AlternativeCopyWith<$Res> {
  factory $AlternativeCopyWith(
          Alternative value, $Res Function(Alternative) then) =
      _$AlternativeCopyWithImpl<$Res, Alternative>;
  @useResult
  $Res call({String name, String reason});
}

/// @nodoc
class _$AlternativeCopyWithImpl<$Res, $Val extends Alternative>
    implements $AlternativeCopyWith<$Res> {
  _$AlternativeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? reason = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      reason: null == reason
          ? _value.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AlternativeImplCopyWith<$Res>
    implements $AlternativeCopyWith<$Res> {
  factory _$$AlternativeImplCopyWith(
          _$AlternativeImpl value, $Res Function(_$AlternativeImpl) then) =
      __$$AlternativeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, String reason});
}

/// @nodoc
class __$$AlternativeImplCopyWithImpl<$Res>
    extends _$AlternativeCopyWithImpl<$Res, _$AlternativeImpl>
    implements _$$AlternativeImplCopyWith<$Res> {
  __$$AlternativeImplCopyWithImpl(
      _$AlternativeImpl _value, $Res Function(_$AlternativeImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? reason = null,
  }) {
    return _then(_$AlternativeImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      reason: null == reason
          ? _value.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AlternativeImpl implements _Alternative {
  const _$AlternativeImpl({required this.name, required this.reason});

  factory _$AlternativeImpl.fromJson(Map<String, dynamic> json) =>
      _$$AlternativeImplFromJson(json);

  @override
  final String name;
  @override
  final String reason;

  @override
  String toString() {
    return 'Alternative(name: $name, reason: $reason)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AlternativeImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.reason, reason) || other.reason == reason));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name, reason);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AlternativeImplCopyWith<_$AlternativeImpl> get copyWith =>
      __$$AlternativeImplCopyWithImpl<_$AlternativeImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AlternativeImplToJson(
      this,
    );
  }
}

abstract class _Alternative implements Alternative {
  const factory _Alternative(
      {required final String name,
      required final String reason}) = _$AlternativeImpl;

  factory _Alternative.fromJson(Map<String, dynamic> json) =
      _$AlternativeImpl.fromJson;

  @override
  String get name;
  @override
  String get reason;
  @override
  @JsonKey(ignore: true)
  _$$AlternativeImplCopyWith<_$AlternativeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UserInsight _$UserInsightFromJson(Map<String, dynamic> json) {
  return _UserInsight.fromJson(json);
}

/// @nodoc
mixin _$UserInsight {
  String get impact => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserInsightCopyWith<UserInsight> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserInsightCopyWith<$Res> {
  factory $UserInsightCopyWith(
          UserInsight value, $Res Function(UserInsight) then) =
      _$UserInsightCopyWithImpl<$Res, UserInsight>;
  @useResult
  $Res call({String impact, String title, String description});
}

/// @nodoc
class _$UserInsightCopyWithImpl<$Res, $Val extends UserInsight>
    implements $UserInsightCopyWith<$Res> {
  _$UserInsightCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? impact = null,
    Object? title = null,
    Object? description = null,
  }) {
    return _then(_value.copyWith(
      impact: null == impact
          ? _value.impact
          : impact // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserInsightImplCopyWith<$Res>
    implements $UserInsightCopyWith<$Res> {
  factory _$$UserInsightImplCopyWith(
          _$UserInsightImpl value, $Res Function(_$UserInsightImpl) then) =
      __$$UserInsightImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String impact, String title, String description});
}

/// @nodoc
class __$$UserInsightImplCopyWithImpl<$Res>
    extends _$UserInsightCopyWithImpl<$Res, _$UserInsightImpl>
    implements _$$UserInsightImplCopyWith<$Res> {
  __$$UserInsightImplCopyWithImpl(
      _$UserInsightImpl _value, $Res Function(_$UserInsightImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? impact = null,
    Object? title = null,
    Object? description = null,
  }) {
    return _then(_$UserInsightImpl(
      impact: null == impact
          ? _value.impact
          : impact // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserInsightImpl implements _UserInsight {
  const _$UserInsightImpl(
      {required this.impact, required this.title, required this.description});

  factory _$UserInsightImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserInsightImplFromJson(json);

  @override
  final String impact;
  @override
  final String title;
  @override
  final String description;

  @override
  String toString() {
    return 'UserInsight(impact: $impact, title: $title, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserInsightImpl &&
            (identical(other.impact, impact) || other.impact == impact) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, impact, title, description);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UserInsightImplCopyWith<_$UserInsightImpl> get copyWith =>
      __$$UserInsightImplCopyWithImpl<_$UserInsightImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserInsightImplToJson(
      this,
    );
  }
}

abstract class _UserInsight implements UserInsight {
  const factory _UserInsight(
      {required final String impact,
      required final String title,
      required final String description}) = _$UserInsightImpl;

  factory _UserInsight.fromJson(Map<String, dynamic> json) =
      _$UserInsightImpl.fromJson;

  @override
  String get impact;
  @override
  String get title;
  @override
  String get description;
  @override
  @JsonKey(ignore: true)
  _$$UserInsightImplCopyWith<_$UserInsightImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AnalysisResult _$AnalysisResultFromJson(Map<String, dynamic> json) {
  return _AnalysisResult.fromJson(json);
}

/// @nodoc
mixin _$AnalysisResult {
  @JsonKey(name: 'health_score')
  int get healthScore => throw _privateConstructorUsedError;
  @JsonKey(name: 'risk_level')
  String get riskLevel => throw _privateConstructorUsedError;
  List<IngredientIssue> get issues => throw _privateConstructorUsedError;
  @JsonKey(name: 'good_ingredients')
  List<GoodIngredient> get goodIngredients =>
      throw _privateConstructorUsedError;
  List<Alternative> get alternatives => throw _privateConstructorUsedError;
  String get summary => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_insights')
  List<UserInsight> get userInsights => throw _privateConstructorUsedError;
  @JsonKey(name: 'sources_used')
  List<String> get sourcesUsed => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AnalysisResultCopyWith<AnalysisResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AnalysisResultCopyWith<$Res> {
  factory $AnalysisResultCopyWith(
          AnalysisResult value, $Res Function(AnalysisResult) then) =
      _$AnalysisResultCopyWithImpl<$Res, AnalysisResult>;
  @useResult
  $Res call(
      {@JsonKey(name: 'health_score') int healthScore,
      @JsonKey(name: 'risk_level') String riskLevel,
      List<IngredientIssue> issues,
      @JsonKey(name: 'good_ingredients') List<GoodIngredient> goodIngredients,
      List<Alternative> alternatives,
      String summary,
      @JsonKey(name: 'user_insights') List<UserInsight> userInsights,
      @JsonKey(name: 'sources_used') List<String> sourcesUsed});
}

/// @nodoc
class _$AnalysisResultCopyWithImpl<$Res, $Val extends AnalysisResult>
    implements $AnalysisResultCopyWith<$Res> {
  _$AnalysisResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? healthScore = null,
    Object? riskLevel = null,
    Object? issues = null,
    Object? goodIngredients = null,
    Object? alternatives = null,
    Object? summary = null,
    Object? userInsights = null,
    Object? sourcesUsed = null,
  }) {
    return _then(_value.copyWith(
      healthScore: null == healthScore
          ? _value.healthScore
          : healthScore // ignore: cast_nullable_to_non_nullable
              as int,
      riskLevel: null == riskLevel
          ? _value.riskLevel
          : riskLevel // ignore: cast_nullable_to_non_nullable
              as String,
      issues: null == issues
          ? _value.issues
          : issues // ignore: cast_nullable_to_non_nullable
              as List<IngredientIssue>,
      goodIngredients: null == goodIngredients
          ? _value.goodIngredients
          : goodIngredients // ignore: cast_nullable_to_non_nullable
              as List<GoodIngredient>,
      alternatives: null == alternatives
          ? _value.alternatives
          : alternatives // ignore: cast_nullable_to_non_nullable
              as List<Alternative>,
      summary: null == summary
          ? _value.summary
          : summary // ignore: cast_nullable_to_non_nullable
              as String,
      userInsights: null == userInsights
          ? _value.userInsights
          : userInsights // ignore: cast_nullable_to_non_nullable
              as List<UserInsight>,
      sourcesUsed: null == sourcesUsed
          ? _value.sourcesUsed
          : sourcesUsed // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AnalysisResultImplCopyWith<$Res>
    implements $AnalysisResultCopyWith<$Res> {
  factory _$$AnalysisResultImplCopyWith(_$AnalysisResultImpl value,
          $Res Function(_$AnalysisResultImpl) then) =
      __$$AnalysisResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'health_score') int healthScore,
      @JsonKey(name: 'risk_level') String riskLevel,
      List<IngredientIssue> issues,
      @JsonKey(name: 'good_ingredients') List<GoodIngredient> goodIngredients,
      List<Alternative> alternatives,
      String summary,
      @JsonKey(name: 'user_insights') List<UserInsight> userInsights,
      @JsonKey(name: 'sources_used') List<String> sourcesUsed});
}

/// @nodoc
class __$$AnalysisResultImplCopyWithImpl<$Res>
    extends _$AnalysisResultCopyWithImpl<$Res, _$AnalysisResultImpl>
    implements _$$AnalysisResultImplCopyWith<$Res> {
  __$$AnalysisResultImplCopyWithImpl(
      _$AnalysisResultImpl _value, $Res Function(_$AnalysisResultImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? healthScore = null,
    Object? riskLevel = null,
    Object? issues = null,
    Object? goodIngredients = null,
    Object? alternatives = null,
    Object? summary = null,
    Object? userInsights = null,
    Object? sourcesUsed = null,
  }) {
    return _then(_$AnalysisResultImpl(
      healthScore: null == healthScore
          ? _value.healthScore
          : healthScore // ignore: cast_nullable_to_non_nullable
              as int,
      riskLevel: null == riskLevel
          ? _value.riskLevel
          : riskLevel // ignore: cast_nullable_to_non_nullable
              as String,
      issues: null == issues
          ? _value._issues
          : issues // ignore: cast_nullable_to_non_nullable
              as List<IngredientIssue>,
      goodIngredients: null == goodIngredients
          ? _value._goodIngredients
          : goodIngredients // ignore: cast_nullable_to_non_nullable
              as List<GoodIngredient>,
      alternatives: null == alternatives
          ? _value._alternatives
          : alternatives // ignore: cast_nullable_to_non_nullable
              as List<Alternative>,
      summary: null == summary
          ? _value.summary
          : summary // ignore: cast_nullable_to_non_nullable
              as String,
      userInsights: null == userInsights
          ? _value._userInsights
          : userInsights // ignore: cast_nullable_to_non_nullable
              as List<UserInsight>,
      sourcesUsed: null == sourcesUsed
          ? _value._sourcesUsed
          : sourcesUsed // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AnalysisResultImpl implements _AnalysisResult {
  const _$AnalysisResultImpl(
      {@JsonKey(name: 'health_score') required this.healthScore,
      @JsonKey(name: 'risk_level') required this.riskLevel,
      final List<IngredientIssue> issues = const <IngredientIssue>[],
      @JsonKey(name: 'good_ingredients')
      final List<GoodIngredient> goodIngredients = const <GoodIngredient>[],
      final List<Alternative> alternatives = const <Alternative>[],
      required this.summary,
      @JsonKey(name: 'user_insights')
      final List<UserInsight> userInsights = const <UserInsight>[],
      @JsonKey(name: 'sources_used')
      final List<String> sourcesUsed = const <String>[]})
      : _issues = issues,
        _goodIngredients = goodIngredients,
        _alternatives = alternatives,
        _userInsights = userInsights,
        _sourcesUsed = sourcesUsed;

  factory _$AnalysisResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$AnalysisResultImplFromJson(json);

  @override
  @JsonKey(name: 'health_score')
  final int healthScore;
  @override
  @JsonKey(name: 'risk_level')
  final String riskLevel;
  final List<IngredientIssue> _issues;
  @override
  @JsonKey()
  List<IngredientIssue> get issues {
    if (_issues is EqualUnmodifiableListView) return _issues;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_issues);
  }

  final List<GoodIngredient> _goodIngredients;
  @override
  @JsonKey(name: 'good_ingredients')
  List<GoodIngredient> get goodIngredients {
    if (_goodIngredients is EqualUnmodifiableListView) return _goodIngredients;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_goodIngredients);
  }

  final List<Alternative> _alternatives;
  @override
  @JsonKey()
  List<Alternative> get alternatives {
    if (_alternatives is EqualUnmodifiableListView) return _alternatives;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_alternatives);
  }

  @override
  final String summary;
  final List<UserInsight> _userInsights;
  @override
  @JsonKey(name: 'user_insights')
  List<UserInsight> get userInsights {
    if (_userInsights is EqualUnmodifiableListView) return _userInsights;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_userInsights);
  }

  final List<String> _sourcesUsed;
  @override
  @JsonKey(name: 'sources_used')
  List<String> get sourcesUsed {
    if (_sourcesUsed is EqualUnmodifiableListView) return _sourcesUsed;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_sourcesUsed);
  }

  @override
  String toString() {
    return 'AnalysisResult(healthScore: $healthScore, riskLevel: $riskLevel, issues: $issues, goodIngredients: $goodIngredients, alternatives: $alternatives, summary: $summary, userInsights: $userInsights, sourcesUsed: $sourcesUsed)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AnalysisResultImpl &&
            (identical(other.healthScore, healthScore) ||
                other.healthScore == healthScore) &&
            (identical(other.riskLevel, riskLevel) ||
                other.riskLevel == riskLevel) &&
            const DeepCollectionEquality().equals(other._issues, _issues) &&
            const DeepCollectionEquality()
                .equals(other._goodIngredients, _goodIngredients) &&
            const DeepCollectionEquality()
                .equals(other._alternatives, _alternatives) &&
            (identical(other.summary, summary) || other.summary == summary) &&
            const DeepCollectionEquality()
                .equals(other._userInsights, _userInsights) &&
            const DeepCollectionEquality()
                .equals(other._sourcesUsed, _sourcesUsed));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      healthScore,
      riskLevel,
      const DeepCollectionEquality().hash(_issues),
      const DeepCollectionEquality().hash(_goodIngredients),
      const DeepCollectionEquality().hash(_alternatives),
      summary,
      const DeepCollectionEquality().hash(_userInsights),
      const DeepCollectionEquality().hash(_sourcesUsed));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AnalysisResultImplCopyWith<_$AnalysisResultImpl> get copyWith =>
      __$$AnalysisResultImplCopyWithImpl<_$AnalysisResultImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AnalysisResultImplToJson(
      this,
    );
  }
}

abstract class _AnalysisResult implements AnalysisResult {
  const factory _AnalysisResult(
          {@JsonKey(name: 'health_score') required final int healthScore,
          @JsonKey(name: 'risk_level') required final String riskLevel,
          final List<IngredientIssue> issues,
          @JsonKey(name: 'good_ingredients')
          final List<GoodIngredient> goodIngredients,
          final List<Alternative> alternatives,
          required final String summary,
          @JsonKey(name: 'user_insights') final List<UserInsight> userInsights,
          @JsonKey(name: 'sources_used') final List<String> sourcesUsed}) =
      _$AnalysisResultImpl;

  factory _AnalysisResult.fromJson(Map<String, dynamic> json) =
      _$AnalysisResultImpl.fromJson;

  @override
  @JsonKey(name: 'health_score')
  int get healthScore;
  @override
  @JsonKey(name: 'risk_level')
  String get riskLevel;
  @override
  List<IngredientIssue> get issues;
  @override
  @JsonKey(name: 'good_ingredients')
  List<GoodIngredient> get goodIngredients;
  @override
  List<Alternative> get alternatives;
  @override
  String get summary;
  @override
  @JsonKey(name: 'user_insights')
  List<UserInsight> get userInsights;
  @override
  @JsonKey(name: 'sources_used')
  List<String> get sourcesUsed;
  @override
  @JsonKey(ignore: true)
  _$$AnalysisResultImplCopyWith<_$AnalysisResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AnalyzeResponse _$AnalyzeResponseFromJson(Map<String, dynamic> json) {
  return _AnalyzeResponse.fromJson(json);
}

/// @nodoc
mixin _$AnalyzeResponse {
  AnalysisResult get analysis => throw _privateConstructorUsedError;
  @JsonKey(name: 'product_name')
  String? get productName => throw _privateConstructorUsedError;
  @JsonKey(name: 'scan_id')
  String? get scanId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AnalyzeResponseCopyWith<AnalyzeResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AnalyzeResponseCopyWith<$Res> {
  factory $AnalyzeResponseCopyWith(
          AnalyzeResponse value, $Res Function(AnalyzeResponse) then) =
      _$AnalyzeResponseCopyWithImpl<$Res, AnalyzeResponse>;
  @useResult
  $Res call(
      {AnalysisResult analysis,
      @JsonKey(name: 'product_name') String? productName,
      @JsonKey(name: 'scan_id') String? scanId});

  $AnalysisResultCopyWith<$Res> get analysis;
}

/// @nodoc
class _$AnalyzeResponseCopyWithImpl<$Res, $Val extends AnalyzeResponse>
    implements $AnalyzeResponseCopyWith<$Res> {
  _$AnalyzeResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? analysis = null,
    Object? productName = freezed,
    Object? scanId = freezed,
  }) {
    return _then(_value.copyWith(
      analysis: null == analysis
          ? _value.analysis
          : analysis // ignore: cast_nullable_to_non_nullable
              as AnalysisResult,
      productName: freezed == productName
          ? _value.productName
          : productName // ignore: cast_nullable_to_non_nullable
              as String?,
      scanId: freezed == scanId
          ? _value.scanId
          : scanId // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $AnalysisResultCopyWith<$Res> get analysis {
    return $AnalysisResultCopyWith<$Res>(_value.analysis, (value) {
      return _then(_value.copyWith(analysis: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AnalyzeResponseImplCopyWith<$Res>
    implements $AnalyzeResponseCopyWith<$Res> {
  factory _$$AnalyzeResponseImplCopyWith(_$AnalyzeResponseImpl value,
          $Res Function(_$AnalyzeResponseImpl) then) =
      __$$AnalyzeResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {AnalysisResult analysis,
      @JsonKey(name: 'product_name') String? productName,
      @JsonKey(name: 'scan_id') String? scanId});

  @override
  $AnalysisResultCopyWith<$Res> get analysis;
}

/// @nodoc
class __$$AnalyzeResponseImplCopyWithImpl<$Res>
    extends _$AnalyzeResponseCopyWithImpl<$Res, _$AnalyzeResponseImpl>
    implements _$$AnalyzeResponseImplCopyWith<$Res> {
  __$$AnalyzeResponseImplCopyWithImpl(
      _$AnalyzeResponseImpl _value, $Res Function(_$AnalyzeResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? analysis = null,
    Object? productName = freezed,
    Object? scanId = freezed,
  }) {
    return _then(_$AnalyzeResponseImpl(
      analysis: null == analysis
          ? _value.analysis
          : analysis // ignore: cast_nullable_to_non_nullable
              as AnalysisResult,
      productName: freezed == productName
          ? _value.productName
          : productName // ignore: cast_nullable_to_non_nullable
              as String?,
      scanId: freezed == scanId
          ? _value.scanId
          : scanId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AnalyzeResponseImpl implements _AnalyzeResponse {
  const _$AnalyzeResponseImpl(
      {required this.analysis,
      @JsonKey(name: 'product_name') this.productName,
      @JsonKey(name: 'scan_id') this.scanId});

  factory _$AnalyzeResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$AnalyzeResponseImplFromJson(json);

  @override
  final AnalysisResult analysis;
  @override
  @JsonKey(name: 'product_name')
  final String? productName;
  @override
  @JsonKey(name: 'scan_id')
  final String? scanId;

  @override
  String toString() {
    return 'AnalyzeResponse(analysis: $analysis, productName: $productName, scanId: $scanId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AnalyzeResponseImpl &&
            (identical(other.analysis, analysis) ||
                other.analysis == analysis) &&
            (identical(other.productName, productName) ||
                other.productName == productName) &&
            (identical(other.scanId, scanId) || other.scanId == scanId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, analysis, productName, scanId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AnalyzeResponseImplCopyWith<_$AnalyzeResponseImpl> get copyWith =>
      __$$AnalyzeResponseImplCopyWithImpl<_$AnalyzeResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AnalyzeResponseImplToJson(
      this,
    );
  }
}

abstract class _AnalyzeResponse implements AnalyzeResponse {
  const factory _AnalyzeResponse(
      {required final AnalysisResult analysis,
      @JsonKey(name: 'product_name') final String? productName,
      @JsonKey(name: 'scan_id') final String? scanId}) = _$AnalyzeResponseImpl;

  factory _AnalyzeResponse.fromJson(Map<String, dynamic> json) =
      _$AnalyzeResponseImpl.fromJson;

  @override
  AnalysisResult get analysis;
  @override
  @JsonKey(name: 'product_name')
  String? get productName;
  @override
  @JsonKey(name: 'scan_id')
  String? get scanId;
  @override
  @JsonKey(ignore: true)
  _$$AnalyzeResponseImplCopyWith<_$AnalyzeResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
