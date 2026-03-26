// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$HistoryItemImpl _$$HistoryItemImplFromJson(Map<String, dynamic> json) =>
    _$HistoryItemImpl(
      id: json['id'] as String,
      productName: json['product_name'] as String?,
      barcode: json['barcode'] as String?,
      analysisResult: json['analysis_result'] as Map<String, dynamic>?,
      scanType: json['scan_type'] as String,
      createdAt: json['created_at'] as String,
    );

Map<String, dynamic> _$$HistoryItemImplToJson(_$HistoryItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'product_name': instance.productName,
      'barcode': instance.barcode,
      'analysis_result': instance.analysisResult,
      'scan_type': instance.scanType,
      'created_at': instance.createdAt,
    };

_$HistoryDetailImpl _$$HistoryDetailImplFromJson(Map<String, dynamic> json) =>
    _$HistoryDetailImpl(
      id: json['id'] as String,
      productName: json['product_name'] as String?,
      barcode: json['barcode'] as String?,
      rawIngredients: json['raw_ingredients'] as String?,
      analysisResult: json['analysis_result'] as Map<String, dynamic>?,
      scanType: json['scan_type'] as String,
      createdAt: json['created_at'] as String,
    );

Map<String, dynamic> _$$HistoryDetailImplToJson(_$HistoryDetailImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'product_name': instance.productName,
      'barcode': instance.barcode,
      'raw_ingredients': instance.rawIngredients,
      'analysis_result': instance.analysisResult,
      'scan_type': instance.scanType,
      'created_at': instance.createdAt,
    };

_$HistoryStatsImpl _$$HistoryStatsImplFromJson(Map<String, dynamic> json) =>
    _$HistoryStatsImpl(
      totalScans: (json['total_scans'] as num).toInt(),
      byScanType: (json['by_scan_type'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, (e as num).toInt()),
          ) ??
          const <String, int>{},
    );

Map<String, dynamic> _$$HistoryStatsImplToJson(_$HistoryStatsImpl instance) =>
    <String, dynamic>{
      'total_scans': instance.totalScans,
      'by_scan_type': instance.byScanType,
    };
