import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/utils/validators.dart';
import '../../../shared/widgets/app_button.dart';
import '../../../shared/widgets/app_text_field.dart';
import '../providers/auth_provider.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  bool _isSubmitting = false;
  late final AnimationController _controller;
  late final Animation<Offset> _slide;
  late final Animation<double> _fade;
  late final ProviderSubscription<AsyncValue<AuthState>> _authSubscription;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _slide = Tween<Offset>(
      begin: const Offset(0, 0.12),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));
    _fade = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _controller.forward();
    _authSubscription = ref.listenManual<AsyncValue<AuthState>>(
      authNotifierProvider,
      (prev, next) {
        next.whenOrNull(
          data: (state) => state.whenOrNull(
            otpSent: (email) {
              if (!mounted) return;
              context.push('/otp/${Uri.encodeComponent(email)}');
            },
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _authSubscription.close();
    _controller.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    if (_isSubmitting) return;
    setState(() => _isSubmitting = true);
    try {
      await ref
          .read(authNotifierProvider.notifier)
          .sendOtp(_emailController.text.trim());
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;
    return Scaffold(
      backgroundColor: scheme.surface,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(24, 12, 24, 280),
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: MediaQuery.sizeOf(context).height * 0.5,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 30),
                      SizedBox(
                        width: double.infinity,
                        child: Text(
                          'Ingredex',
                          textAlign: TextAlign.center,
                          style: AppTextStyles.heading1.copyWith(
                            color: AppColors.primaryOrange,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        width: double.infinity,
                        child: Text(
                          "Know what's in your food",
                          textAlign: TextAlign.center,
                          style: AppTextStyles.body1.copyWith(
                            color: scheme.onSurface,
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                      Icon(
                        Icons.eco_rounded,
                        size: 180,
                        color: AppColors.primaryOrange.withValues(alpha: 0.85),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: SlideTransition(
                position: _slide,
                child: FadeTransition(
                  opacity: _fade,
                  child: Padding(
                    // Add keyboard inset only once to avoid bottom overflow.
                    padding: EdgeInsets.only(bottom: bottomInset),
                    child: Material(
                      color: scheme.surfaceContainerHighest,
                      elevation: 8,
                      shadowColor: scheme.shadow,
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(32),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                'Welcome to Ingredex',
                                textAlign: TextAlign.center,
                                style: AppTextStyles.heading2.copyWith(
                                  color: scheme.onSurface,
                                ),
                              ),
                              const SizedBox(height: 16),
                              AppTextField(
                                controller: _emailController,
                                hintText: 'Email',
                                keyboardType: TextInputType.emailAddress,
                                validator: Validators.email,
                              ),
                              const SizedBox(height: 16),
                              DecoratedBox(
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [
                                      AppColors.lightOrange,
                                      AppColors.primaryOrange,
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: AppButton(
                                  label: 'Send OTP',
                                  loading: _isSubmitting,
                                  onPressed: _submit,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
