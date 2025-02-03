import 'package:flutter/material.dart';
import 'package:possystem/core/utils/appHelper.dart';

class CustomActionButton extends StatelessWidget {
  final String label;
  final IconData? icon;
  final Color? iconColor;
  final VoidCallback? onTap;
  final Color backgroundColor;
  final Color borderColor;
  final TextStyle? textStyle;
  final double? borderRadius;
  final EdgeInsets? padding;

  CustomActionButton({
    Key? key,
    required this.label,
    this.icon,
    this.iconColor,
    this.onTap,
    this.backgroundColor = AppColors.secondary,
    this.borderColor = AppColors.transparent,
    this.textStyle,
    this.borderRadius = 6,
    this.padding = const EdgeInsets.all(12),
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(borderRadius!),
          border: Border.all(color: borderColor),
        ),
        child: Padding(
          padding: padding!,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                label,
                style: textStyle ??
                    AppTexts.regular(size: 16, color: Colors.white),
              ),
              SizedBox(width: 6),
              icon != null
                  ? Icon(icon, color: iconColor ?? Colors.white, size: 20)
                  : const SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}
