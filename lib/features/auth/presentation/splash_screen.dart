import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:video_player/video_player.dart';
import '../providers/splash_provider.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  late VideoPlayerController _controller;
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    _initializeVideo();
  }

  Future<void> _initializeVideo() async {
    _controller = VideoPlayerController.asset('assets/logo_splash.mp4');
    
    try {
      await _controller.initialize();
      _controller.setVolume(0.0); // Muted as per request
      _controller.setLooping(false);
      
      if (mounted) {
        setState(() {
          _initialized = true;
        });
        _controller.play();
      }

      // Listen for video completion
      _controller.addListener(_videoListener);
      
    } catch (e) {
      debugPrint('Error initializing splash video: $e');
      // Fallback: mark as completed anyway if error occurs so app isn't stuck
      _onVideoEnd();
    }
  }

  void _videoListener() {
    if (_controller.value.position >= _controller.value.duration) {
      _onVideoEnd();
    }
  }

  void _onVideoEnd() {
    if (mounted) {
      ref.read(splashCompletedProvider.notifier).state = true;
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_videoListener);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: _initialized
            ? SizedBox.expand(
                child: FittedBox(
                  fit: BoxFit.fitWidth,
                  child: SizedBox(
                    width: _controller.value.size.width,
                    height: _controller.value.size.height,
                    child: VideoPlayer(_controller),
                  ),
                ),
              )
            : const SizedBox.shrink(), // Keep it black while initializing
      ),
    );
  }
}
