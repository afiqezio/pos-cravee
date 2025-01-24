import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:possystem/providers/cartProvider.dart';
import 'package:possystem/providers/paymentProvider.dart';
import 'package:possystem/utils/appHelper.dart';
import 'package:possystem/utils/widget/customBackButton.dart';
import 'package:possystem/utils/widget/customCircle.dart';
import 'package:possystem/utils/widget/customMainContainer.dart';
import 'package:possystem/views/menu/processPage/cashSection.dart';
import 'package:possystem/views/menu/processPage/membership.dart';
import 'package:possystem/views/menu/processPage/phoneNumber.dart';
import 'package:possystem/views/menu/processPage/processingSection.dart';
import 'package:possystem/views/menu/processPage/qrSection.dart';
import 'successfulSection.dart';

class ProcessPageMain extends ConsumerStatefulWidget {
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
  ProcessPageMainState createState() => ProcessPageMainState();
}

class ProcessPageMainState extends ConsumerState<ProcessPageMain> {
  @override
  void initState() {
    super.initState();
    // Set isPhoneFlagProvider to false after the widget tree is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(isPhoneFlagProvider.notifier).state = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F7),
      body: CustomMainContainer(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Row for Back and Skip buttons
            widget.type != 'success' && widget.type != 'processing'
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomBackButton(),
                      !widget.isPayment
                          ? TextButton(
                              onPressed: () {
                                context.go(
                                    '/menu/productpicker/process/membership/confirmationCart');
                              },
                              child: Text(
                                "Skip",
                                style: AppTexts.regular(
                                    size: 16, color: AppColors.secondary),
                              ),
                            )
                          : widget.type == 'qr'
                              ? TextButton(
                                  onPressed: () {
                                    context.go(
                                        '/menu/productpicker/process/membership/confirmationCart/processQr/processSuccessful');
                                  },
                                  child: Text(
                                    "Continue",
                                    style: AppTexts.regular(
                                        size: 16, color: AppColors.secondary),
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
                  _buildProgressCircle("1", "Membership", widget.isMembership),
                  _buildProgressDivider(),
                  _buildProgressCircle("2", "Payment", widget.isPayment),
                  _buildProgressDivider(),
                  _buildProgressCircle("3", "Successful", widget.isSuccesful),
                ],
              ),
            ),
            const SizedBox(height: 10),
            // Card for Grand Total
            widget.type != 'success' && widget.type != 'processing'
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
                                Text(
                                  "Grand Total : ",
                                  style: AppTexts.regular(
                                      size: 16, color: AppColors.secondaryText),
                                ),
                                Text(
                                  'RM${ref.watch(cartSalesProvider).subtotal.toStringAsFixed(2)}',
                                  style: AppTexts.regular(
                                      size: 16, color: AppColors.secondaryText),
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
            if (widget.isMembership) ...[
              ref.watch(isPhoneFlagProvider)
                  ? PhoneNumberSection()
                  : MembershipSection(),
            ] else if (widget.isPayment) ...[
              if (widget.type == 'cash') ...[
                CashSection()
              ] else if (widget.type == 'qr') ...[
                QrSection()
              ]
            ] else if (widget.isSuccesful) ...[
              if (widget.type == 'success') ...[
                SuccessfulSection()
              ] else if (widget.type == 'processing') ...[
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
          style: AppTexts.regular(
            size: 15,
            color: isCompleted ? AppColors.secondary : AppColors.primaryText,
          ),
        ),
        const SizedBox(height: 12),
        CustomCircle(
          size: 40,
          fillColor:
              isCompleted ? AppColors.secondary : AppColors.canvasPrimary,
          borderColor: AppColors.secondary,
          borderThickness: 1.0,
          child: Text(number,
              style: AppTexts.regular(
                size: 16,
                color: isCompleted
                    ? AppColors.secondaryText
                    : AppColors.primaryText,
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
