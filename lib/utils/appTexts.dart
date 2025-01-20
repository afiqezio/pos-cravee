import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
