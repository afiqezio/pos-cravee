import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:possystem/example/product/data/models/productTest.dart';
import 'package:possystem/example/product/features/productTest/viewmodels/productViewmodel.dart';

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
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Edit button beside delete
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () async {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ProductEditPage(product: product),
                          ),
                        );
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () async {
                        await ref
                            .read(productViewModelProvider.notifier)
                            .deleteProduct(product.id);
                      },
                    ),
                  ],
                ),
                // Show product details when pressed
                onTap: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductDetailPage(product: product),
                    ),
                  );
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
            id: 0, // ID will be assigned by the backend.
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

/// Displays the details of the product.
class ProductDetailPage extends StatelessWidget {
  final Products product;

  const ProductDetailPage({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(product.title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text('Title: ${product.title}',
                style: const TextStyle(fontSize: 24)),
            const SizedBox(height: 10),
            Text('Description: ${product.description}'),
            const SizedBox(height: 10),
            Text('Category: ${product.category}'),
            const SizedBox(height: 10),
            Text('Price: \$${product.price}'),
            const SizedBox(height: 10),
            Text('Discount: ${product.discountPercentage}%'),
            const SizedBox(height: 10),
            Text('Rating: ${product.rating}'),
            const SizedBox(height: 10),
            Text('Stock: ${product.stock}'),
          ],
        ),
      ),
    );
  }
}

/// A simple edit form for the product.
class ProductEditPage extends ConsumerStatefulWidget {
  final Products product;

  const ProductEditPage({Key? key, required this.product}) : super(key: key);

  @override
  ConsumerState<ProductEditPage> createState() => _ProductEditPageState();
}

class _ProductEditPageState extends ConsumerState<ProductEditPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.product.title);
    _descriptionController =
        TextEditingController(text: widget.product.description);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Product')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Title'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final updatedProduct = Products(
                      id: widget.product.id,
                      title: _titleController.text,
                      description: _descriptionController.text,
                      category: widget.product.category,
                      price: widget.product.price,
                      discountPercentage: widget.product.discountPercentage,
                      rating: widget.product.rating,
                      stock: widget.product.stock,
                    );
                    ref
                        .read(productViewModelProvider.notifier)
                        .updateProduct(widget.product.id, updatedProduct);
                    Navigator.pop(context);
                  }
                },
                child: const Text('Save Changes'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
