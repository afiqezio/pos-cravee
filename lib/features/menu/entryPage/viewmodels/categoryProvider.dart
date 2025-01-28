import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:possystem/features/menu/selectionPage/viewmodels/cartProvider.dart';

final categorySelectionProvider =
    StateNotifierProvider<CategorySelectionNotifier, Set<String>>(
  (ref) => CategorySelectionNotifier(),
);

class CategorySelectionNotifier extends StateNotifier<Set<String>> {
  CategorySelectionNotifier() : super({});

  // Add a category to the selected set
  void selectCategory(String categoryId) {
    state = {...state, categoryId};
  }

  // Remove a category from the selected set
  void deselectCategory(String categoryId) {
    state = {...state}..remove(categoryId);
  }

  // Toggle category selection
  void toggleCategory(String categoryId) {
    if (state.isNotEmpty) {
      state.clear();
      selectCategory(categoryId);
    } else {
      selectCategory(categoryId);
    }
  }

  // Reset the selection to the initial empty state
  void resetSelection() {
    state = {};
  }
}

final categoryProductCountProvider =
    Provider.family<int, String>((ref, categoryId) {
  final products = ref.watch(allProductsProvider);
  if (categoryId == '0') {
    return products.length;
  } else {
    return products.where((product) => product.categoryId == categoryId).length;
  }
});
