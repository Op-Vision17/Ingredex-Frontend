import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SourcesButton extends StatelessWidget {
  const SourcesButton({super.key, required this.sources});
  final List<String> sources;

  @override
  Widget build(BuildContext context) {
    if (sources.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(top: 14),
      child: Center(
        child: OutlinedButton.icon(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              useSafeArea: true,
              builder: (context) {
                return DraggableScrollableSheet(
                  initialChildSize: 0.3,
                  minChildSize: 0.3,
                  maxChildSize: 1.0,
                  expand: false,
                  builder: (context, scrollController) {
                    return SafeArea(
                      child: Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 16.0),
                            child: Text(
                              'Sources Referenced',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const Divider(height: 1),
                          Expanded(
                            child: ListView.builder(
                              controller: scrollController,
                              itemCount: sources.length,
                              itemBuilder: (context, index) {
                                final source = sources[index];
                                return ListTile(
                                  leading: Icon(
                                    Icons.link_rounded,
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.primary,
                                  ),
                                  title: Text(source),
                                  trailing: const Icon(
                                    Icons.open_in_new_rounded,
                                    size: 20,
                                  ),
                                  onTap: () async {
                                    var urlStr = source;
                                    if (!urlStr.startsWith('http')) {
                                      urlStr = 'https://$urlStr';
                                    }
                                    final uri = Uri.parse(urlStr);
                                    if (await canLaunchUrl(uri)) {
                                      await launchUrl(
                                        uri,
                                        mode: LaunchMode.externalApplication,
                                      );
                                    }
                                  },
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
          icon: const Icon(Icons.library_books_outlined),
          label: const Text('View Referenced Sources'),
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
          ),
        ),
      ),
    );
  }
}
