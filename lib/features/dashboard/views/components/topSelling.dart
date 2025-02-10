import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:possystem/core/utils/appHelper.dart';
import 'package:possystem/features/menu/selectionPage/viewmodels/cartProvider.dart';

class TopSelling extends ConsumerStatefulWidget {
  const TopSelling({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TopSellingState();
}

class _TopSellingState extends ConsumerState<TopSelling> {
  int productSize = 3;
  int orderSize = 1;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                flex: productSize,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Products',
                    style:
                        AppTexts.regular(size: 14, color: AppColors.greyText),
                  ),
                )),
            Expanded(
                flex: orderSize,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'Orders',
                    style:
                        AppTexts.regular(size: 14, color: AppColors.greyText),
                  ),
                )),
          ],
        ),
        Expanded(
          child: ListView.builder(
            itemCount: ref.watch(cartProvider).length,
            itemBuilder: (context, index) {
              final entry = ref.watch(cartProvider).entries.toList()[index];
              final product = entry.key;
              final cartItem = entry.value;
              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: productSize,
                      child: Text(product.name),
                    ),
                    Expanded(
                      flex: orderSize,
                      child: Text(cartItem.quantity.toString(),
                          textAlign: TextAlign.end),
                    ),
                  ],
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
