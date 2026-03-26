// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'scan_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ScanState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() scanning,
    required TResult Function(dynamic result) scanned,
    required TResult Function() analyzing,
    required TResult Function(AnalyzeResponse result) analyzed,
    required TResult Function(String message) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function()? scanning,
    TResult? Function(dynamic result)? scanned,
    TResult? Function()? analyzing,
    TResult? Function(AnalyzeResponse result)? analyzed,
    TResult? Function(String message)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? scanning,
    TResult Function(dynamic result)? scanned,
    TResult Function()? analyzing,
    TResult Function(AnalyzeResponse result)? analyzed,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Idle value) idle,
    required TResult Function(_Scanning value) scanning,
    required TResult Function(_Scanned value) scanned,
    required TResult Function(_Analyzing value) analyzing,
    required TResult Function(_Analyzed value) analyzed,
    required TResult Function(_Error value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Idle value)? idle,
    TResult? Function(_Scanning value)? scanning,
    TResult? Function(_Scanned value)? scanned,
    TResult? Function(_Analyzing value)? analyzing,
    TResult? Function(_Analyzed value)? analyzed,
    TResult? Function(_Error value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Idle value)? idle,
    TResult Function(_Scanning value)? scanning,
    TResult Function(_Scanned value)? scanned,
    TResult Function(_Analyzing value)? analyzing,
    TResult Function(_Analyzed value)? analyzed,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ScanStateCopyWith<$Res> {
  factory $ScanStateCopyWith(ScanState value, $Res Function(ScanState) then) =
      _$ScanStateCopyWithImpl<$Res, ScanState>;
}

/// @nodoc
class _$ScanStateCopyWithImpl<$Res, $Val extends ScanState>
    implements $ScanStateCopyWith<$Res> {
  _$ScanStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$IdleImplCopyWith<$Res> {
  factory _$$IdleImplCopyWith(
          _$IdleImpl value, $Res Function(_$IdleImpl) then) =
      __$$IdleImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$IdleImplCopyWithImpl<$Res>
    extends _$ScanStateCopyWithImpl<$Res, _$IdleImpl>
    implements _$$IdleImplCopyWith<$Res> {
  __$$IdleImplCopyWithImpl(_$IdleImpl _value, $Res Function(_$IdleImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$IdleImpl implements _Idle {
  const _$IdleImpl();

  @override
  String toString() {
    return 'ScanState.idle()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$IdleImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() scanning,
    required TResult Function(dynamic result) scanned,
    required TResult Function() analyzing,
    required TResult Function(AnalyzeResponse result) analyzed,
    required TResult Function(String message) error,
  }) {
    return idle();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function()? scanning,
    TResult? Function(dynamic result)? scanned,
    TResult? Function()? analyzing,
    TResult? Function(AnalyzeResponse result)? analyzed,
    TResult? Function(String message)? error,
  }) {
    return idle?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? scanning,
    TResult Function(dynamic result)? scanned,
    TResult Function()? analyzing,
    TResult Function(AnalyzeResponse result)? analyzed,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (idle != null) {
      return idle();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Idle value) idle,
    required TResult Function(_Scanning value) scanning,
    required TResult Function(_Scanned value) scanned,
    required TResult Function(_Analyzing value) analyzing,
    required TResult Function(_Analyzed value) analyzed,
    required TResult Function(_Error value) error,
  }) {
    return idle(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Idle value)? idle,
    TResult? Function(_Scanning value)? scanning,
    TResult? Function(_Scanned value)? scanned,
    TResult? Function(_Analyzing value)? analyzing,
    TResult? Function(_Analyzed value)? analyzed,
    TResult? Function(_Error value)? error,
  }) {
    return idle?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Idle value)? idle,
    TResult Function(_Scanning value)? scanning,
    TResult Function(_Scanned value)? scanned,
    TResult Function(_Analyzing value)? analyzing,
    TResult Function(_Analyzed value)? analyzed,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (idle != null) {
      return idle(this);
    }
    return orElse();
  }
}

abstract class _Idle implements ScanState {
  const factory _Idle() = _$IdleImpl;
}

