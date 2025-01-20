import 'package:flutter/material.dart';
import 'package:possystem/utils/appTexts.dart';
import 'package:possystem/utils/widget/customSwitch.dart';

class ThemeSection extends StatelessWidget {
  const ThemeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Theme',
          style: AppTexts.medium(size: 16),
        ),
        const Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Light',
              style: AppTexts.regular(size: 16),
            ),
            CustomSwitch(value: true, onChanged: (value) {}),
          ],
        ),
        const Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Dark',
              style: AppTexts.regular(size: 16),
            ),
            CustomSwitch(value: false, onChanged: (value) {}),
          ],
        ),
      ],
    );
  }
}
