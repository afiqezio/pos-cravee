import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:possystem/providers/cartProvider.dart';
import 'package:possystem/providers/paymentProvider.dart';
import 'package:possystem/utils/appColors.dart';
import 'package:possystem/utils/appTexts.dart';
import 'package:possystem/utils/widget/customCircle.dart';
import 'package:possystem/utils/widget/customMainContainer.dart';
import 'package:possystem/views/menu/receiptPage/receiptSection.dart';

class ReceiptPageMain extends ConsumerWidget {
  const ReceiptPageMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomMainContainer(
      backgroundColor: Color(0xFFFAFAFA),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Center(
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
                            padding: const EdgeInsets.all(8.0),
                            child: CustomCircle(
                              fillColor: AppColors.secondary,
                              borderColor: AppColors.secondary,
                              size: 60,
                              child: Icon(
                                Icons.check,
                                color: Colors.white,
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
                              style: AppTexts.medium(
                                  size: 16, color: AppColors.secondary),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
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
                                  size: 17, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
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
                                      size: 17, color: Colors.grey),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(0),
                                    borderSide: BorderSide.none,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(0),
                                    borderSide:
                                        BorderSide(color: AppColors.secondary),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(0),
                                    borderSide: BorderSide(
                                        color: Colors.orange, width: 2),
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
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
                  SizedBox(height: 15),
                  Column(
                    children: [
                      Image.asset(
                        'assets/images/process/pretzley_qr.png',
                        width: 240,
                        height: 240,
                      ),
                      SizedBox(height: 10),
                      GestureDetector(
                        onTap: () => {
                          clearCart(ref),
                          clearCashProvider(ref),
                          context.go('/menu')
                        },
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: Card(
                            color: AppColors.secondary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            elevation: 0,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Center(
                                child: Text(
                                  "New Order",
                                  style: AppTexts.medium(
                                      size: 16, color: Colors.white),
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
            ),
          ),
          Expanded(
            flex: 2,
            child: ReceiptSection(),
          ),
        ],
      ),
    );
  }
}
