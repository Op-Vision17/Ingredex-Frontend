import '../../features/history/data/models/history_models.dart';

String shareTextFromHistoryDetail(HistoryDetail detail) {
  final buf = StringBuffer();
  buf.writeln(detail.productName ?? 'Ingredex scan');
  buf.writeln('Type: ${detail.scanType}');
  final ar = detail.analysisResult;
  if (ar != null) {
    final hs = ar['health_score'];
    final risk = ar['risk_level'];
    if (hs != null) buf.writeln('Health score: $hs/10');
    if (risk != null) buf.writeln('Risk: $risk');
    final summary = ar['summary'];
    if (summary is String && summary.isNotEmpty) buf.writeln(summary);
  }
  final raw = detail.rawIngredients;
  if (raw != null && raw.trim().isNotEmpty) {
    buf.writeln('\nIngredients:\n$raw');
  }
  return buf.toString();
}
