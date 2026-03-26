import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../shared/widgets/app_button.dart';
import '../../../shared/widgets/app_text_field.dart';
import '../providers/scan_provider.dart';

class ManualEntryScreen extends ConsumerStatefulWidget {
  const ManualEntryScreen({super.key});

  @override
  ConsumerState<ManualEntryScreen> createState() => _ManualEntryScreenState();
}

class _ManualEntryScreenState extends ConsumerState<ManualEntryScreen> {
  final _name = TextEditingController();
  final _ingredients = TextEditingController();
  final _scroll = ScrollController();

  @override
  void dispose() {
    _name.dispose();
    _ingredients.dispose();
    _scroll.dispose();
    super.dispose();
  }

  Future<void> _analyze() async {
    if (_ingredients.text.trim().isEmpty) {
      return;
    }
    try {
      final result = await ref
          .read(scanNotifierProvider.notifier)
          .analyzeManual(
            _ingredients.text.trim(),
            _name.text.trim().isEmpty ? null : _name.text.trim(),
          );
      if (mounted) context.push('/result', extra: result);
    } catch (e) {
      if (!mounted) return;
    }
  }

  Future<void> _pasteIngredients() async {
    final data = await Clipboard.getData('text/plain');
    final text = data?.text ?? '';
    if (text.isEmpty) return;
    _ingredients.text = text;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final insets = MediaQuery.of(context).viewInsets.bottom;
    final state = ref.watch(scanNotifierProvider);
    final loading = state.maybeWhen(
      analyzing: () => true,
      scanning: () => true,
      orElse: () => false,
    );
    return Scaffold(
      appBar: AppBar(title: const Text('Enter Ingredients')),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          controller: _scroll,
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 110),
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppTextField(
                controller: _name,
                hintText: 'Product name (optional)',
              ),
              const SizedBox(height: 12),
              AppTextField(
                controller: _ingredients,
                hintText: 'Type ingredients here...',
                maxLines: 10,
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  Text(
                    '${_ingredients.text.length} characters',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const Spacer(),
                  TextButton.icon(
                    onPressed: _pasteIngredients,
                    icon: const Icon(Icons.paste_rounded),
                    label: const Text('Paste'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: AnimatedPadding(
        duration: const Duration(milliseconds: 180),
        padding: EdgeInsets.fromLTRB(16, 8, 16, 16 + insets),
        child: SafeArea(
          child: Material(
            elevation: 3,
            borderRadius: BorderRadius.circular(14),
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            child: AppButton(
              label: 'Analyze',
              loading: loading,
              onPressed: _analyze,
            ),
          ),
        ),
      ),
    );
  }
}
