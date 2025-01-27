import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:possystem/models/addOn.dart';
import 'package:possystem/models/cart.dart';
import 'package:possystem/models/salesDetails.dart';
import '../../../../models/product.dart';
import '../../entryPage/providers/menuChoose.dart';

// Define the cart provider
final cartProvider = StateProvider<Map<Product, CartItem>>((ref) => {});

// Define the category title provider
final categoryTitleProvider = StateProvider<String>((ref) => '');

// Add product function
void addProduct(
  WidgetRef ref,
  Product product,
  int quantity,
  List<AddOn>? addOns,
  String? notes,
) {
  if (quantity != 0) {
    final cart = ref.read(cartProvider.notifier).state;

    if (cart.containsKey(product)) {
      // Update quantity and ensure add-ons are unique
      final currentCartItem = cart[product]!;
      final updatedAddOns = <AddOn>{
        ...?currentCartItem.addOns, // Existing add-ons (null-safe)
        ...?addOns, // New add-ons (null-safe)
      }.toList(); // Convert back to a list

      cart[product] = CartItem(
        quantity: currentCartItem.quantity + quantity,
        addOns: updatedAddOns,
        notes: notes ??
            currentCartItem
                .notes, // Preserve existing notes if no new notes are provided
      );
    } else {
      // Add new product with initial details
      cart[product] = CartItem(
        quantity: quantity,
        addOns: addOns ?? [], // Default to an empty list if addOns is null
        notes: notes ?? '', // Default to an empty string if notes is null
      );
    }

    // Update the cart state
    ref.read(cartProvider.notifier).state = {...cart};
  }
}

// Remove product function
void removeProduct(WidgetRef ref, Product product, int quantity) {
  final cart = ref.read(cartProvider.notifier).state;

  if (cart.containsKey(product)) {
    final currentCartItem = cart[product]!;
    if (currentCartItem.quantity > quantity) {
      // Reduce the quantity
      cart[product] = CartItem(
        quantity: currentCartItem.quantity - quantity,
        addOns: currentCartItem.addOns,
        notes: currentCartItem.notes,
      );
    } else {
      // Remove the product completely
      cart.remove(product);
    }
  }

  // Update the cart state
  ref.read(cartProvider.notifier).state = {...cart};
}

// Update product function
void updateProduct(WidgetRef ref, Product product, int quantity,
    List<AddOn>? addOns, String? notes) {
  if (quantity != 0) {
    final cart = ref.read(cartProvider.notifier).state;

    // Update or add the product with new details
    cart[product] = CartItem(
      quantity: quantity,
      addOns: addOns!,
      notes: notes!,
    );

    // Update the cart state
    ref.read(cartProvider.notifier).state = {...cart};
  }
}

// Clear product function
void clearProduct(WidgetRef ref, Product product) {
  final cart = ref.read(cartProvider.notifier).state;

  if (cart.containsKey(product)) {
    cart.remove(product);
  }

  // Update the cart state with the modified cart
  ref.read(cartProvider.notifier).state = {...cart};
}

// Clear cart function
void clearCart(WidgetRef ref) {
  ref.read(cartProvider.notifier).state = {};
}

// Provider for filtered products
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

final allProductsProvider = Provider<List<Product>>((ref) {
  return products;
});

final cartVoucherProvider = StateProvider<double>((ref) => 0.0);

final cartSalesProvider = StateProvider<SalesDetails>((ref) {
  final cart = ref.watch(cartProvider);

  final double voucher = ref.watch(cartVoucherProvider);

  // Calculate totalSales, tax, and subtotal
  final totalSales = cart.entries.fold(
      0.0, (total, entry) => total + (entry.key.price * entry.value.quantity));

  final tax = totalSales * 0.07;
  final subtotal = totalSales + tax - voucher;

  // Return updated SalesDetails with discount and voucher applied
  return SalesDetails(
    totalSales: totalSales,
    voucher: voucher,
    tax: tax,
    subtotal: subtotal,
  );
});