/// @nodoc
abstract class _$$ScanningImplCopyWith<$Res> {
  factory _$$ScanningImplCopyWith(
          _$ScanningImpl value, $Res Function(_$ScanningImpl) then) =
      __$$ScanningImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ScanningImplCopyWithImpl<$Res>
    extends _$ScanStateCopyWithImpl<$Res, _$ScanningImpl>
    implements _$$ScanningImplCopyWith<$Res> {
  __$$ScanningImplCopyWithImpl(
      _$ScanningImpl _value, $Res Function(_$ScanningImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$ScanningImpl implements _Scanning {
  const _$ScanningImpl();

  @override
  String toString() {
    return 'ScanState.scanning()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ScanningImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() scanning,
    required TResult Function(dynamic result) scanned,
    required TResult Function() analyzing,
    required TResult Function(AnalyzeResponse result) analyzed,
    required TResult Function(String message) error,
  }) {
    return scanning();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function()? scanning,
    TResult? Function(dynamic result)? scanned,
    TResult? Function()? analyzing,
    TResult? Function(AnalyzeResponse result)? analyzed,
    TResult? Function(String message)? error,
  }) {
    return scanning?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? scanning,
    TResult Function(dynamic result)? scanned,
    TResult Function()? analyzing,
    TResult Function(AnalyzeResponse result)? analyzed,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (scanning != null) {
      return scanning();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Idle value) idle,
    required TResult Function(_Scanning value) scanning,
    required TResult Function(_Scanned value) scanned,
    required TResult Function(_Analyzing value) analyzing,
    required TResult Function(_Analyzed value) analyzed,
    required TResult Function(_Error value) error,
  }) {
    return scanning(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Idle value)? idle,
    TResult? Function(_Scanning value)? scanning,
    TResult? Function(_Scanned value)? scanned,
    TResult? Function(_Analyzing value)? analyzing,
    TResult? Function(_Analyzed value)? analyzed,
    TResult? Function(_Error value)? error,
  }) {
    return scanning?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Idle value)? idle,
    TResult Function(_Scanning value)? scanning,
    TResult Function(_Scanned value)? scanned,
    TResult Function(_Analyzing value)? analyzing,
    TResult Function(_Analyzed value)? analyzed,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (scanning != null) {
      return scanning(this);
    }
    return orElse();
  }
}

abstract class _Scanning implements ScanState {
  const factory _Scanning() = _$ScanningImpl;
}

/// @nodoc
abstract class _$$ScannedImplCopyWith<$Res> {
  factory _$$ScannedImplCopyWith(
          _$ScannedImpl value, $Res Function(_$ScannedImpl) then) =
      __$$ScannedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({dynamic result});
}

/// @nodoc
class __$$ScannedImplCopyWithImpl<$Res>
    extends _$ScanStateCopyWithImpl<$Res, _$ScannedImpl>
    implements _$$ScannedImplCopyWith<$Res> {
  __$$ScannedImplCopyWithImpl(
      _$ScannedImpl _value, $Res Function(_$ScannedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? result = freezed,
  }) {
    return _then(_$ScannedImpl(
      freezed == result
          ? _value.result
          : result // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc

class _$ScannedImpl implements _Scanned {
  const _$ScannedImpl(this.result);

  @override
  final dynamic result;

  @override
  String toString() {
    return 'ScanState.scanned(result: $result)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ScannedImpl &&
            const DeepCollectionEquality().equals(other.result, result));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(result));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ScannedImplCopyWith<_$ScannedImpl> get copyWith =>
      __$$ScannedImplCopyWithImpl<_$ScannedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() scanning,
    required TResult Function(dynamic result) scanned,
    required TResult Function() analyzing,
    required TResult Function(AnalyzeResponse result) analyzed,
    required TResult Function(String message) error,
  }) {
    return scanned(result);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function()? scanning,
    TResult? Function(dynamic result)? scanned,
    TResult? Function()? analyzing,
    TResult? Function(AnalyzeResponse result)? analyzed,
    TResult? Function(String message)? error,
  }) {
    return scanned?.call(result);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? scanning,
    TResult Function(dynamic result)? scanned,
    TResult Function()? analyzing,
    TResult Function(AnalyzeResponse result)? analyzed,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (scanned != null) {
      return scanned(result);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Idle value) idle,
    required TResult Function(_Scanning value) scanning,
    required TResult Function(_Scanned value) scanned,
    required TResult Function(_Analyzing value) analyzing,
    required TResult Function(_Analyzed value) analyzed,
    required TResult Function(_Error value) error,
  }) {
    return scanned(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Idle value)? idle,
    TResult? Function(_Scanning value)? scanning,
    TResult? Function(_Scanned value)? scanned,
    TResult? Function(_Analyzing value)? analyzing,
    TResult? Function(_Analyzed value)? analyzed,
    TResult? Function(_Error value)? error,
  }) {
    return scanned?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Idle value)? idle,
    TResult Function(_Scanning value)? scanning,
    TResult Function(_Scanned value)? scanned,
    TResult Function(_Analyzing value)? analyzing,
    TResult Function(_Analyzed value)? analyzed,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (scanned != null) {
      return scanned(this);
    }
    return orElse();
  }
}

