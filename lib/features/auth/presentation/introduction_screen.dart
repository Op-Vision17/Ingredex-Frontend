import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:ingredex/core/constants/app_colors.dart';
import 'package:ingredex/features/auth/providers/auth_provider.dart';

class IntroductionOnboardingScreen extends ConsumerStatefulWidget {
  const IntroductionOnboardingScreen({super.key});

  @override
  ConsumerState<IntroductionOnboardingScreen> createState() => _IntroductionOnboardingScreenState();
}

class _IntroductionOnboardingScreenState extends ConsumerState<IntroductionOnboardingScreen> {
  int _currentPage = 0;
  final _introKey = GlobalKey<IntroductionScreenState>();

  // Design Constants
  static const _bgColor1 = AppColors.darkBackground;
  static const _bgColor2 = AppColors.darkSurface;
  static const _accentPrimary = AppColors.primaryOrange;
  static const _accentSecondary = AppColors.lightOrange;

  void _onIntroEnd(BuildContext context, WidgetRef ref) {
    ref.read(authNotifierProvider.notifier).dismissOnboarding();
    context.go('/profile-setup');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 1. Immersive Background Gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [_bgColor1, _bgColor2],
              ),
            ),
          ),

          // 2. Subtle Background Accent Circles
          _buildBackgroundAccent(_currentPage),

          // 3. Introduction Screen
          SafeArea(
            child: IntroductionScreen(
              key: _introKey,
              globalBackgroundColor: Colors.transparent,
              allowImplicitScrolling: true,
              pages: [
                _buildPage(
                  title: "Know What You Eat",
                  body: "Get instant AI-powered analysis of every ingredient in your food. No more guessing what's in your diet.",
                  assetName: 'assets/Doctor.json',
                ),
                _buildPage(
                  title: "Eat Right for Your Body",
                  body: "Set your allergies, medical conditions, and dietary needs. We'll flag anything that's not right for you.",
                  assetName: 'assets/Healthy or Junk food.json',
                ),
                _buildPage(
                  title: "Scan Anything, Anywhere",
                  body: "Scan a barcode or snap a photo of the ingredients label. Ingredex does the rest in seconds.",
                  assetName: 'assets/Barcode Scanner.json',
                ),
              ],
              onDone: () => _onIntroEnd(context, ref),
              onSkip: () => _onIntroEnd(context, ref),
              showSkipButton: true,
              showNextButton: true,
              showDoneButton: true,
              onChange: (page) {
                setState(() {
                  _currentPage = page;
                });
              },
              skip: Text(
                'Skip',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.5),
                  fontWeight: FontWeight.w500,
                ),
              ),
              next: _buildNextButton(),
              done: _buildDoneButton(),
              dotsDecorator: const DotsDecorator(
                size: Size(0, 0), // Hide default dots
                activeSize: Size(0, 0),
                color: Colors.transparent,
                activeColor: Colors.transparent,
              ),
              // We'll overlay SmoothPageIndicator instead
            ),
          ),

          // 4. Custom Smooth Page Indicator Overlay
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Center(
              child: AnimatedSmoothIndicator(
                activeIndex: _currentPage,
                count: 3,
                effect: WormEffect(
                  activeDotColor: _accentPrimary,
                  dotColor: Colors.white.withOpacity(0.3),
                  dotHeight: 8,
                  dotWidth: 8,
                  spacing: 10,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  PageViewModel _buildPage({
    required String title,
    required String body,
    required String assetName,
  }) {
    return PageViewModel(
      titleWidget: _buildTitleWidget(title),
      bodyWidget: _buildBodyWidget(body),
      image: _buildGlassCard(assetName),
      decoration: const PageDecoration(
        imagePadding: EdgeInsets.only(top: 40, bottom: 20),
        contentMargin: EdgeInsets.symmetric(horizontal: 24),
        bodyAlignment: Alignment.center,
        imageAlignment: Alignment.center,
      ),
    );
  }

  Widget _buildTitleWidget(String title) {
    return Column(
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          height: 3,
          width: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: const LinearGradient(
              colors: [_accentPrimary, _accentSecondary],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBodyWidget(String body) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Text(
        body,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white.withOpacity(0.75),
          fontSize: 15,
          fontWeight: FontWeight.w400,
          height: 1.6,
        ),
      ),
    );
  }

  Widget _buildGlassCard(String assetName) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 40),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(32),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            height: 320,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(32),
              border: Border.all(
                color: Colors.white.withOpacity(0.1),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 20,
                  spreadRadius: -5,
                ),
              ],
            ),
            child: Center(
              child: Lottie.asset(
                assetName,
                height: 240,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNextButton() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        gradient: const LinearGradient(
          colors: [_accentPrimary, _accentSecondary],
        ),
        boxShadow: [
          BoxShadow(
            color: _accentPrimary.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Next',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          SizedBox(width: 8),
          Icon(Icons.arrow_forward_ios, size: 14, color: Colors.white),
        ],
      ),
    );
  }

  Widget _buildDoneButton() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        gradient: const LinearGradient(
          colors: [_accentPrimary, _accentSecondary],
        ),
        boxShadow: [
          BoxShadow(
            color: _accentPrimary.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Get Started',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          SizedBox(width: 8),
          Icon(Icons.check, size: 18, color: Colors.white),
        ],
      ),
    );
  }

  Widget _buildBackgroundAccent(int page) {
    Color accentColor;
    Alignment alignment;

    switch (page) {
      case 0:
        accentColor = _accentPrimary;
        alignment = const Alignment(-0.8, -0.6);
        break;
      case 1:
        accentColor = _accentSecondary;
        alignment = const Alignment(0.8, 0.2);
        break;
      case 2:
        accentColor = AppColors.primaryOrange;
        alignment = const Alignment(-0.2, 0.8);
        break;
      default:
        accentColor = _accentPrimary;
        alignment = Alignment.center;
    }

    return AnimatedAlign(
      duration: const Duration(seconds: 1),
      curve: Curves.easeInOut,
      alignment: alignment,
      child: AnimatedContainer(
        duration: const Duration(seconds: 1),
        height: 300,
        width: 300,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: accentColor.withOpacity(0.15),
          boxShadow: [
            BoxShadow(
              color: accentColor.withOpacity(0.15),
              blurRadius: 100,
              spreadRadius: 50,
            ),
          ],
        ),
      ),
    );
  }
}
