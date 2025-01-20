import 'package:flutter/material.dart';
import 'package:possystem/utils/appColors.dart';

class CustomSwitch extends StatelessWidget {
  final Color? activeColor;
  final Color? inactiveColor;
  final bool value;
  final Function(bool) onChanged;

  const CustomSwitch(
      {super.key,
      this.activeColor = AppColors.primary,
      this.inactiveColor = Colors.white,
      this.value = true,
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Switch(
        value: value,
        activeTrackColor: activeColor,
        inactiveThumbColor: inactiveColor,
        onChanged: (value) {
          onChanged(value);
        });
  }
}
