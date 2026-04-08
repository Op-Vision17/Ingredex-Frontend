import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../data/models/scan_models.dart';
import '../data/scan_repository.dart';

part 'scan_provider.freezed.dart';

final lastAnalysisProvider = StateProvider<AnalyzeResponse?>((ref) => null);

@freezed
class ScanState with _$ScanState {
  const factory ScanState.idle() = _Idle;
  const factory ScanState.scanning() = _Scanning;
  const factory ScanState.scanned(dynamic result) = _Scanned;
  const factory ScanState.analyzing() = _Analyzing;
  const factory ScanState.analyzed(AnalyzeResponse result) = _Analyzed;
  const factory ScanState.error(String message) = _Error;
}

final scanNotifierProvider = StateNotifierProvider<ScanNotifier, ScanState>((
  ref,
) {
  return ScanNotifier(ref);
});

class ScanNotifier extends StateNotifier<ScanState> {
  ScanNotifier(this._ref) : super(const ScanState.idle());
  final Ref _ref;

  Future<BarcodeResult> scanBarcode(String barcode) async {
    state = const ScanState.scanning();
    try {
      final result = await _ref
          .read(scanRepositoryProvider)
          .scanBarcode(barcode);
      state = ScanState.scanned(result);
      return result;
    } catch (e) {
      state = ScanState.error(_messageFrom(e));
      rethrow;
    }
  }

  Future<OcrResult> scanOcr(File file) async {
    state = const ScanState.scanning();
    try {
      final result = await _ref.read(scanRepositoryProvider).scanOcr(file);
      state = ScanState.scanned(result);
      return result;
    } catch (e) {
      state = ScanState.error(_messageFrom(e));
      rethrow;
    }
  }

  Future<AnalyzeResponse> analyzeFromBarcode(BarcodeResult barcode) async {
    return analyzeManual(
      barcode.ingredients ?? '',
      barcode.productName,
      scanType: 'barcode',
    );
  }

  Future<AnalyzeResponse> analyzeFromOcr(OcrResult ocr, [String? productName]) async {
    return analyzeManual(ocr.extractedText, productName, scanType: 'ocr');
  }

  Future<AnalyzeResponse> analyzeManual(
    String ingredients,
    String? name, {
    String scanType = 'analysis',
  }) async {
    state = const ScanState.analyzing();
    try {
      final result = await _ref
          .read(scanRepositoryProvider)
          .analyzeIngredients(ingredients, name, scanType);
      _ref.read(lastAnalysisProvider.notifier).state = result;
      state = ScanState.analyzed(result);
      return result;
    } catch (e) {
      state = ScanState.error(_messageFrom(e));
      rethrow;
    }
  }

  void reset() {
    state = const ScanState.idle();
  }

  String _messageFrom(Object e) {
    final text = e.toString();
    if (text.contains('422')) return 'Could not read ingredients from image.';
    if (text.contains('401')) return 'Please login again.';
    return 'Something went wrong. Please try again.';
  }
}
