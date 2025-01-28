// Provider for filtered products
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:possystem/data/models/product.dart';
import 'package:possystem/features/menu/entryPage/viewmodels/categoryProvider.dart';

final filteredProductsProvider = Provider<List<Product>>((ref) {
  final allProducts = ref.watch(allProductsProvider);
  final selectedCategories = ref.watch(categorySelectionProvider);

  // '0' ID representing All Products
  if (selectedCategories.contains("0")) {
    return allProducts;
  } else {
    // Filter products by matching category IDs
    return allProducts
        .where((product) =>
            selectedCategories.contains(product.categoryId.toString()))
        .toList();
  }
});

// final selectedAddOnProvider = StateProvider<List<AddOn>>((ref) => []);

final allProductsProvider = Provider<List<Product>>((ref) {
  return products;
});
