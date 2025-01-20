import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:possystem/providers/cartProvider.dart';
import 'package:possystem/providers/paymentProvider.dart';
import 'package:possystem/utils/appColors.dart';
import 'package:possystem/utils/widget/customBackButton.dart';
import 'package:possystem/utils/widget/customCircle.dart';
import 'package:possystem/utils/widget/customMainContainer.dart';
import 'package:possystem/views/menu/processPage/cashSection.dart';
import 'package:possystem/views/menu/processPage/membership.dart';
import 'package:possystem/views/menu/processPage/phoneNumber.dart';
import 'package:possystem/views/menu/processPage/processingSection.dart';
import 'package:possystem/views/menu/processPage/qrSection.dart';
import 'successfulSection.dart';

class ProcessPageMain extends ConsumerWidget {
  final bool isMembership;
  final bool isPayment;
  final bool isSuccesful;
  final String type;

  const ProcessPageMain({
    Key? key,
    required this.isMembership,
    required this.isPayment,
    required this.isSuccesful,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F7),
      body: CustomMainContainer(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Row for Back and Skip buttons
            type != 'success' && type != 'processing'
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomBackButton(),
                      !isPayment
                          ? TextButton(
                              onPressed: () {
                                context.go(
                                    '/menu/productpicker/process/membership/confirmationCart');
                              },
                              child: const Text(
                                "Skip",
                                style: TextStyle(
                                    color: AppColors.secondary, fontSize: 16),
                              ),
                            )
                          : type == 'qr'
                              ? TextButton(
                                  onPressed: () {
                                    context.go(
                                        '/menu/productpicker/process/membership/confirmationCart/processQr/processSuccessful');
                                  },
                                  child: const Text(
                                    "Continue",
                                    style: TextStyle(
                                        color: AppColors.secondary,
                                        fontSize: 16),
                                  ),
                                )
                              : SizedBox.shrink(),
                    ],
                  )
                : SizedBox.shrink(),
            const SizedBox(height: 6),
            // Progress Bar
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 70),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _buildProgressCircle("1", "Membership", isMembership),
                  _buildProgressDivider(),
                  _buildProgressCircle("2", "Payment", isPayment),
                  _buildProgressDivider(),
                  _buildProgressCircle("3", "Successful", isSuccesful),
                ],
              ),
            ),
            const SizedBox(height: 10),
            // Card for Grand Total
            type != 'success' && type != 'processing'
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.38,
                        child: Card(
                          color: AppColors.secondary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          elevation: 0,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Grand Total : ",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  'RM${ref.watch(cartSalesProvider).subtotal.toStringAsFixed(2)}',
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                : SizedBox.shrink(),
            const SizedBox(height: 10),
            if (isMembership) ...[
              ref.watch(isPhoneFlagProvider)
                  ? PhoneNumberSection()
                  : MembershipSection(),
            ] else if (isPayment) ...[
              if (type == 'cash') ...[
                CashSection()
              ] else if (type == 'qr') ...[
                QrSection()
              ]
            ] else if (isSuccesful) ...[
              if (type == 'success') ...[
                SuccessfulSection()
              ] else if (type == 'processing') ...[
                ProcessingSection()
              ]
            ],
          ],
        ),
      ),
    );
  }

  // Helper widget for the progress circle
  Widget _buildProgressCircle(String number, String label, bool isCompleted) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 15,
            color: isCompleted ? AppColors.secondary : Colors.black,
          ),
        ),
        const SizedBox(height: 12),
        CustomCircle(
          size: 40,
          fillColor: isCompleted ? AppColors.secondary : Colors.white,
          borderColor: AppColors.secondary,
          borderThickness: 1.0,
          child: Text(number,
              style: TextStyle(
                color: isCompleted ? Colors.white : Colors.black,
                fontSize: 16,
              )),
        ),
      ],
    );
  }

  // Helper widget for the progress divider
  Widget _buildProgressDivider() {
    return Expanded(
      child: Column(
        children: [
          Divider(
            thickness: 4,
            color: AppColors.secondary,
          ),
          const SizedBox(height: 15)
        ],
      ),
    );
  }
}
