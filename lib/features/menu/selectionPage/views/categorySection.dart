import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:possystem/features/menu/selectionPage/providers/cartProvider.dart';
import 'package:possystem/utils/appHelper.dart';
import '../../../../models/category.dart';
import '../../entryPage/providers/menuChoose.dart';

class CategorySection extends ConsumerStatefulWidget {
  const CategorySection({super.key});

  @override
  ConsumerState<CategorySection> createState() => _CategorySectionState();
}

class _CategorySectionState extends ConsumerState<CategorySection> {
  @override
  Widget build(BuildContext context) {
    Set<String> selectedCategories = ref.watch(categorySelectionProvider);

    // Adding an "All" category
    final allCategory = Category(
      id: "0",
      name: "Trending",
      imageUrl: "assets/svg/menu/trending.svg",
      // quantity: 1,
      description: 'All Menu',
    );
    // Prepend "All" to the categories list
    final displayCategories = [allCategory, ...categories];

    return Expanded(
      flex: 1,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: displayCategories.length,
        itemBuilder: (context, index) {
          final category = displayCategories[index];
          final isSelected =
              selectedCategories.contains(category.id.toString());

          return GestureDetector(
            onTap: () {
              ref
                  .read(categorySelectionProvider.notifier)
                  .toggleCategory(category.id.toString());

              ref.read(categoryTitleProvider.notifier).state =
                  category.description;
            },
            child: Column(
              children: [
                Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 14, horizontal: 6),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.secondary
                        : AppColors.canvasPrimary,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 4.0,
                      horizontal: 14.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Product Image
                        Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            // Check if the imageUrl is an SVG by the extension
                            image: category.imageUrl.endsWith('.svg')
                                ? null
                                : DecorationImage(
                                    image: AssetImage(category.imageUrl),
                                    fit: BoxFit.fitHeight,
                                  ),
                          ),
                          child: category.imageUrl.endsWith('.svg')
                              ? SvgPicture.asset(
                                  category.imageUrl,
                                  fit: BoxFit.fitWidth,
                                  color: isSelected
                                      ? AppColors.canvasPrimary
                                      : const Color(0xFFFAC515),
                                )
                              : null,
                        ),
                        // Category Name
                        Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Text(
                            category.name,
                            style: AppTexts.medium(
                              size: 16,
                              color: isSelected
                                  ? AppColors.canvasPrimary
                                  : Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
