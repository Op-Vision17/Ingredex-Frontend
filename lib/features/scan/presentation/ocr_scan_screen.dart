import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../../shared/widgets/app_button.dart';
import '../providers/scan_provider.dart';

class OcrScanScreen extends ConsumerStatefulWidget {
  const OcrScanScreen({super.key});

  @override
  ConsumerState<OcrScanScreen> createState() => _OcrScanScreenState();
}

class _OcrScanScreenState extends ConsumerState<OcrScanScreen> {
  File? _image;
  String? _textPreview;
  double? _confidence;
  bool _showFullPreview = false;

  Future<void> _pick(ImageSource source) async {
    final picker = ImagePicker();
    final file = await picker.pickImage(source: source, imageQuality: 90);
    if (file == null) return;
    setState(() {
      _image = File(file.path);
      _textPreview = null;
      _confidence = null;
      _showFullPreview = false;
    });
  }

  Future<void> _scanIngredients() async {
    if (_image == null) return;
    try {
      final ocr = await ref
          .read(scanNotifierProvider.notifier)
          .scanOcr(_image!);
      setState(() {
        _textPreview = ocr.extractedText;
        _confidence = ocr.confidence;
      });
      final analyzed = await ref
          .read(scanNotifierProvider.notifier)
          .analyzeFromOcr(ocr);
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
    final scheme = Theme.of(context).colorScheme;
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;

    return Scaffold(
      appBar: AppBar(title: const Text('OCR Scan')),
      body: SafeArea(
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: EdgeInsets.fromLTRB(16, 16, 16, 16 + bottomInset),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                label: loading ? 'Reading ingredients...' : 'Scan Ingredients',
                loading: loading,
                enabled: _image != null,
                onPressed: _scanIngredients,
              ),
              if (_confidence != null) ...[
                const SizedBox(height: 10),
                Text(
                  'Confidence: ${(_confidence! * 100).toStringAsFixed(0)}%',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: scheme.onSurfaceVariant,
                  ),
                ),
              ],
              if (_textPreview != null) ...[
                const SizedBox(height: 10),
                Text(
                  _textPreview!,
                  maxLines: _showFullPreview ? null : 8,
                  overflow: _showFullPreview
                      ? TextOverflow.visible
                      : TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                if (_textPreview!.length > 220)
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton(
                      onPressed: () {
                        setState(() => _showFullPreview = !_showFullPreview);
                      },
                      child: Text(_showFullPreview ? 'Show less' : 'Show more'),
                    ),
                  ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
