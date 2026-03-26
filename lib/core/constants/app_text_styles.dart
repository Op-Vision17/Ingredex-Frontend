import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  const AppTextStyles._();

  static TextStyle get heading1 =>
      GoogleFonts.megrim(fontSize: 28, fontWeight: FontWeight.w700);
  static TextStyle get heading2 =>
      GoogleFonts.megrim(fontSize: 22, fontWeight: FontWeight.w700);
  static TextStyle get heading3 =>
      GoogleFonts.megrim(fontSize: 18, fontWeight: FontWeight.w700);
  static TextStyle get body1 =>
      GoogleFonts.smoochSans(fontSize: 20, fontWeight: FontWeight.w500);
  static TextStyle get body2 =>
      GoogleFonts.smoochSans(fontSize: 18, fontWeight: FontWeight.w500);
  static TextStyle get caption =>
      GoogleFonts.smoochSans(fontSize: 16, fontWeight: FontWeight.w500);
  static TextStyle get button =>
      GoogleFonts.smoochSans(fontSize: 20, fontWeight: FontWeight.w600);
}
