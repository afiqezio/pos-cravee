import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:possystem/example/data/models/productTest.dart';
import 'package:possystem/example/data/repo/product_repo.dart';

class ProductViewModel extends StateNotifier<AsyncValue<List<Products>>> {
  final ProductRepository repository;

  ProductViewModel(this.repository) : super(const AsyncLoading());

  // Fetch products
  Future<void> fetchProducts() async {
    try {
      state = const AsyncLoading();
      final response = await repository.fetchProducts();
      state = AsyncData(response.products);
    } catch (error) {
      state = AsyncError(error, StackTrace.current);
    }
  }

  Future<void> fetchProductsyId(int id) async {
    try {
      state = const AsyncLoading();
      final response = await repository.fetchProductById(id);
      state = AsyncData(response.products);
    } catch (error) {
      state = AsyncError(error, StackTrace.current);
    }
  }

  // Create product
  Future<void> createProduct(Products product) async {
    try {
      state = const AsyncLoading();
      final newProduct = await repository.createProduct(product);
      final updatedProducts = [
        ...state.when(
          data: (products) => products,
          loading: () => [],
          error: (error, stack) => [],
        ),
        newProduct
      ];
      state = AsyncData(updatedProducts.cast<Products>());
    } catch (error) {
      state = AsyncError(error, StackTrace.current);
    }
  }

  // Update product
  Future<void> updateProduct(int id, Products product) async {
    try {
      state = const AsyncLoading();
      final updatedProduct = await repository.updateProduct(id, product);
      final updatedProducts = [
        for (final p in state.when(
          data: (products) => products,
          loading: () => [],
          error: (error, stack) => [],
        ))
          if (p.id == id) updatedProduct else p
      ];
      state = AsyncData(updatedProducts.cast<Products>());
    } catch (error) {
      state = AsyncError(error, StackTrace.current);
    }
  }

  // Delete product
  Future<void> deleteProduct(int id) async {
    try {
      state = const AsyncLoading();
      await repository.deleteProduct(id);
      final updatedProducts = [
        for (final p in state.when(
          data: (products) => products,
          loading: () => [],
          error: (error, stack) => [],
        ))
          if (p.id != id) p
      ];
      state = AsyncData(updatedProducts.cast<Products>());
    } catch (error) {
      state = AsyncError(error, StackTrace.current);
    }
  }
}

final productViewModelProvider =
    StateNotifierProvider<ProductViewModel, AsyncValue<List<Products>>>((ref) {
  final repository = ref.watch(productRepositoryProvider);
  return ProductViewModel(repository);
});
