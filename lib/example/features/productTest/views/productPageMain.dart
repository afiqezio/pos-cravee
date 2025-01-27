import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:possystem/example/data/models/productTest.dart';
import 'package:possystem/example/features/productTest/viewmodels/productViewmodel.dart';

class ProductsPage extends ConsumerStatefulWidget {
  @override
  ConsumerState<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends ConsumerState<ProductsPage> {
  @override
  void initState() {
    super.initState();
    ref.read(productViewModelProvider.notifier).fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    final productState = ref.watch(productViewModelProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Products')),
      body: productState.when(
        data: (products) {
          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return ListTile(
                title: Text(product.title),
                subtitle: Text('\$${product.price}'),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () async {
                    await ref
                        .read(productViewModelProvider.notifier)
                        .deleteProduct(product.id);
                  },
                ),
                onTap: () async {
                  // Example: Update product when tapped
                  final updatedProduct = Products(
                    id: product.id,
                    title: product.title,
                    description: product.description,
                    category: product.category,
                    price: product.price,
                    discountPercentage: product.discountPercentage,
                    rating: product.rating,
                    stock: product.stock + 1, // Example change
                  );
                  await ref
                      .read(productViewModelProvider.notifier)
                      .updateProduct(product.id, updatedProduct);
                },
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text('Error: $error')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newProduct = Products(
            id: 0, // ID will be assigned by the backend
            title: 'New Product',
            description: 'Description of new product',
            category: 'category',
            price: 19.99,
            discountPercentage: 10.0,
            rating: 4.5,
            stock: 10,
          );
          await ref
              .read(productViewModelProvider.notifier)
              .createProduct(newProduct);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
