import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:possystem/core/api/api_service.dart';
import 'package:possystem/core/exceptions/api_exception.dart';
import 'package:possystem/example/data/models/productTest.dart';

class ProductRepository {
  static const String _endpoint = '/products';

  final ApiService _apiService;

  ProductRepository(this._apiService);

  // Fetch all products
  Future<ProductResponse> fetchProducts() async {
    try {
      final data = await _apiService.get(_endpoint);
      return ProductResponse.fromJson(data);
    } on ApiException catch (e) {
      throw Exception('Failed to fetch products: ${e.message}');
    }
  }

  // Fetch product by id
  Future<ProductResponse> fetchProductById(int id) async {
    try {
      final data = await _apiService.get('$_endpoint/$id');
      return ProductResponse.fromJson(data);
    } on ApiException catch (e) {
      throw Exception('Failed to fetch product: ${e.message}');
    }
  }

  // Create a new product
  Future<Products> createProduct(Products product) async {
    try {
      final data = await _apiService.post(
        _endpoint,
        {
          'title': product.title,
          'description': product.description,
          'category': product.category,
          'price': product.price,
          'discountPercentage': product.discountPercentage,
          'rating': product.rating,
          'stock': product.stock,
        },
      );
      return Products.fromJson(data);
    } on ApiException catch (e) {
      throw Exception('Failed to create product: ${e.message}');
    }
  }

  // Update an existing product
  Future<Products> updateProduct(int id, Products product) async {
    try {
      final data = await _apiService.put(
        '$_endpoint/$id',
        {
          'title': product.title,
          'description': product.description,
          'category': product.category,
          'price': product.price,
          'discountPercentage': product.discountPercentage,
          'rating': product.rating,
          'stock': product.stock,
        },
      );
      return Products.fromJson(data);
    } on ApiException catch (e) {
      throw Exception('Failed to update product: ${e.message}');
    }
  }

  // Delete a product
  Future<void> deleteProduct(int id) async {
    try {
      await _apiService.delete('$_endpoint/$id');
    } on ApiException catch (e) {
      throw Exception('Failed to delete product: ${e.message}');
    }
  }

  // // Search products
  // Future<ProductResponse> searchProducts(String query) async {
  //   try {
  //     final data = await _apiService.get(
  //       '$_endpoint/search',
  //       queryParameters: {'q': query},
  //     );
  //     return ProductResponse.fromJson(data);
  //   } on ApiException catch (e) {
  //     throw Exception('Failed to search products: ${e.message}');
  //   }
  // }

  // // Get products by category
  // Future<ProductResponse> getProductsByCategory(String category) async {
  //   try {
  //     final data = await _apiService.get(
  //       '$_endpoint/category/$category',
  //     );
  //     return ProductResponse.fromJson(data);
  //   } on ApiException catch (e) {
  //     throw Exception('Failed to fetch products by category: ${e.message}');
  //   }
  // }
}

final productRepositoryProvider = Provider<ProductRepository>((ref) {
  final apiService = ref.watch(apiServiceProvider);
  return ProductRepository(apiService);
});
