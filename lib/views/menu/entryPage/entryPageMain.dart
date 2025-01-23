import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:possystem/providers/cartProvider.dart';
import 'package:possystem/utils/appHelper.dart';
import 'package:possystem/utils/helper/screens_util.dart';
import '../../../models/category.dart';
import '../../../providers/menuChoose.dart';

class EntryPageMain extends ConsumerWidget {
  const EntryPageMain({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Adding an "All" category
    final allCategory = Category(
      id: "0",
      name: "All",
      imageUrl: "assets/images/data/all_menu.png",
      // imageUrl: "assets/images/data/pretzel.png",
      description: 'All Menu',
    );

    // Prepend "All" to the categories list
    final displayCategories = [allCategory, ...categories];

    return Padding(
      padding: const EdgeInsets.all(48.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final gridChildAspectRatio =
                    getChildAspectRatio(constraints.maxWidth);
                final crossAxisCount = getCrossAxisCount(constraints.maxWidth);

                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 60.0, vertical: 30.0),
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      childAspectRatio: gridChildAspectRatio,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                    ),
                    itemCount: displayCategories.length,
                    itemBuilder: (context, index) {
                      final category = displayCategories[index];
                      return GestureDetector(
                        onTap: () {
                          ref
                              .read(categorySelectionProvider.notifier)
                              .toggleCategory(category.id.toString());

                          ref.read(categoryTitleProvider.notifier).state =
                              category.description;
                          context.go('/menu/productpicker');
                        },
                        child: Card(
                          elevation: 0,
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(14.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      category.name,
                                      style: AppTexts.semiBold(size: 16),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 4.0),
                                      child: Text(
                                        '${ref.watch(categoryProductCountProvider(category.id))} Item',
                                        style: AppTexts.regular(
                                            size: 16,
                                            color: AppColors.greyDark),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  margin: const EdgeInsets.all(10.0),
                                  decoration: BoxDecoration(
                                    color: AppColors.primary,
                                    borderRadius: BorderRadius.circular(8),
                                    image: DecorationImage(
                                      image: AssetImage(category.imageUrl),
                                      alignment: Alignment.topCenter,
                                      fit: BoxFit.fitWidth,
                                    ),
                                  ),
                                  clipBehavior: Clip.antiAlias,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
