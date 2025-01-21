import 'package:flutter/material.dart';

int getCrossAxisCount(double screenWidth) {
  if (screenWidth <= 420) {
    return 1; // For smaller screens
  } else if (screenWidth <= 570) {
    return 2; // For small screens
  } else if (screenWidth <= 720) {
    return 3; // For medium screens
  } else {
    return 4; // For large screens
  }
}

double getChildAspectRation(double screenWidth) {
  if (screenWidth <= 420) {
    return 1.4; // For smaller screens
    // } else if (screenWidth <= 570) {
    //   return 1.2; // For small screens
  } else if (screenWidth <= 720) {
    return 0.8; // For medium screens
  } else {
    return 0.9; // For large screens
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
