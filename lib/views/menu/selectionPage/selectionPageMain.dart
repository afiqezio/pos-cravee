import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:possystem/providers/cartProvider.dart';
import 'package:possystem/utils/appHelper.dart';
import '../../../providers/menuChoose.dart';
import 'cartSection.dart';
import 'productListSection.dart';
import 'categorySection.dart';

class SelectionPageMain extends ConsumerStatefulWidget {
  final bool isConfirmation;

  const SelectionPageMain({super.key, required this.isConfirmation});

  @override
  _ProductPickerPageState createState() => _ProductPickerPageState();
}

class _ProductPickerPageState extends ConsumerState<SelectionPageMain> {
  late bool _isConfirmation = widget.isConfirmation;
  @override
  Widget build(BuildContext context) {
    final int expandedProductFlex =
        MediaQuery.of(context).size.width > 840 ? 3 : 2;
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, Object? result) async {
        if (didPop) {
          return;
        }
        if (context.mounted) {
          ref.read(categorySelectionProvider.notifier).resetSelection();
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFF2F2F7),
        body: Row(
          children: [
            // Product Section
            Expanded(
              flex: expandedProductFlex,
              child: Container(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Category Filter Section
                    CategorySection(),
                    //Category Title
                    SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          ref.watch(categoryTitleProvider),
                          style: AppTexts.medium(size: 16),
                        ),
                      ),
                    ),
                    // Product List Section
                    ProductListSection()
                  ],
                ),
              ),
            ),
            // Cart Section
            Expanded(
              flex: 2,
              child: CartSection(isConfirmation: _isConfirmation),
            )
          ],
        ),
      ),
    );
  }
}
