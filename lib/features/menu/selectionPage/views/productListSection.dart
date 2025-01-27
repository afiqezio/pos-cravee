import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:possystem/utils/appHelper.dart';
import 'package:possystem/utils/helper/screens_util.dart';
import 'package:possystem/features/menu/selectionPage/views/showProductDetails.dart';
import '../providers/cartProvider.dart';
import '../../../../models/category.dart';

class ProductListSection extends ConsumerStatefulWidget {
  const ProductListSection({super.key});

  @override
  ConsumerState<ProductListSection> createState() => _ProductListSectionState();
}

class _ProductListSectionState extends ConsumerState<ProductListSection> {
  static const double gridCrossAxisSpacing = 6.0;
  static const double gridMainAxisSpacing = 6.0;
  static const Color cardBackgroundColor = AppColors.background;

  @override
  Widget build(BuildContext context) {
    final filteredProducts = ref.watch(filteredProductsProvider);

    return Expanded(
      flex: 7,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final gridChildAspectRatio =
              getChildAspectRatio(constraints.maxWidth);
          final crossAxisCount = getCrossAxisCount(constraints.maxWidth);

          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              childAspectRatio: gridChildAspectRatio,
              crossAxisSpacing: gridCrossAxisSpacing,
              mainAxisSpacing: gridMainAxisSpacing,
            ),
            itemCount: filteredProducts.length,
            itemBuilder: (context, index) {
              final product = filteredProducts[index];
              return GestureDetector(
                onTap: () => showProductDetails(context, ref, product),
                child: _buildProductCard(context, product),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildProductCard(BuildContext context, dynamic product) {
    final String categoryName = _getCategoryName(product.categoryId);

    return SafeArea(
      child: Card(
        elevation: 0,
        color: cardBackgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Container
            Expanded(
              flex: 2,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.canvasPrimary,
                  image: DecorationImage(
                    image: AssetImage(product.imageUrl),
                    fit: BoxFit.fitHeight,
                    alignment: Alignment.center,
                  ),
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // Category Name
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        categoryName,
                        style: AppTexts.medium(
                          size: 13,
                          color: AppColors.secondary,
                        ),
                      ),
                    ),
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 300),
                      child: Text(
                        product.name,
                        style: AppTexts.regular(size: 16),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                      ),
                    ),

                    // Product Price
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        'RM ${product.price.toStringAsFixed(2)}',
                        style: AppTexts.semiBold(size: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getCategoryName(String categoryId) {
    try {
      return categories
          .firstWhere((category) => category.id == categoryId)
          .name;
    } catch (e) {
      return 'Unknown Category';
    }
  }
}
