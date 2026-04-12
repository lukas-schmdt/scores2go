import 'package:flutter/material.dart';

class AppColors {
  // Brand
  static const blue = Color(0xFF0176E4);
  static const teal = Color(0xFF0DBBBA);

  // Keep alias for any code still referencing accentBlue
  static const accentBlue = blue;

  // Dark theme — navy
  static const darkBg = Color(0xFF02122B);
  static const darkSurface = Color(0xFF071E3D);
  static const darkSurfaceElevated = Color(0xFF0D2444);
  static const darkOutline = Color(0x1AFFFFFF); // white 10%
  static const darkTextPrimary = Color(0xFFFFFFFF);
  static const darkTextSecondary = Color(0x99FFFFFF); // white 60%
  static const darkTextMuted = Color(0x61FFFFFF);     // white 38%

  // Light theme — cool white
  static const lightBg = Color(0xFFF0F6FF);
  static const lightSurface = Color(0xFFFFFFFF);
  static const lightSurfaceElevated = Color(0xFFE8F0FB);
  static const lightOutline = Color(0x12000000); // black 7%
  static const lightTextPrimary = Color(0xFF0D1B2A);
  static const lightTextSecondary = Color(0xFF4A5568);
  static const lightTextMuted = Color(0xFF8A9BB0);
}
