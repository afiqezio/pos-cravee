import 'package:flutter/material.dart';
import 'package:possystem/core/utils/appHelper.dart';

class SizeSection extends StatelessWidget {
  const SizeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 12,
      children: [
        Text(
          'Size',
          style: AppTexts.medium(size: 16),
        ),
        const Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Font size',
              style: AppTexts.regular(size: 16),
            ),
            Text(
              '16',
              style: AppTexts.regular(size: 16),
            ),
          ],
        ),
        const Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Card\'s size',
              style: AppTexts.regular(size: 16),
            ),
            Text(
              '16',
              style: AppTexts.regular(size: 16),
            ),
          ],
        ),
      ],
    );
  }
}
