import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';

import '../../../core/utils/snackbar_service.dart';
import '../../../shared/widgets/app_button.dart';
import '../../../shared/widgets/app_text_field.dart';
import '../providers/scan_provider.dart';

class OcrScanScreen extends ConsumerStatefulWidget {
  const OcrScanScreen({super.key});

  @override
  ConsumerState<OcrScanScreen> createState() => _OcrScanScreenState();
}

class _OcrScanScreenState extends ConsumerState<OcrScanScreen> {
  File? _image;
  final _name = TextEditingController();
  late final ProviderSubscription<ScanState> _scanSubscription;

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
    super.dispose();
  }

  Future<void> _pick(ImageSource source) async {
    final picker = ImagePicker();
    final file = await picker.pickImage(source: source, imageQuality: 90);
    if (file == null) return;
    setState(() {
      _image = File(file.path);
    });
  }

  Future<void> _scanIngredients() async {
    if (_image == null) return;
    try {
      final ocr = await ref
          .read(scanNotifierProvider.notifier)
          .scanOcr(_image!);
      final analyzed = await ref
          .read(scanNotifierProvider.notifier)
          .analyzeFromOcr(ocr, _name.text.trim().isEmpty ? null : _name.text.trim());
      if (!mounted) return;
      context.push('/result', extra: analyzed);
    } catch (e) {
      if (!mounted) return;
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(scanNotifierProvider);
    final loading = state.maybeWhen(
      scanning: () => true,
      analyzing: () => true,
      orElse: () => false,
    );
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;

    return Scaffold(
      appBar: AppBar(title: const Text('OCR Scan')),
      body: Stack(
        fit: StackFit.expand,
        children: [
          SafeArea(
            child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              padding: EdgeInsets.fromLTRB(16, 16, 16, 16 + bottomInset),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppTextField(
                    controller: _name,
                    hintText: 'Product name (optional)',
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: AppButton(
                          label: 'Take Photo',
                          onPressed: () => _pick(ImageSource.camera),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: AppButton(
                          label: 'Pick from Gallery',
                          onPressed: () => _pick(ImageSource.gallery),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  if (_image != null)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.file(
                        _image!,
                        width: double.infinity,
                        height: 220,
                        fit: BoxFit.cover,
                      ),
                    ),
                  const SizedBox(height: 14),
                  AppButton(
                    label: 'Scan Ingredients',
                    enabled: _image != null && !loading,
                    onPressed: _scanIngredients,
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
                      'assets/Walking Orange.lottie',
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
    );
  }
}
