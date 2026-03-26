import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../../core/constants/app_colors.dart';
import '../providers/scan_provider.dart';

class BarcodeScanScreen extends ConsumerStatefulWidget {
  const BarcodeScanScreen({super.key});

  @override
  ConsumerState<BarcodeScanScreen> createState() => _BarcodeScanScreenState();
}

class _BarcodeScanScreenState extends ConsumerState<BarcodeScanScreen> {
  final MobileScannerController _scannerController = MobileScannerController(
    torchEnabled: false,
    detectionSpeed: DetectionSpeed.noDuplicates,
  );
  bool _isProcessing = false;
  bool _hasPermissionError = false;

  void _markPermissionError() {
    if (_hasPermissionError || !mounted) return;
    setState(() => _hasPermissionError = true);
  }

  @override
  void dispose() {
    _scannerController.dispose();
    super.dispose();
  }

  Future<void> _onDetect(BarcodeCapture capture) async {
    if (_isProcessing) return;
    final code = capture.barcodes.first.rawValue;
    if (code == null || code.isEmpty) return;
    _isProcessing = true;
    await HapticFeedback.mediumImpact();
    try {
      final barcode = await ref
          .read(scanNotifierProvider.notifier)
          .scanBarcode(code);
      final analyzed = await ref
          .read(scanNotifierProvider.notifier)
          .analyzeFromBarcode(barcode);
      if (!mounted) return;
      context.push('/result', extra: analyzed);
    } catch (_) {
      if (!mounted) return;
    } finally {
      _isProcessing = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final scanState = ref.watch(scanNotifierProvider);
    final isBusy = scanState.maybeWhen(
      scanning: () => true,
      analyzing: () => true,
      orElse: () => false,
    );

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          MobileScanner(
            controller: _scannerController,
            onDetect: _onDetect,
            errorBuilder: (context, error, child) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                _markPermissionError();
              });
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.camera_alt_outlined, size: 56),
                      const SizedBox(height: 12),
                      Text(
                        'Camera permission is required for barcode scanning.',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          if (!_hasPermissionError) ...[
            Container(color: Colors.black.withValues(alpha: 0.35)),
            Center(
              child: SizedBox(
                width: 260,
                height: 180,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.2),
                          ),
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                    ..._corners(),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  child: Row(
                    children: [
                      IconButton.filledTonal(
                        onPressed: () => context.pop(),
                        icon: const Icon(Icons.arrow_back),
                      ),
                      const Spacer(),
                      IconButton.filledTonal(
                        onPressed: () => _scannerController.toggleTorch(),
                        icon: const Icon(Icons.flashlight_on_rounded),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 42),
                child: Text(
                  isBusy ? 'Analyzing barcode...' : 'Point camera at barcode',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  List<Widget> _corners() {
    const size = 32.0;
    const stroke = 4.0;
    return [
      Positioned(
        left: 0,
        top: 0,
        child: _cornerBox(size: size, stroke: stroke, top: true, left: true),
      ),
      Positioned(
        right: 0,
        top: 0,
        child: _cornerBox(size: size, stroke: stroke, top: true, left: false),
      ),
      Positioned(
        left: 0,
        bottom: 0,
        child: _cornerBox(size: size, stroke: stroke, top: false, left: true),
      ),
      Positioned(
        right: 0,
        bottom: 0,
        child: _cornerBox(size: size, stroke: stroke, top: false, left: false),
      ),
    ];
  }

  Widget _cornerBox({
    required double size,
    required double stroke,
    required bool top,
    required bool left,
  }) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        border: Border(
          top: top
              ? BorderSide(color: AppColors.primaryOrange, width: stroke)
              : BorderSide.none,
          bottom: !top
              ? BorderSide(color: AppColors.primaryOrange, width: stroke)
              : BorderSide.none,
          left: left
              ? BorderSide(color: AppColors.primaryOrange, width: stroke)
              : BorderSide.none,
          right: !left
              ? BorderSide(color: AppColors.primaryOrange, width: stroke)
              : BorderSide.none,
        ),
        borderRadius: BorderRadius.only(
          topLeft: top && left ? const Radius.circular(12) : Radius.zero,
          topRight: top && !left ? const Radius.circular(12) : Radius.zero,
          bottomLeft: !top && left ? const Radius.circular(12) : Radius.zero,
          bottomRight: !top && !left ? const Radius.circular(12) : Radius.zero,
        ),
      ),
    );
  }
}
