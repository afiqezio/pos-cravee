import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:possystem/features/menu/selectionPage/viewmodels/cartProvider.dart';
import 'package:possystem/features/menu/processPage/viewmodels/cashProvider.dart';
import 'package:possystem/core/utils/appHelper.dart';
import 'package:possystem/widgets/customCircle.dart';

class PaymentDetailSection extends ConsumerWidget {
  const PaymentDetailSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Center(
      child: Column(
        children: [
          Container(
            color: AppColors.orangeDark100,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: CustomCircle(
                      fillColor: AppColors.secondary,
                      borderColor: AppColors.secondary,
                      // size: 60,
                      size: width * 0.046,
                      child: Icon(
                        Icons.check,
                        color: AppColors.canvasPrimary,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Payment Successful',
                      style: AppTexts.medium(size: 16),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'RM${ref.watch(cartSalesProvider).subtotal.toStringAsFixed(2)}',
                      style:
                          AppTexts.medium(size: 16, color: AppColors.secondary),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: height * 0.012),
          Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: Card(
                  color: AppColors.secondary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      "Print Full Receipt",
                      style: AppTexts.medium(
                          size: 17, color: AppColors.secondaryText),
                    ),
                  ),
                ),
              ),
              SizedBox(height: height * 0.012),
              SizedBox(
                width: double.infinity,
                child: Row(
                  children: [
                    // TextField with expanded width
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Please input Your Email Address',
                          hintStyle: AppTexts.regular(
                              size: 17, color: AppColors.greyText),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(0),
                            borderSide: BorderSide.none,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(0),
                            borderSide: BorderSide(color: AppColors.secondary),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(0),
                            borderSide: BorderSide(
                                color: AppColors.secondary, width: 2),
                          ),
                          filled: true,
                          fillColor: AppColors.canvasPrimary,
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 0,
                            horizontal: 16,
                          ),
                        ),
                        style: AppTexts.regular(
                            size: 17, color: AppColors.background),
                      ),
                    ),
                    Container(
                      color: AppColors.secondary,
                      child: IconButton(
                        icon: Icon(
                          Icons.send_outlined,
                          color: Colors.white,
                          size: 18,
                        ),
                        onPressed: () {
                          // Action when the button is pressed
                        },
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          SizedBox(height: height * 0.015),
          Column(
            children: [
              Image.asset(
                'assets/images/process/pretzley_qr.png',
                width: width * 0.18,
                height: width * 0.18,
              ),
              SizedBox(height: height * 0.01),
              GestureDetector(
                onTap: () => {
                  clearCart(ref),
                  clearCashProvider(ref),
                  context.go('/menu')
                },
                child: SizedBox(
                  width: width * 0.4,
                  child: Card(
                    color: AppColors.secondary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    elevation: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Center(
                        child: Text(
                          "New Order",
                          style: AppTexts.medium(
                              size: 16, color: AppColors.secondaryText),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
