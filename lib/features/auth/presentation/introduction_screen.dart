import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:ingredex/core/constants/app_colors.dart';
import 'package:ingredex/features/auth/providers/auth_provider.dart';

class IntroductionOnboardingScreen extends ConsumerWidget {
  const IntroductionOnboardingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final pageDecoration = PageDecoration(
      titleTextStyle: const TextStyle(
        fontSize: 28.0,
        fontWeight: FontWeight.w700,
      ),
      bodyTextStyle: TextStyle(
        fontSize: 16.0,
        color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
      ),
      bodyPadding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: isDark ? AppColors.darkBackground : AppColors.lightBackground,
      imagePadding: EdgeInsets.zero,
      imageAlignment: Alignment.bottomCenter,
    );

    return IntroductionScreen(
      key: const ValueKey('introduction_screen'),
      globalBackgroundColor: isDark ? AppColors.darkBackground : AppColors.lightBackground,
      pages: [
        PageViewModel(
          title: "Know What You Eat",
          body: "Get instant AI-powered analysis of every ingredient in your food. No more guessing what's in your diet.",
          image: _buildImage('assets/Doctor.json'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Eat Right for Your Body",
          body: "Set your allergies, medical conditions, and dietary needs. We'll flag anything that's not right for you.",
          image: _buildImage('assets/Healthy or Junk food.json'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Scan Anything, Anywhere",
          body: "Scan a barcode or snap a photo of the ingredients label. Ingredex does the rest in seconds.",
          image: _buildImage('assets/Barcode Scanner.json'),
          decoration: pageDecoration,
        ),
      ],
      onDone: () => _onIntroEnd(context, ref),
      onSkip: () => _onIntroEnd(context, ref),
      showSkipButton: true,
      skipOrBackFlex: 0,
      nextFlex: 0,
      showBackButton: false,
      skip: const Text('Skip', style: TextStyle(fontWeight: FontWeight.w600, color: AppColors.primaryOrange)),
      next: const Icon(Icons.arrow_forward, color: AppColors.primaryOrange),
      done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600, color: AppColors.primaryOrange)),
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.all(16),
      controlsPadding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeColor: AppColors.primaryOrange,
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    );
  }

  Widget _buildImage(String assetName) {
    return Center(
      child: Lottie.asset(assetName, height: 250, repeat: true),
    );
  }

  void _onIntroEnd(BuildContext context, WidgetRef ref) {
    // Set needsOnboarding = false
    ref.read(authNotifierProvider.notifier).dismissOnboarding();
    // Navigate to profile setup
    context.go('/profile-setup');
  }
}
