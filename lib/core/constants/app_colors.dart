import 'package:flutter/material.dart';

class AppColors {
  const AppColors._();

  // Primary Brand Identity (Health-Tech Slate & Vitality)
  static const primaryEmerald = Color(0xFF10B981);
  static const primaryEmeraldDark = Color(0xFF059669);
  static const accentTangerine = Color(0xFFF97316);
  static const accentAmber = Color(0xFFF59E0B);

  // Legacy compatibility tokens
  static const primaryOrange = Color(0xFF10B981); // Emerald health brand
  static const lightOrange = Color(0xFF34D399); // Soft mint emerald
  static const darkBlack = Color(0xFF0F172A);
  static const creamWhite = Color(0xFFF8FAFC);

  // Light theme colors (Crisp Slate Canvas)
  static const lightBackground = Color(0xFFF8FAFC);
  static const lightSurface = Color(0xFFFFFFFF);
  static const lightCard = Color(0xFFFFFFFF);
  static const lightText = Color(0xFF0F172A);
  static const lightTextSecondary = Color(0xFF64748B);
  static const lightDivider = Color(0xFFE2E8F0);
  static const lightBorder = Color(0xFFE2E8F0);

  // Dark theme colors (Deep Midnight OLED)
  static const darkBackground = Color(0xFF0B0F17);
  static const darkSurface = Color(0xFF1E293B);
  static const darkCard = Color(0xFF1E293B);
  static const darkText = Color(0xFFF8FAFC);
  static const darkTextSecondary = Color(0xFF94A3B8);
  static const darkDivider = Color(0xFF334155);
  static const darkBorder = Color(0xFF334155);

  // Semantic & Risk Tier Colors
  static const success = Color(0xFF10B981);
  static const warning = Color(0xFFF59E0B);
  static const error = Color(0xFFEF4444);

  static const lowRisk = Color(0xFF10B981);
  static const lowRiskBg = Color(0xFFECFDF5);
  static const lowRiskBorder = Color(0xFFA7F3D0);

  static const mediumRisk = Color(0xFFF59E0B);
  static const mediumRiskBg = Color(0xFFFFFBEB);
  static const mediumRiskBorder = Color(0xFFFDE68A);

  static const highRisk = Color(0xFFEF4444);
  static const highRiskBg = Color(0xFFFEF2F2);
  static const highRiskBorder = Color(0xFFFECACA);

  // Dark Mode Semantic Backgrounds
  static const darkLowRiskBg = Color(0xFF064E3B);
  static const darkMediumRiskBg = Color(0xFF78350F);
  static const darkHighRiskBg = Color(0xFF7F1D1D);
}
