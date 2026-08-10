import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  const AppTextStyles._();

  static TextStyle get heading1 =>
      GoogleFonts.plusJakartaSans(fontSize: 26, fontWeight: FontWeight.w700);
  static TextStyle get heading2 =>
      GoogleFonts.plusJakartaSans(fontSize: 20, fontWeight: FontWeight.w700);
  static TextStyle get heading3 =>
      GoogleFonts.plusJakartaSans(fontSize: 17, fontWeight: FontWeight.w600);
  static TextStyle get body1 =>
      GoogleFonts.plusJakartaSans(fontSize: 16, fontWeight: FontWeight.w400);
  static TextStyle get body2 =>
      GoogleFonts.plusJakartaSans(fontSize: 14, fontWeight: FontWeight.w400);
  static TextStyle get caption =>
      GoogleFonts.plusJakartaSans(fontSize: 12, fontWeight: FontWeight.w400);
  static TextStyle get button =>
      GoogleFonts.plusJakartaSans(fontSize: 16, fontWeight: FontWeight.w600);
}

