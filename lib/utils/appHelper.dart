import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  // Common Colors
  static const Color primary = Color(0xFF7839EE);
  static const Color secondary = Color(0xFFFF6C0E);
  static const Color background = Color(0xFFF2F2F7);
  static const Color transparent = Color(0x00000000);

  // Widget Colors
  static const Color inactive = Color(0xFFD9D9D9);
  static const Color keypad = Color(0xFFF5F5F5);
  static const Color loginKeypad = Color(0xFF474747);

  // Text Colors
  static const Color greyText = Color(0xFF9599AD);

  // Custom Colors
  static const Color green = Color(0xFF16B364);
  static const Color red = Color(0xFFF04438);
  static const Color grey = Color(0xFFDFDFDF);
  static const Color greyDark = Color(0xFF717680);
  static const Color orangeDark100 = Color(0xFFFFE6D5);
  static const Color orangeDark50 = Color(0xFFFFF4ED);
  static const Color violet100 = Color(0xFFECE9FE);
  static const Color indigo100 = Color(0xFFE0EAFF);
  static const Color error100 = Color(0xFFFEE4E2);
}

class AppTexts {
  // Regular text styles
  static TextStyle regular({
    double size = 16,
    Color color = Colors.black,
    FontWeight fontWeight = FontWeight.w400,
  }) {
    return GoogleFonts.poppins(
      fontSize: size,
      fontWeight: fontWeight,
      color: color,
    );
  }

  // Medium text styles
  static TextStyle medium({
    double size = 16,
    Color color = Colors.black,
    FontWeight fontWeight = FontWeight.w500,
  }) {
    return GoogleFonts.poppins(
      fontSize: size,
      fontWeight: fontWeight,
      color: color,
    );
  }

  // Semi-bold text styles
  static TextStyle semiBold({
    double size = 16,
    Color color = Colors.black,
    FontWeight fontWeight = FontWeight.w600,
  }) {
    return GoogleFonts.poppins(
      fontSize: size,
      fontWeight: fontWeight,
      color: color,
    );
  }

  // Bold text styles
  static TextStyle bold({
    double size = 16,
    Color color = Colors.black,
    FontWeight fontWeight = FontWeight.bold,
  }) {
    return GoogleFonts.poppins(
      fontSize: size,
      fontWeight: fontWeight,
      color: color,
    );
  }

  // Light text styles
  static TextStyle light({
    double size = 16,
    Color color = Colors.black,
    FontWeight fontWeight = FontWeight.w300,
  }) {
    return GoogleFonts.poppins(
      fontSize: size,
      fontWeight: fontWeight,
      color: color,
    );
  }

  // Preset styles for common use cases
  static TextStyle heading1 = bold(size: 24);
  static TextStyle heading2 = semiBold(size: 20);
  static TextStyle heading3 = medium(size: 18);
  static TextStyle body = regular(size: 14);
  static TextStyle caption = light(size: 12);
}
