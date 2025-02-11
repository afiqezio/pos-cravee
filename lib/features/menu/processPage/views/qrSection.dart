import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:possystem/core/utils/appHelper.dart';

class QrSection extends ConsumerStatefulWidget {
  @override
  _QrSectionState createState() => _QrSectionState();
}

class _QrSectionState extends ConsumerState<QrSection> {
  bool isDot = false;
  bool isDone = false;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.5,
            height: 60,
            child: Card(
              color: AppColors.secondary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              elevation: 0,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Change",
                      style: AppTexts.medium(
                          size: 16, color: AppColors.secondaryText),
                    ),
                    Text(
                      // 'RM${ref.watch(paymentChangeProvider).toStringAsFixed(2)}',
                      'RM0.00',
                      style: AppTexts.regular(
                          size: 16, color: AppColors.secondaryText),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(28.0),
            child: Column(
              children: [
                Image.asset(
                  'assets/images/process/pretzley_qr.png',
                  width: 240,
                  height: 240,
                ),
                const SizedBox(height: 8),
                Text(
                  'Pretzly Sdn. Bhd',
                  style: AppTexts.regular(size: 16),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
