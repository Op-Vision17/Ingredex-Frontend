import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';
import 'dart:async';

import '../../../core/constants/app_text_styles.dart';
import '../../../shared/widgets/app_button.dart';
import '../providers/auth_provider.dart';

class OtpScreen extends ConsumerStatefulWidget {
  const OtpScreen({super.key, required this.email});

  final String email;

  @override
  ConsumerState<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends ConsumerState<OtpScreen>
    with SingleTickerProviderStateMixin {
  bool _isSubmitting = false;
  final _pinController = TextEditingController();
  final _pinFocusNode = FocusNode();
  late final AnimationController _shakeController;
  Timer? _timer;
  int _remainingSeconds = 300;
  ProviderSubscription<AsyncValue<AuthState>>? _authSubscription;

  @override
  void initState() {
    super.initState();
    _shakeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 450),
    );
    _startTimer();
    _authSubscription = ref.listenManual<AsyncValue<AuthState>>(
      authNotifierProvider,
      (prev, next) {
        next.whenOrNull(
          data: (state) => state.when(
            unknown: () {},
            otpSent: (_) {},
            authenticated: (_) {},
            unauthenticated: () {},
            error: (message) {
              if (!mounted) return;
              _shakeController.forward(from: 0);
            },
          ),
        );
      },
    );
  }

  void _startTimer() {
    _timer?.cancel();
    _remainingSeconds = 300;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return;
      if (_remainingSeconds <= 0) {
        timer.cancel();
      } else {
        setState(() => _remainingSeconds--);
      }
    });
  }

  String get _otp => _pinController.text;

  String _formatTime(int totalSeconds) {
    final m = (totalSeconds ~/ 60).toString().padLeft(1, '0');
    final s = (totalSeconds % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  void _onOtpChanged(String rawValue) {
    final value = rawValue.replaceAll(RegExp(r'[^0-9]'), '');
    if (value.isEmpty && rawValue.isNotEmpty) return;
    if (_pinController.text != value) {
      _pinController.value = _pinController.value.copyWith(
        text: value,
        selection: TextSelection.collapsed(offset: value.length),
      );
    }
    setState(() {});
    if (_otp.length == 6) {
      Future.microtask(_verify);
    }
  }

  @override
  void dispose() {
    _authSubscription?.close();
    _timer?.cancel();
    _shakeController.dispose();
    _pinController.dispose();
    _pinFocusNode.dispose();
    super.dispose();
  }

  Future<void> _verify() async {
    if (_otp.length != 6) return;
    if (_isSubmitting) return;
    setState(() => _isSubmitting = true);
    try {
      await ref
          .read(authNotifierProvider.notifier)
          .verifyOtp(widget.email.trim(), _otp);
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  Future<void> _resend() async {
    if (_isSubmitting) return;
    setState(() => _isSubmitting = true);
    try {
      await ref
          .read(authNotifierProvider.notifier)
          .sendOtp(widget.email.trim());
      if (!mounted) return;
      _startTimer();
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  Widget _otpInput(ColorScheme scheme) {
    final defaultPinTheme = PinTheme(
      width: 46,
      height: 52,
      textStyle: Theme.of(context).textTheme.titleMedium,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: scheme.outline),
      ),
    );
    return Pinput(
      controller: _pinController,
      focusNode: _pinFocusNode,
      length: 6,
      autofocus: true,
      keyboardType: TextInputType.number,
      enabled: !_isSubmitting,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      defaultPinTheme: defaultPinTheme,
      focusedPinTheme: defaultPinTheme.copyDecorationWith(
        border: Border.all(color: scheme.primary, width: 1.5),
      ),
      onChanged: _onOtpChanged,
      onCompleted: (_) => Future.microtask(_verify),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: scheme.surface,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text('Verify OTP'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: EdgeInsets.fromLTRB(20, 20, 20, 20 + bottomInset),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Check your email',
                style: AppTextStyles.heading2.copyWith(color: scheme.onSurface),
              ),
              const SizedBox(height: 8),
              Text(
                'We sent a code to ${widget.email}',
                style: AppTextStyles.body2.copyWith(
                  color: scheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 24),
              AnimatedBuilder(
                animation: _shakeController,
                builder: (context, child) {
                  final dx = (_shakeController.value < 0.33)
                      ? -8
                      : (_shakeController.value < 0.66)
                      ? 8
                      : -4;
                  return Transform.translate(
                    offset: Offset(
                      _shakeController.isAnimating ? dx.toDouble() : 0,
                      0,
                    ),
                    child: child,
                  );
                },
                child: Semantics(
                  label: 'One-time passcode',
                  hint: 'Enter the 6-digit code from your email',
                  child: _otpInput(scheme),
                ),
              ),
              const SizedBox(height: 18),
              if (_remainingSeconds > 0)
                Text(
                  'Resend in ${_formatTime(_remainingSeconds)}',
                  style: TextStyle(color: scheme.onSurfaceVariant),
                )
              else
                TextButton(
                  onPressed: _isSubmitting ? null : _resend,
                  child: const Text('Resend OTP'),
                ),
              const SizedBox(height: 28),
              SizedBox(
                width: double.infinity,
                child: AppButton(
                  label: 'Verify',
                  loading: _isSubmitting,
                  onPressed: _verify,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
