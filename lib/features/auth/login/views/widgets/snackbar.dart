import 'package:flutter/material.dart';
import 'package:possystem/utils/appHelper.dart';

void showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: AppTexts.medium(size: 16, color: AppColors.secondaryText),
      ),
      backgroundColor: AppColors.red,
    ),
  );
}
