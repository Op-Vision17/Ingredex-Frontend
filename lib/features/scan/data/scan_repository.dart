import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/network/api_endpoints.dart';
import '../../../core/network/dio_client.dart';
import 'models/scan_models.dart';

final scanRepositoryProvider = Provider<ScanRepository>((ref) {
  return ScanRepository(ref.read(dioClientProvider));
});

class ScanRepository {
  ScanRepository(this._client);
  final DioClient _client;

  Future<BarcodeResult> scanBarcode(String barcode) async {
    final response = await _client.post(
      ApiEndpoints.scanBarcode,
      data: {'barcode': barcode},
    );
    return BarcodeResult.fromJson(response.data as Map<String, dynamic>);
  }

  Future<OcrResult> scanOcr(File imageFile) async {
    final formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(imageFile.path),
    });
    final response = await _client.postMultipart(
      ApiEndpoints.scanOcr,
      formData,
    );
    return OcrResult.fromJson(response.data as Map<String, dynamic>);
  }

  Future<AnalyzeResponse> analyzeIngredients(
    String ingredients,
    String? productName,
    String scanType,
  ) async {
    final response = await _client.post(
      ApiEndpoints.analyze,
      data: {
        'product_name': productName,
        'ingredients': ingredients,
        'scan_type': scanType,
      },
      options: Options(
        receiveTimeout: const Duration(
          milliseconds: AppConstants.analyzeReceiveTimeoutMs,
        ),
      ),
    );
    return AnalyzeResponse.fromJson(response.data as Map<String, dynamic>);
  }
}