abstract class _Scanned implements ScanState {
  const factory _Scanned(final dynamic result) = _$ScannedImpl;

  dynamic get result;
  @JsonKey(ignore: true)
  _$$ScannedImplCopyWith<_$ScannedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AnalyzingImplCopyWith<$Res> {
  factory _$$AnalyzingImplCopyWith(
          _$AnalyzingImpl value, $Res Function(_$AnalyzingImpl) then) =
      __$$AnalyzingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AnalyzingImplCopyWithImpl<$Res>
    extends _$ScanStateCopyWithImpl<$Res, _$AnalyzingImpl>
    implements _$$AnalyzingImplCopyWith<$Res> {
  __$$AnalyzingImplCopyWithImpl(
      _$AnalyzingImpl _value, $Res Function(_$AnalyzingImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$AnalyzingImpl implements _Analyzing {
  const _$AnalyzingImpl();

  @override
  String toString() {
    return 'ScanState.analyzing()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$AnalyzingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() scanning,
    required TResult Function(dynamic result) scanned,
    required TResult Function() analyzing,
    required TResult Function(AnalyzeResponse result) analyzed,
    required TResult Function(String message) error,
  }) {
    return analyzing();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function()? scanning,
    TResult? Function(dynamic result)? scanned,
    TResult? Function()? analyzing,
    TResult? Function(AnalyzeResponse result)? analyzed,
    TResult? Function(String message)? error,
  }) {
    return analyzing?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? scanning,
    TResult Function(dynamic result)? scanned,
    TResult Function()? analyzing,
    TResult Function(AnalyzeResponse result)? analyzed,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (analyzing != null) {
      return analyzing();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Idle value) idle,
    required TResult Function(_Scanning value) scanning,
    required TResult Function(_Scanned value) scanned,
    required TResult Function(_Analyzing value) analyzing,
    required TResult Function(_Analyzed value) analyzed,
    required TResult Function(_Error value) error,
  }) {
    return analyzing(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Idle value)? idle,
    TResult? Function(_Scanning value)? scanning,
    TResult? Function(_Scanned value)? scanned,
    TResult? Function(_Analyzing value)? analyzing,
    TResult? Function(_Analyzed value)? analyzed,
    TResult? Function(_Error value)? error,
  }) {
    return analyzing?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Idle value)? idle,
    TResult Function(_Scanning value)? scanning,
    TResult Function(_Scanned value)? scanned,
    TResult Function(_Analyzing value)? analyzing,
    TResult Function(_Analyzed value)? analyzed,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (analyzing != null) {
      return analyzing(this);
    }
    return orElse();
  }
}

abstract class _Analyzing implements ScanState {
  const factory _Analyzing() = _$AnalyzingImpl;
}

/// @nodoc
abstract class _$$AnalyzedImplCopyWith<$Res> {
  factory _$$AnalyzedImplCopyWith(
          _$AnalyzedImpl value, $Res Function(_$AnalyzedImpl) then) =
      __$$AnalyzedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({AnalyzeResponse result});

  $AnalyzeResponseCopyWith<$Res> get result;
}

