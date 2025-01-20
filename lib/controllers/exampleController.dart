import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:possystem/providers/exampleProvider.dart';
import '../services/example.dart';

class ProductController {
  final ApiService apiService;

  ProductController(this.apiService);

  Future<void> fetchProducts(WidgetRef ref) async {
    try {
      final products = await apiService.get('/products');
      ref.read(productListProvider.notifier).setProducts(products['data']);
    } catch (e) {
      throw Exception('Failed to fetch products');
    }
  }
}
