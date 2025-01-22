import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:possystem/utils/appHelper.dart';

class SuccessfulSection extends ConsumerStatefulWidget {
  @override
  _SuccessfulSectionState createState() => _SuccessfulSectionState();
}

class _SuccessfulSectionState extends ConsumerState<SuccessfulSection> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(36.0),
        child: Column(
          children: [
            Container(
              width: 55,
              height: 55,
              decoration: BoxDecoration(
                color: AppColors.secondary,
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.secondary,
                  width: 1,
                ),
              ),
              child: Center(
                  child: Icon(
                Icons.check,
                color: Colors.white,
              )),
            ),
            Padding(
              padding: const EdgeInsets.all(28.0),
              child: Text(
                'Successful Payment',
                style: AppTexts.semiBold(size: 24),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
