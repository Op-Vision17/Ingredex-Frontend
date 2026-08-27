import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/utils/snackbar_service.dart';
import '../../auth/providers/auth_provider.dart';
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

  static const List<String> _popularAllergens = [
    '🥛 Dairy',
    '🌾 Gluten',
    '🥜 Peanuts',
    '🥚 Eggs',
    '🐟 Fish',
    '🦐 Shellfish',
    '🌰 Tree Nuts',
    '🌱 Soy',
  ];

  static const List<String> _popularConditions = [
    '🩺 Diabetes',
    '🫀 Hypertension',
    '🫁 Asthma',
    '🛡️ Celiac',
    '⚡ Acid Reflux',
    '🥑 High Cholesterol',
  ];

  static const List<String> _popularDiets = [
    '🥑 Keto',
    '🌱 Vegan',
    '🥗 Low Sugar',
    '🚫 No Preservatives',
    '🧂 Low Sodium',
  ];

  void _loadFromModel(HealthProfile profile) {
    _allergiesController.text = profile.allergies.join(', ');
    _conditionsController.text = profile.medicalConditions.join(', ');
    _dietController.text = profile.dietRecommendations;
  }

  void _toggleChip(TextEditingController controller, String labelWithEmoji) {
    // Extract raw term without emoji
    final term = labelWithEmoji.replaceAll(RegExp(r'[^\w\s]'), '').trim();
    final currentList = controller.text
        .split(',')
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList();

    final existingIndex = currentList.indexWhere(
      (item) => item.toLowerCase() == term.toLowerCase(),
    );

    if (existingIndex >= 0) {
      currentList.removeAt(existingIndex);
    } else {
      currentList.add(term);
    }

    setState(() {
      controller.text = currentList.join(', ');
    });
  }

  bool _isChipSelected(TextEditingController controller, String labelWithEmoji) {
    final term = labelWithEmoji.replaceAll(RegExp(r'[^\w\s]'), '').trim().toLowerCase();
    final currentList = controller.text
        .split(',')
        .map((e) => e.trim().toLowerCase())
        .where((e) => e.isNotEmpty);
    return currentList.contains(term);
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
        SnackBarService.show('Unable to save profile. Please check connection.');
      } else {
        SnackBarService.show('Health profile updated successfully!');
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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final profileAsync = ref.watch(userProfileProvider);
    final isSaving = ref.watch(profileNotifierProvider).isLoading;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isOnboarding ? 'Setup Health Profile' : 'My Health Profile'),
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
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
            children: [
              Text(
                'Personalized Health Guard',
                style: AppTextStyles.heading1.copyWith(
                  fontSize: 22,
                  color: isDark ? AppColors.darkText : AppColors.lightText,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Select or write your health profile. Ingredex will tailor every product scan against your sensitivities.',
                style: AppTextStyles.body2.copyWith(
                  color: isDark
                      ? AppColors.darkTextSecondary
                      : AppColors.lightTextSecondary,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 20),

              // Section 1: Allergies
              _buildSectionHeader(
                icon: Icons.warning_amber_rounded,
                title: 'Allergies & Intolerances',
                color: AppColors.highRisk,
                isDark: isDark,
              ),
              const SizedBox(height: 8),
              _buildChipGroup(
                chips: _popularAllergens,
                controller: _allergiesController,
                color: AppColors.highRisk,
                isDark: isDark,
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _allergiesController,
                decoration: const InputDecoration(
                  labelText: 'Custom Allergies (comma separated)',
                  hintText: 'e.g. Peanuts, Gluten, Dairy',
                ),
                maxLines: 2,
              ),
              const SizedBox(height: 24),

              // Section 2: Medical Conditions
              _buildSectionHeader(
                icon: Icons.monitor_heart_outlined,
                title: 'Medical Conditions',
                color: AppColors.accentAmber,
                isDark: isDark,
              ),
              const SizedBox(height: 8),
              _buildChipGroup(
                chips: _popularConditions,
                controller: _conditionsController,
                color: AppColors.accentAmber,
                isDark: isDark,
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _conditionsController,
                decoration: const InputDecoration(
                  labelText: 'Custom Medical Conditions (comma separated)',
                  hintText: 'e.g. Diabetes, Hypertension, IBS',
                ),
                maxLines: 2,
              ),
              const SizedBox(height: 24),

              // Section 3: Diets & Lifestyle
              _buildSectionHeader(
                icon: Icons.eco_outlined,
                title: 'Dietary Preferences',
                color: AppColors.primaryEmerald,
                isDark: isDark,
              ),
              const SizedBox(height: 8),
              _buildChipGroup(
                chips: _popularDiets,
                controller: _dietController,
                color: AppColors.primaryEmerald,
                isDark: isDark,
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _dietController,
                decoration: const InputDecoration(
                  labelText: 'Diet Goals / Doctor Instructions',
                  hintText: 'e.g. Keto, Low sugar, Avoid artificial sweeteners',
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 30),

              // Save Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: isSaving ? null : _onSave,
                  child: isSaving
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : Text(widget.isOnboarding ? 'Save & Continue' : 'Save Health Profile'),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSectionHeader({
    required IconData icon,
    required String title,
    required Color color,
    required bool isDark,
  }) {
    return Row(
      children: [
        Icon(icon, size: 18, color: color),
        const SizedBox(width: 8),
        Text(
          title,
          style: AppTextStyles.heading3.copyWith(
            fontSize: 15,
            color: isDark ? AppColors.darkText : AppColors.lightText,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }

  Widget _buildChipGroup({
    required List<String> chips,
    required TextEditingController controller,
    required Color color,
    required bool isDark,
  }) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: chips.map((chipLabel) {
        final selected = _isChipSelected(controller, chipLabel);
        return FilterChip(
          label: Text(chipLabel),
          selected: selected,
          onSelected: (_) => _toggleChip(controller, chipLabel),
          selectedColor: color.withValues(alpha: isDark ? 0.25 : 0.15),
          checkmarkColor: color,
          labelStyle: AppTextStyles.body2.copyWith(
            fontSize: 13,
            fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
            color: selected
                ? color
                : (isDark ? AppColors.darkText : AppColors.lightText),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(
              color: selected
                  ? color
                  : (isDark ? AppColors.darkBorder : AppColors.lightBorder),
            ),
          ),
        );
      }).toList(),
    );
  }
}
