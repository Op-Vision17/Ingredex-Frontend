import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ingredex/features/auth/providers/auth_provider.dart';
import '../data/models/profile_models.dart';
import '../data/providers/profile_provider.dart';

class HealthProfileScreen extends ConsumerStatefulWidget {
  const HealthProfileScreen({super.key, this.isOnboarding = false});
  final bool isOnboarding;

  @override
  ConsumerState<HealthProfileScreen> createState() =>
      _HealthProfileScreenState();
}

class _HealthProfileScreenState extends ConsumerState<HealthProfileScreen> {
  final _allergiesController = TextEditingController();
  final _conditionsController = TextEditingController();
  final _dietController = TextEditingController();

  void _loadFromModel(HealthProfile profile) {
    _allergiesController.text = profile.allergies.join(', ');
    _conditionsController.text = profile.medicalConditions.join(', ');
    _dietController.text = profile.dietRecommendations;
  }

  void _onSave() async {
    FocusScope.of(context).unfocus();
    final profile = HealthProfile(
      allergies: _allergiesController.text
          .split(',')
          .map((e) => e.trim())
          .where((e) => e.isNotEmpty)
          .toList(),
      medicalConditions: _conditionsController.text
          .split(',')
          .map((e) => e.trim())
          .where((e) => e.isNotEmpty)
          .toList(),
      dietRecommendations: _dietController.text.trim(),
    );

    await ref.read(profileNotifierProvider.notifier).updateProfile(profile);

    if (mounted) {
      final state = ref.read(profileNotifierProvider);
      if (state.hasError) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Failed: ${state.error}')));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile saved successfully!')),
        );
        if (widget.isOnboarding) {
          ref.read(authNotifierProvider.notifier).dismissOnboarding();
          context.go('/home');
        } else {
          context.pop();
        }
      }
    }
  }

  void _skipOnboarding() {
    ref.read(authNotifierProvider.notifier).dismissOnboarding();
    context.go('/home');
  }

  @override
  Widget build(BuildContext context) {
    final profileAsync = ref.watch(userProfileProvider);
    final isSaving = ref.watch(profileNotifierProvider).isLoading;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isOnboarding ? 'Setup Your Profile' : 'My Health Profile'),
        actions: [
          if (widget.isOnboarding)
            TextButton(
              onPressed: _skipOnboarding,
              child: const Text('Skip'),
            ),
        ],
      ),
      body: profileAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Failed to load profile: $e')),
        data: (profile) {
          if (_allergiesController.text.isEmpty &&
              _conditionsController.text.isEmpty &&
              _dietController.text.isEmpty) {
            _loadFromModel(profile);
          }
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              const Text(
                'Personalize Your Analysis',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'Tell us about your health constraints. We will automatically flag ingredients that interfere with your profile across all your scans.',
              ),
              const SizedBox(height: 24),
              TextField(
                controller: _allergiesController,
                decoration: const InputDecoration(
                  labelText: 'Allergies',
                  hintText: 'e.g., Peanuts, Dairy, Gluten (comma separated)',
                  border: OutlineInputBorder(),
                ),
                maxLines: 2,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _conditionsController,
                decoration: const InputDecoration(
                  labelText: 'Medical Conditions',
                  hintText: 'e.g., Diabetes, Hypertension (comma separated)',
                  border: OutlineInputBorder(),
                ),
                maxLines: 2,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _dietController,
                decoration: const InputDecoration(
                  labelText: 'Dietary Recommendations',
                  hintText:
                      'e.g., Low sodium, Keto, Doctor recommended to avoid sugar',
                  border: OutlineInputBorder(),
                ),
                maxLines: 4,
              ),
              const SizedBox(height: 24),
              FilledButton(
                onPressed: isSaving ? null : _onSave,
                child: isSaving
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : Text(widget.isOnboarding ? 'Continue' : 'Save Profile'),
              ),
            ],
          );
        },
      ),
    );
  }
}
