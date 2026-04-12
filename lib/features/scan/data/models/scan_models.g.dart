// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scan_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BarcodeResultImpl _$$BarcodeResultImplFromJson(Map<String, dynamic> json) =>
    _$BarcodeResultImpl(
      productName: json['product_name'] as String?,
      ingredients: json['ingredients'] as String?,
      barcode: json['barcode'] as String,
      source: json['source'] as String,
    );

Map<String, dynamic> _$$BarcodeResultImplToJson(_$BarcodeResultImpl instance) =>
    <String, dynamic>{
      'product_name': instance.productName,
      'ingredients': instance.ingredients,
      'barcode': instance.barcode,
      'source': instance.source,
    };

_$OcrResultImpl _$$OcrResultImplFromJson(Map<String, dynamic> json) =>
    _$OcrResultImpl(
      extractedText: json['extracted_text'] as String,
      confidence: (json['confidence'] as num).toDouble(),
    );

Map<String, dynamic> _$$OcrResultImplToJson(_$OcrResultImpl instance) =>
    <String, dynamic>{
      'extracted_text': instance.extractedText,
      'confidence': instance.confidence,
    };

_$IngredientIssueImpl _$$IngredientIssueImplFromJson(
        Map<String, dynamic> json) =>
    _$IngredientIssueImpl(
      ingredient: json['ingredient'] as String,
      risk: json['risk'] as String,
      reason: json['reason'] as String,
      sourceDomain: json['source_domain'] as String? ?? '',
    );

Map<String, dynamic> _$$IngredientIssueImplToJson(
        _$IngredientIssueImpl instance) =>
    <String, dynamic>{
      'ingredient': instance.ingredient,
      'risk': instance.risk,
      'reason': instance.reason,
      'source_domain': instance.sourceDomain,
    };

_$GoodIngredientImpl _$$GoodIngredientImplFromJson(Map<String, dynamic> json) =>
    _$GoodIngredientImpl(
      ingredient: json['ingredient'] as String,
      benefit: json['benefit'] as String,
      sourceDomain: json['source_domain'] as String? ?? '',
    );

Map<String, dynamic> _$$GoodIngredientImplToJson(
        _$GoodIngredientImpl instance) =>
    <String, dynamic>{
      'ingredient': instance.ingredient,
      'benefit': instance.benefit,
      'source_domain': instance.sourceDomain,
    };

_$AlternativeImpl _$$AlternativeImplFromJson(Map<String, dynamic> json) =>
    _$AlternativeImpl(
      name: json['name'] as String,
      reason: json['reason'] as String,
    );

Map<String, dynamic> _$$AlternativeImplToJson(_$AlternativeImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'reason': instance.reason,
    };

_$AnalysisResultImpl _$$AnalysisResultImplFromJson(Map<String, dynamic> json) =>
    _$AnalysisResultImpl(
      healthScore: (json['health_score'] as num).toInt(),
      riskLevel: json['risk_level'] as String,
      issues: (json['issues'] as List<dynamic>?)
              ?.map((e) => IngredientIssue.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <IngredientIssue>[],
      goodIngredients: (json['good_ingredients'] as List<dynamic>?)
              ?.map((e) => GoodIngredient.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <GoodIngredient>[],
      alternatives: (json['alternatives'] as List<dynamic>?)
              ?.map((e) => Alternative.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <Alternative>[],
      summary: json['summary'] as String,
      sourcesUsed: (json['sources_used'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
    );

Map<String, dynamic> _$$AnalysisResultImplToJson(
        _$AnalysisResultImpl instance) =>
    <String, dynamic>{
      'health_score': instance.healthScore,
      'risk_level': instance.riskLevel,
      'issues': instance.issues,
      'good_ingredients': instance.goodIngredients,
      'alternatives': instance.alternatives,
      'summary': instance.summary,
      'sources_used': instance.sourcesUsed,
    };

_$AnalyzeResponseImpl _$$AnalyzeResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$AnalyzeResponseImpl(
      analysis:
          AnalysisResult.fromJson(json['analysis'] as Map<String, dynamic>),
      productName: json['product_name'] as String?,
      scanId: json['scan_id'] as String?,
    );

Map<String, dynamic> _$$AnalyzeResponseImplToJson(
        _$AnalyzeResponseImpl instance) =>
    <String, dynamic>{
      'analysis': instance.analysis,
      'product_name': instance.productName,
      'scan_id': instance.scanId,
    };
