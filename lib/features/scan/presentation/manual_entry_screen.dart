import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

import '../../../core/utils/snackbar_service.dart';
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
  late final ProviderSubscription<ScanState> _scanSubscription;
  bool _isProcessing = false;

  @override
  void initState() {
    super.initState();
    _scanSubscription = ref.listenManual<ScanState>(
      scanNotifierProvider,
      (prev, next) {
        next.whenOrNull(
          error: (message) {
            SnackBarService.show(message);
          },
        );
      },
    );
  }

  @override
  void dispose() {
    _scanSubscription.close();
    _name.dispose();
    _ingredients.dispose();
    _scroll.dispose();
    super.dispose();
  }

  Future<void> _analyze() async {
    if (_ingredients.text.trim().isEmpty || _isProcessing) {
      return;
    }
    setState(() => _isProcessing = true);
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
    } finally {
      if (mounted) setState(() => _isProcessing = false);
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
    final loading = _isProcessing || state.maybeWhen(
      analyzing: () => true,
      scanning: () => true,
      orElse: () => false,
    );
    return Scaffold(
      appBar: AppBar(title: const Text('Enter Ingredients')),
      resizeToAvoidBottomInset: true,
      body: Stack(
        fit: StackFit.expand,
        children: [
          SafeArea(
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
          if (loading)
            Container(
              color: Colors.black.withValues(alpha: 0.85),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Lottie.asset(
                      'assets/Walking Orange.json',
                      width: 200,
                      height: 200,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'Analysis getting ready...',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
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
