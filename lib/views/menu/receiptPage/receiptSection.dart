import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:possystem/providers/cartProvider.dart';
import 'package:possystem/utils/appColors.dart';

class ReceiptSection extends ConsumerWidget {
  final String orderDate =
      DateFormat('dd MMM, yyyy HH:mm').format(DateTime.now());
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Logo Section
                Center(
                    child: SvgPicture.asset('assets/svg/pretzley.svg',
                        height: 36)),
                const SizedBox(height: 20),

                // Order Details
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Order Number',
                        style:
                            TextStyle(fontSize: 13, color: AppColors.greyText)),
                    Text('#0009010',
                        style:
                            TextStyle(fontSize: 13, color: AppColors.greyText)),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Date',
                        style:
                            TextStyle(fontSize: 13, color: AppColors.greyText)),
                    Text(orderDate,
                        style:
                            TextStyle(fontSize: 13, color: AppColors.greyText)),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Address',
                        style:
                            TextStyle(fontSize: 13, color: AppColors.greyText)),
                    Text('41, Jalan Putih, Puchong',
                        style:
                            TextStyle(fontSize: 13, color: AppColors.greyText)),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Email',
                        style:
                            TextStyle(fontSize: 13, color: AppColors.greyText)),
                    Text('fahmi.mikail@gmail.com',
                        style:
                            TextStyle(fontSize: 13, color: AppColors.greyText)),
                  ],
                ),
                const SizedBox(height: 10),
                const Divider(
                  thickness: 0.7,
                  color: Colors.black,
                ),

                // Invoice Section
                Center(
                  child: Text('Invoice',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        flex: 5,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Item',
                            style: TextStyle(
                                fontSize: 14, color: AppColors.greyText),
                          ),
                        )),
                    Expanded(
                        flex: 1,
                        child: Center(
                          child: Text(
                            'Qty',
                            style: TextStyle(
                                fontSize: 14, color: AppColors.greyText),
                          ),
                        )),
                    Expanded(
                        flex: 2,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            'Price',
                            style: TextStyle(
                                fontSize: 14, color: AppColors.greyText),
                          ),
                        )),
                  ],
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: ref.watch(cartProvider).length,
                    itemBuilder: (context, index) {
                      final entry =
                          ref.watch(cartProvider).entries.toList()[index];
                      final product = entry.key;
                      final cartItem = entry.value;
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 5,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(product.name),
                                  Text(
                                    cartItem.addOns != null &&
                                            cartItem.addOns!.isNotEmpty
                                        ? cartItem.addOns!
                                            .map((addOn) => addOn.name)
                                            .join(', ')
                                        : 'No Add-Ons',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Center(
                                  child:
                                      Text('${cartItem.quantity.toString()}x')),
                            ),
                            Expanded(
                              flex: 2,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  'RM ${(product.price * cartItem.quantity).toStringAsFixed(2)}',
                                  style: TextStyle(color: AppColors.secondary),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 20),

                // Payment Details Section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      'assets/images/receipt/paid.png',
                      height: 118,
                    ),
                    const SizedBox(
                        width: 10), // Adjust spacing between sections
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  'Total Sales',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14),
                                ),
                                Text(
                                  'Voucher',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14),
                                ),
                                Text(
                                  'Redeem Points',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14),
                                ),
                                Text(
                                  'Tax',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14),
                                ),
                                Text(
                                  'Subtotal',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14),
                                ),
                                Text(
                                  'Grand Total',
                                  style: TextStyle(
                                      color: AppColors.secondary,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 12,
                          ),
                          Expanded(
                            flex: 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                    'RM${ref.watch(cartSalesProvider).totalSales.toStringAsFixed(2)}',
                                    style: TextStyle(fontSize: 14)),
                                Text(
                                    '-RM${ref.watch(cartSalesProvider).voucher.toStringAsFixed(2)}',
                                    style: TextStyle(fontSize: 14)),
                                Text('-RM0.00', style: TextStyle(fontSize: 14)),
                                Text(
                                    'RM${ref.watch(cartSalesProvider).tax.toStringAsFixed(2)}',
                                    style: TextStyle(fontSize: 14)),
                                Text(
                                    'RM${ref.watch(cartSalesProvider).subtotal.toStringAsFixed(2)}',
                                    style: TextStyle(fontSize: 14)),
                                Text(
                                  'RM${ref.watch(cartSalesProvider).subtotal.toStringAsFixed(2)}',
                                  style: TextStyle(
                                      color: AppColors.secondary,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),
                const Divider(
                  thickness: 0.7,
                  color: Colors.black,
                ),
                Column(
                  spacing: 6,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Collected Points',
                          style: TextStyle(color: Colors.black),
                        ),
                        Text(
                          '15 pts',
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total Points',
                          style: TextStyle(
                              color: AppColors.secondary,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '1014 pts',
                          style: TextStyle(
                              color: AppColors.secondary,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    )
                  ],
                ),
                // Barcode Section (SVG)
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Center(
                    child: Image.asset(
                      'assets/images/dummy/barcode.png',
                      width: 250,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