/// @nodoc
class __$$AnalyzedImplCopyWithImpl<$Res>
    extends _$ScanStateCopyWithImpl<$Res, _$AnalyzedImpl>
    implements _$$AnalyzedImplCopyWith<$Res> {
  __$$AnalyzedImplCopyWithImpl(
      _$AnalyzedImpl _value, $Res Function(_$AnalyzedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? result = null,
  }) {
    return _then(_$AnalyzedImpl(
      null == result
          ? _value.result
          : result // ignore: cast_nullable_to_non_nullable
              as AnalyzeResponse,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $AnalyzeResponseCopyWith<$Res> get result {
    return $AnalyzeResponseCopyWith<$Res>(_value.result, (value) {
      return _then(_value.copyWith(result: value));
    });
  }
}

/// @nodoc

class _$AnalyzedImpl implements _Analyzed {
  const _$AnalyzedImpl(this.result);

  @override
  final AnalyzeResponse result;

  @override
  String toString() {
    return 'ScanState.analyzed(result: $result)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AnalyzedImpl &&
            (identical(other.result, result) || other.result == result));
  }

  @override
  int get hashCode => Object.hash(runtimeType, result);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AnalyzedImplCopyWith<_$AnalyzedImpl> get copyWith =>
      __$$AnalyzedImplCopyWithImpl<_$AnalyzedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() scanning,
    required TResult Function(dynamic result) scanned,
    required TResult Function() analyzing,
    required TResult Function(AnalyzeResponse result) analyzed,
    required TResult Function(String message) error,
  }) {
    return analyzed(result);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function()? scanning,
    TResult? Function(dynamic result)? scanned,
    TResult? Function()? analyzing,
    TResult? Function(AnalyzeResponse result)? analyzed,
    TResult? Function(String message)? error,
  }) {
    return analyzed?.call(result);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? scanning,
    TResult Function(dynamic result)? scanned,
    TResult Function()? analyzing,
    TResult Function(AnalyzeResponse result)? analyzed,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (analyzed != null) {
      return analyzed(result);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Idle value) idle,
    required TResult Function(_Scanning value) scanning,
    required TResult Function(_Scanned value) scanned,
    required TResult Function(_Analyzing value) analyzing,
    required TResult Function(_Analyzed value) analyzed,
    required TResult Function(_Error value) error,
  }) {
    return analyzed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Idle value)? idle,
    TResult? Function(_Scanning value)? scanning,
    TResult? Function(_Scanned value)? scanned,
    TResult? Function(_Analyzing value)? analyzing,
    TResult? Function(_Analyzed value)? analyzed,
    TResult? Function(_Error value)? error,
  }) {
    return analyzed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Idle value)? idle,
    TResult Function(_Scanning value)? scanning,
    TResult Function(_Scanned value)? scanned,
    TResult Function(_Analyzing value)? analyzing,
    TResult Function(_Analyzed value)? analyzed,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (analyzed != null) {
      return analyzed(this);
    }
    return orElse();
  }
}

abstract class _Analyzed implements ScanState {
  const factory _Analyzed(final AnalyzeResponse result) = _$AnalyzedImpl;

  AnalyzeResponse get result;
  @JsonKey(ignore: true)
  _$$AnalyzedImplCopyWith<_$AnalyzedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ErrorImplCopyWith<$Res> {
  factory _$$ErrorImplCopyWith(
          _$ErrorImpl value, $Res Function(_$ErrorImpl) then) =
      __$$ErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$ErrorImplCopyWithImpl<$Res>
    extends _$ScanStateCopyWithImpl<$Res, _$ErrorImpl>
    implements _$$ErrorImplCopyWith<$Res> {
  __$$ErrorImplCopyWithImpl(
      _$ErrorImpl _value, $Res Function(_$ErrorImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$ErrorImpl(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ErrorImpl implements _Error {
  const _$ErrorImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'ScanState.error(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      __$$ErrorImplCopyWithImpl<_$ErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() scanning,
    required TResult Function(dynamic result) scanned,
    required TResult Function() analyzing,
    required TResult Function(AnalyzeResponse result) analyzed,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function()? scanning,
    TResult? Function(dynamic result)? scanned,
    TResult? Function()? analyzing,
    TResult? Function(AnalyzeResponse result)? analyzed,
    TResult? Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? scanning,
    TResult Function(dynamic result)? scanned,
    TResult Function()? analyzing,
    TResult Function(AnalyzeResponse result)? analyzed,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Idle value) idle,
    required TResult Function(_Scanning value) scanning,
    required TResult Function(_Scanned value) scanned,
    required TResult Function(_Analyzing value) analyzing,
    required TResult Function(_Analyzed value) analyzed,
    required TResult Function(_Error value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Idle value)? idle,
    TResult? Function(_Scanning value)? scanning,
    TResult? Function(_Scanned value)? scanned,
    TResult? Function(_Analyzing value)? analyzing,
    TResult? Function(_Analyzed value)? analyzed,
    TResult? Function(_Error value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Idle value)? idle,
    TResult Function(_Scanning value)? scanning,
    TResult Function(_Scanned value)? scanned,
    TResult Function(_Analyzing value)? analyzing,
    TResult Function(_Analyzed value)? analyzed,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _Error implements ScanState {
  const factory _Error(final String message) = _$ErrorImpl;

  String get message;
  @JsonKey(ignore: true)
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
