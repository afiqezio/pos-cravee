import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

void showPaymentMethod(BuildContext context, WidgetRef ref) {
  showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 6,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Header with "X" button and title
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      const Expanded(
                        child: Text(
                          "Payment Method",
                          // textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 48), // To balance the row visually
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Full-width buttons
                  Column(
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 50),
                          backgroundColor: Color(0xFF875BF7),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        onPressed: () {
                          // ref.read(paymentTypeProvider.notifier).state = 'qr';
                          context.go(
                              '/menu/productpicker/process/membership/confirmationCart/processQr');
                        },
                        child: const Text(
                          "DuitNow QR",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w700),
                        ),
                      ),
                      const SizedBox(height: 12),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 50),
                          backgroundColor: Color(0xFFFF692E),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                6), // Less circular corners
                          ),
                        ),
                        onPressed: () {
                          context.go(
                              '/menu/productpicker/process/membership/confirmationCart/processCard');
                        },
                        child: const Text(
                          "Credit Card",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w700),
                        ),
                      ),
                      const SizedBox(height: 12),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(
                              double.infinity, 50), // Full-width button
                          backgroundColor: Color(0xFF4E5BA6),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                6), // Less circular corners
                          ),
                        ),
                        onPressed: () {
                          // ref.read(paymentTypeProvider.notifier).state = 'cash';
                          context.go(
                              '/menu/productpicker/process/membership/confirmationCart/processCash');
                        },
                        child: const Text(
                          "Cash",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      });
}
