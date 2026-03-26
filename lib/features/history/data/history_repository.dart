import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/api_endpoints.dart';
import '../../../core/network/dio_client.dart';
import 'models/history_models.dart';

final historyRepositoryProvider = Provider<HistoryRepository>((ref) {
  return HistoryRepository(ref.read(dioClientProvider));
});

class HistoryRepository {
  HistoryRepository(this._client);
  final DioClient _client;

  Future<List<HistoryItem>> getHistory({int limit = 20, int offset = 0}) async {
    final response = await _client.get(
      ApiEndpoints.history,
      params: {'limit': limit, 'offset': offset},
    );
    final data = response.data as List<dynamic>;
    return data.map((e) => HistoryItem.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<HistoryStats> getHistoryStats() async {
    final response = await _client.get(ApiEndpoints.historyStats);
    return HistoryStats.fromJson(response.data as Map<String, dynamic>);
  }

  Future<HistoryDetail> getHistoryDetail(String id) async {
    final response = await _client.get(ApiEndpoints.historyDetail(id));
    return HistoryDetail.fromJson(response.data as Map<String, dynamic>);
  }

  Future<void> deleteHistory(String id) async {
    await _client.delete(ApiEndpoints.deleteHistory(id));
  }
}
