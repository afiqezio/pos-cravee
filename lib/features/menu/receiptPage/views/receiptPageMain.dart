import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:possystem/widgets/customMainContainer.dart';
import 'package:possystem/features/menu/receiptPage/views/receiptSection.dart';
import 'paymentDetailSection.dart';

class ReceiptPageMain extends ConsumerWidget {
  const ReceiptPageMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return OrientationBuilder(
      builder: (context, orientation) {
        if (orientation == Orientation.portrait) {
          return CustomMainContainer(
            backgroundColor: Color(0xFFFAFAFA),
            child: Column(
              children: [
                PaymentDetailSection(),
                ReceiptSection(),
              ],
            ),
          );
        } else {
          return CustomMainContainer(
            backgroundColor: Color(0xFFFAFAFA),
            child: Row(
              spacing: 20,
              children: [
                Expanded(
                  flex: 3,
                  child: PaymentDetailSection(),
                ),
                Expanded(
                  flex: 2,
                  child: ReceiptSection(),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
