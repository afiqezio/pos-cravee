import 'package:flutter_riverpod/flutter_riverpod.dart';

// Define the state (e.g., a list of products)
final productListProvider =
StateNotifierProvider<ProductListController, List<String>>(
      (ref) => ProductListController(),
);

class ProductListController extends StateNotifier<List<String>> {
  ProductListController() : super([]);

  // Method to update the product list
  void setProducts(List<String> products) {
    state = products; // Update the state
  }
}
