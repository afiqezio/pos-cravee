import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:possystem/providers/paymentProvider.dart';
import 'package:possystem/utils/appHelper.dart';

class MembershipSection extends ConsumerWidget {
  const MembershipSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              // Handle Barcode Payment
            },
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                color: AppColors.canvasPrimary,
                border: Border.all(color: Color(0xFFCED4DA), width: 1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 24, vertical: 2),
                    child: Text(
                      "Barcode",
                      style: AppTexts.regular(size: 16),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 24, vertical: 2),
                    child: SvgPicture.asset(
                      'assets/svg/widget/forward.svg',
                      width: 20,
                      height: 20,
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          GestureDetector(
            onTap: () {
              ref.read(isPhoneFlagProvider.notifier).state = true;
            },
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                color: AppColors.canvasPrimary,
                border: Border.all(color: Color(0xFFCED4DA), width: 1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 24, vertical: 2),
                    child: Text(
                      "Number Phone",
                      style: AppTexts.regular(size: 16),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 24, vertical: 2),
                    child: SvgPicture.asset(
                      'assets/svg/widget/forward.svg',
                      width: 20,
                      height: 20,
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
