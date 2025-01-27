import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:possystem/data/models/productTest.dart';
import 'dart:convert';

class ProductRepository {
  final String _baseUrl = 'https://dummyjson.com/products';

  // Fetch all products
  Future<ProductResponse> fetchProducts() async {
    final response = await http.get(Uri.parse(_baseUrl));

    if (response.statusCode == 200) {
      return ProductResponse.fromJson(response.body);
    } else {
      throw Exception('Failed to fetch products');
    }
  }

  // Fetch all products
  Future<ProductResponse> fetchProductsbyId(int id) async {
    final response = await http.get(Uri.parse('$_baseUrl/$id'));

    if (response.statusCode == 200) {
      return ProductResponse.fromJson(response.body);
    } else {
      throw Exception('Failed to fetch products');
    }
  }

  // Create a new product
  Future<Products> createProduct(Products product) async {
    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        'title': product.title,
        'description': product.description,
        'category': product.category,
        'price': product.price,
        'discountPercentage': product.discountPercentage,
        'rating': product.rating,
        'stock': product.stock,
      }),
    );

    if (response.statusCode == 201) {
      return Products.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create product');
    }
  }

  // Update an existing product
  Future<Products> updateProduct(int id, Products product) async {
    final response = await http.put(
      Uri.parse('$_baseUrl/$id'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        'title': product.title,
        'description': product.description,
        'category': product.category,
        'price': product.price,
        'discountPercentage': product.discountPercentage,
        'rating': product.rating,
        'stock': product.stock,
      }),
    );

    if (response.statusCode == 200) {
      return Products.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to update product');
    }
  }

  // Delete a product
  Future<void> deleteProduct(int id) async {
    final response = await http.delete(Uri.parse('$_baseUrl/$id'));

    if (response.statusCode != 200) {
      throw Exception('Failed to delete product');
    }
  }
}

final productRepositoryProvider = Provider<ProductRepository>((ref) {
  return ProductRepository();
});
