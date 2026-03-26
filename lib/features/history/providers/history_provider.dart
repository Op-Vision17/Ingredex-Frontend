import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/history_repository.dart';
import '../data/models/history_models.dart';

final historyProvider =
    AsyncNotifierProvider<HistoryNotifier, List<HistoryItem>>(
      HistoryNotifier.new,
    );

final historyStatsProvider =
    AsyncNotifierProvider<HistoryStatsNotifier, HistoryStats>(
      HistoryStatsNotifier.new,
    );

final historyDetailProvider =
    AsyncNotifierProvider.family<HistoryDetailNotifier, HistoryDetail, String>(
      HistoryDetailNotifier.new,
    );

// Backward-compatible alias used by other screens/widgets.
final historyListProvider = FutureProvider<List<HistoryItem>>((ref) async {
  return ref.watch(historyProvider.future);
});

class HistoryNotifier extends AsyncNotifier<List<HistoryItem>> {
  static const int _pageSize = 20;
  int _offset = 0;
  bool _hasMore = true;
  final _deletingIds = <String>{};

  @override
  Future<List<HistoryItem>> build() async {
    return load();
  }

  Future<List<HistoryItem>> load() async {
    _offset = 0;
    _hasMore = true;
    final items = await ref
        .read(historyRepositoryProvider)
        .getHistory(limit: _pageSize, offset: _offset);
    _offset = items.length;
    _hasMore = items.length == _pageSize;
    state = AsyncData(items);
    return items;
  }

  Future<void> loadMore() async {
    if (!_hasMore || state.isLoading) return;
    final current = state.valueOrNull ?? <HistoryItem>[];
    final next = await ref
        .read(historyRepositoryProvider)
        .getHistory(limit: _pageSize, offset: _offset);
    _offset += next.length;
    _hasMore = next.length == _pageSize;
    state = AsyncData([...current, ...next]);
  }

  Future<void> delete(String id) async {
    if (_deletingIds.contains(id)) return; // already in flight
    _deletingIds.add(id);
    final current = state.valueOrNull ?? <HistoryItem>[];
    final updated = current.where((e) => e.id != id).toList();
    state = AsyncData(updated); // optimistic update
    try {
      await ref.read(historyRepositoryProvider).deleteHistory(id);
      ref.invalidate(historyStatsProvider);
    } catch (_) {
      state = AsyncData(current); // rollback
      rethrow;
    } finally {
      _deletingIds.remove(id);
    }
  }

  Future<void> refresh() async {
    await load();
    ref.invalidate(historyStatsProvider);
  }
}

class HistoryStatsNotifier extends AsyncNotifier<HistoryStats> {
  @override
  Future<HistoryStats> build() async {
    return ref.read(historyRepositoryProvider).getHistoryStats();
  }
}

class HistoryDetailNotifier extends FamilyAsyncNotifier<HistoryDetail, String> {
  @override
  Future<HistoryDetail> build(String arg) async {
    return ref.read(historyRepositoryProvider).getHistoryDetail(arg);
  }
}
