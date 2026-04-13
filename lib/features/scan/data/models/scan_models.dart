// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'scan_models.freezed.dart';
part 'scan_models.g.dart';

@freezed
class BarcodeResult with _$BarcodeResult {
  const factory BarcodeResult({
    @JsonKey(name: 'product_name') String? productName,
    String? ingredients,
    required String barcode,
    required String source,
  }) = _BarcodeResult;

  factory BarcodeResult.fromJson(Map<String, dynamic> json) =>
      _$BarcodeResultFromJson(json);
}

@freezed
class OcrResult with _$OcrResult {
  const factory OcrResult({
    @JsonKey(name: 'extracted_text') required String extractedText,
    required double confidence,
  }) = _OcrResult;

  factory OcrResult.fromJson(Map<String, dynamic> json) =>
      _$OcrResultFromJson(json);
}

@freezed
class IngredientIssue with _$IngredientIssue {
  const factory IngredientIssue({
    required String ingredient,
    required String risk,
    required String reason,
    @JsonKey(name: 'source_domain') @Default('') String sourceDomain,
  }) = _IngredientIssue;

  factory IngredientIssue.fromJson(Map<String, dynamic> json) =>
      _$IngredientIssueFromJson(json);
}

@freezed
class GoodIngredient with _$GoodIngredient {
  const factory GoodIngredient({
    required String ingredient,
    required String benefit,
    @JsonKey(name: 'source_domain') @Default('') String sourceDomain,
  }) = _GoodIngredient;

  factory GoodIngredient.fromJson(Map<String, dynamic> json) =>
      _$GoodIngredientFromJson(json);
}

@freezed
class Alternative with _$Alternative {
  const factory Alternative({required String name, required String reason}) =
      _Alternative;

  factory Alternative.fromJson(Map<String, dynamic> json) =>
      _$AlternativeFromJson(json);
}

@freezed
class UserInsight with _$UserInsight {
  const factory UserInsight({
    required String impact,
    required String title,
    required String description,
  }) = _UserInsight;

  factory UserInsight.fromJson(Map<String, dynamic> json) =>
      _$UserInsightFromJson(json);
}

@freezed
class AnalysisResult with _$AnalysisResult {
  const factory AnalysisResult({
    @JsonKey(name: 'health_score') required int healthScore,
    @JsonKey(name: 'risk_level') required String riskLevel,
    @Default(<IngredientIssue>[]) List<IngredientIssue> issues,
    @JsonKey(name: 'good_ingredients')
    @Default(<GoodIngredient>[])
    List<GoodIngredient> goodIngredients,
    @Default(<Alternative>[]) List<Alternative> alternatives,
    required String summary,
    @JsonKey(name: 'user_insights') @Default(<UserInsight>[]) List<UserInsight> userInsights,
    @JsonKey(name: 'sources_used') @Default(<String>[]) List<String> sourcesUsed,
  }) = _AnalysisResult;

  factory AnalysisResult.fromJson(Map<String, dynamic> json) =>
      _$AnalysisResultFromJson(json);
}

@freezed
class AnalyzeResponse with _$AnalyzeResponse {
  const factory AnalyzeResponse({
    required AnalysisResult analysis,
    @JsonKey(name: 'product_name') String? productName,
    @JsonKey(name: 'scan_id') String? scanId,
  }) = _AnalyzeResponse;

  factory AnalyzeResponse.fromJson(Map<String, dynamic> json) =>
      _$AnalyzeResponseFromJson(json);
}
