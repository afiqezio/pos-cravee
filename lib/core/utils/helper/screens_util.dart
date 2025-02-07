import 'package:flutter/material.dart';

// Constants for layout calculations
const double smallScreenWidth = 420.0;
const double mediumScreenWidth = 570.0;
const double largeScreenWidth = 720.0;
const double baseColumnWidth = 240.0;

int getCrossAxisCount(double screenWidth) {
  if (screenWidth <= smallScreenWidth) {
    return 1; // For smaller screens
  } else if (screenWidth <= mediumScreenWidth) {
    return 2; // For small screens
  } else if (screenWidth <= largeScreenWidth) {
    return 3; // For medium screens
  } else {
    return (screenWidth / baseColumnWidth)
        .floor(); // For large screens, calculate based on base width
  }
}

double getChildAspectRatio(double screenWidth) {
  if (screenWidth <= smallScreenWidth) {
    return 1.2;
  } else {
    return 0.8;
  }
}

EdgeInsets getPadding(double screenWidth) {
  if (screenWidth <= 600) {
    return EdgeInsets.symmetric(horizontal: 300.0);
  } else if (screenWidth <= 720) {
    return EdgeInsets.symmetric(horizontal: 200.0);
  } else {
    return EdgeInsets.symmetric(horizontal: 70.0);
  }
}