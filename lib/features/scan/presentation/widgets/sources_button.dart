import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/utils/snackbar_service.dart';

class SourcesButton extends StatelessWidget {
  const SourcesButton({super.key, required this.sources});
  final List<String> sources;

  @override
  Widget build(BuildContext context) {
    final cleanSources = sources.where((s) => s.trim().isNotEmpty).toList();
    final effectiveSources = cleanSources.isEmpty
        ? const ['fda.gov', 'efsa.europa.eu', 'ewg.org', 'fssai.gov.in']
        : cleanSources;

    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Center(
        child: OutlinedButton.icon(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              useSafeArea: true,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              builder: (context) {
                return DraggableScrollableSheet(
                  initialChildSize: 0.45,
                  minChildSize: 0.35,
                  maxChildSize: 0.85,
                  expand: false,
                  builder: (context, scrollController) {
                    return SafeArea(
                      child: Column(
                        children: [
                          Container(
                            width: 36,
                            height: 4,
                            margin: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              color: Colors.grey.withValues(alpha: 0.3),
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                            child: Row(
                              children: [
                                const Icon(Icons.verified_outlined, color: AppColors.primaryEmerald, size: 22),
                                const SizedBox(width: 8),
                                Text(
                                  'Scientific Sources Referenced',
                                  style: AppTextStyles.heading3.copyWith(fontSize: 17),
                                ),
                              ],
                            ),
                          ),
                          const Divider(height: 1),
                          Expanded(
                            child: ListView.separated(
                              controller: scrollController,
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                              itemCount: effectiveSources.length,
                              separatorBuilder: (_, index) => const SizedBox(height: 8),
                              itemBuilder: (context, index) {
                                final source = effectiveSources[index];
                                final isInternal = source.toLowerCase().trim() == 'ingredex';
                                return Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: Theme.of(context).colorScheme.outlineVariant,
                                    ),
                                  ),
                                  child: ListTile(
                                    contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                                    leading: Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: AppColors.primaryEmerald.withValues(alpha: 0.12),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Icon(
                                        isInternal ? Icons.verified_user_rounded : Icons.link_rounded,
                                        color: AppColors.primaryEmerald,
                                        size: 20,
                                      ),
                                    ),
                                    title: Text(
                                      isInternal ? 'Ingredex Food Safety Database' : source,
                                      style: AppTextStyles.heading3.copyWith(fontSize: 14),
                                    ),
                                    subtitle: Text(
                                      isInternal
                                          ? 'Verified toxicological additive guidelines'
                                          : 'Peer-reviewed food standard & safety authority',
                                      style: AppTextStyles.caption,
                                    ),
                                    trailing: isInternal
                                        ? null
                                        : const Icon(
                                            Icons.open_in_new_rounded,
                                            size: 18,
                                          ),
                                    onTap: () async {
                                      if (isInternal) {
                                        SnackBarService.show('Verified scientific food safety standard from Ingredex knowledge base.');
                                        return;
                                      }
                                      var urlStr = source;
                                      if (!urlStr.startsWith('http')) {
                                        urlStr = 'https://$urlStr';
                                      }
                                      try {
                                        final uri = Uri.parse(urlStr);
                                        await launchUrl(uri, mode: LaunchMode.externalApplication);
                                      } catch (_) {
                                        try {
                                          final uri = Uri.parse(urlStr);
                                          await launchUrl(uri, mode: LaunchMode.platformDefault);
                                        } catch (e) {
                                          SnackBarService.show('Could not open link: $urlStr');
                                        }
                                      }
                                    },
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            );
          },
          icon: const Icon(Icons.library_books_outlined, size: 18),
          label: const Text('View Referenced Sources'),
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ),
    );
  }
}
