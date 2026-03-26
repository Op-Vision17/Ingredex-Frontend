// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'history_models.freezed.dart';
part 'history_models.g.dart';

@freezed
class HistoryItem with _$HistoryItem {
  const factory HistoryItem({
    required String id,
    @JsonKey(name: 'product_name') String? productName,
    String? barcode,
    @JsonKey(name: 'analysis_result') Map<String, dynamic>? analysisResult,
    @JsonKey(name: 'scan_type') required String scanType,
    @JsonKey(name: 'created_at') required String createdAt,
  }) = _HistoryItem;

  factory HistoryItem.fromJson(Map<String, dynamic> json) =>
      _$HistoryItemFromJson(json);
}

@freezed
class HistoryDetail with _$HistoryDetail {
  const factory HistoryDetail({
    required String id,
    @JsonKey(name: 'product_name') String? productName,
    String? barcode,
    @JsonKey(name: 'raw_ingredients') String? rawIngredients,
    @JsonKey(name: 'analysis_result') Map<String, dynamic>? analysisResult,
    @JsonKey(name: 'scan_type') required String scanType,
    @JsonKey(name: 'created_at') required String createdAt,
  }) = _HistoryDetail;

  factory HistoryDetail.fromJson(Map<String, dynamic> json) =>
      _$HistoryDetailFromJson(json);
}

@freezed
class HistoryStats with _$HistoryStats {
  const factory HistoryStats({
    @JsonKey(name: 'total_scans') required int totalScans,
    @JsonKey(name: 'by_scan_type') @Default(<String, int>{}) Map<String, int> byScanType,
  }) = _HistoryStats;

  factory HistoryStats.fromJson(Map<String, dynamic> json) =>
      _$HistoryStatsFromJson(json);
}
