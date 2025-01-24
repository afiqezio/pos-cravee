// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:possystem/models/addOn.dart';
// import 'package:possystem/models/cart.dart';
// import 'package:possystem/models/salesDetails.dart';
// import '../models/product.dart';

// // Define the cart provider
// final cartProvider =
//     StateProvider<Map<ProductWithAddOns, CartItem>>((ref) => {});

// // Define the category title provider
// final categoryTitleProvider = StateProvider<String>((ref) => '');

// class ProductWithAddOns {
//   final Product product;
//   final List<AddOn>? addOns;

//   ProductWithAddOns(this.product, this.addOns);

//   // @override
//   // bool operator ==(Object other) =>
//   //     identical(this, other) ||
//   //     other is ProductWithAddOns &&
//   //         runtimeType == other.runtimeType &&
//   //         product.id == other.product.id &&
//   //         _addOnsEqual(addOns, other.addOns);

//   // @override
//   // int get hashCode => product.id.hashCode ^ (addOns?.hashCode ?? 0);

//   // bool _addOnsEqual(List<AddOn>? a, List<AddOn>? b) {
//   //   if (a == null && b == null) return true;
//   //   if (a == null || b == null) return false;
//   //   if (a.length != b.length) return false;
//   //   return a.every((addOn) => b.contains(addOn));
//   // }
// }

// // Add product function
// void addProduct(
//   WidgetRef ref,
//   Product product,
//   int quantity,
//   List<AddOn>? addOns,
//   String? notes,
// ) {
//   if (quantity != 0) {
//     final cart = ref.read(cartProvider.notifier).state;

//     // Create a ProductWithAddOns instance for comparison
//     final productWithAddOns = ProductWithAddOns(product, addOns);

//     if (cart.containsKey(productWithAddOns)) {
//       // Update quantity and ensure add-ons are unique
//       final currentCartItem = cart[productWithAddOns]!;
//       cart[productWithAddOns] = CartItem(
//         quantity: currentCartItem.quantity + quantity,
//         addOns: currentCartItem.addOns,
//         notes: notes ?? currentCartItem.notes,
//       );
//     } else {
//       // Add new product with initial details
//       cart[productWithAddOns] = CartItem(
//         quantity: quantity,
//         addOns: addOns ?? [],
//         notes: notes ?? '',
//       );
//     }

//     // Update the cart state
//     ref.read(cartProvider.notifier).state = {...cart};
//   }
// }

// // Remove product function
// void removeProduct(WidgetRef ref, Product product, int quantity) {
//   final cart = ref.read(cartProvider.notifier).state;

//   if (cart.containsKey(product)) {
//     final currentCartItem = cart[product]!;
//     if (currentCartItem.quantity > quantity) {
//       // Reduce the quantity
//       cart[ProductWithAddOns(product, currentCartItem.addOns)] = CartItem(
//         quantity: currentCartItem.quantity - quantity,
//         addOns: currentCartItem.addOns,
//         notes: currentCartItem.notes,
//       );
//     } else {
//       // Remove the product completely
//       cart.remove(product);
//     }
//   }

//   // Update the cart state
//   ref.read(cartProvider.notifier).state = {...cart};
// }

// // Update product function
// void updateProduct(WidgetRef ref, Product product, int quantity,
//     List<AddOn>? addOns, String? notes) {
//   if (quantity != 0) {
//     final cart = ref.read(cartProvider.notifier).state;

//     // Update or add the product with new details
//     cart[ProductWithAddOns(product, addOns)] = CartItem(
//       quantity: quantity,
//       addOns: addOns!,
//       notes: notes!,
//     );

//     // Update the cart state
//     ref.read(cartProvider.notifier).state = {...cart};
//   }
// }

// // Clear product function
// void clearProduct(WidgetRef ref, Product product) {
//   final cart = ref.read(cartProvider.notifier).state;

//   if (cart.containsKey(product)) {
//     cart.remove(product);
//   }

//   // Update the cart state with the modified cart
//   ref.read(cartProvider.notifier).state = {...cart};
// }

// // Clear cart function
// void clearCart(WidgetRef ref) {
//   ref.read(cartProvider.notifier).state = {};
// }

// // Provider for filtered products
// final filteredProductsProvider = Provider<List<Product>>((ref) {
//   final allProducts = ref.watch(allProductsProvider);
//   final selectedCategories = ref.watch(categorySelectionProvider);

//   // '0' ID representing All Products
//   if (selectedCategories.contains("0")) {
//     return allProducts;
//   } else {
//     // Filter products by matching category IDs
//     return allProducts
//         .where((product) =>
//             selectedCategories.contains(product.categoryId.toString()))
//         .toList();
//   }
// });

// final selectedAddOnProvider = StateProvider<List<AddOn>>((ref) => []);

// final allProductsProvider = Provider<List<Product>>((ref) {
//   return products;
// });

// // Cart Price Details
// // final cartSubtotalProvider = StateProvider<double>((ref) => 0.0);
// // final cartSalesProvider =
// //     StateProvider<SalesDetails>((ref) => SalesDetails(totalSales: 0.0));
// final cartVoucherProvider = StateProvider<double>((ref) => 0.0);

// final cartSalesProvider = StateProvider<SalesDetails>((ref) {
//   final cart = ref.watch(cartProvider);

//   final double voucher = ref.watch(cartVoucherProvider);

//   // Calculate totalSales, tax, and subtotal
//   final totalSales = cart.entries.fold(
//       0.0,
//       (total, entry) =>
//           total + (entry.key.product.price * entry.value.quantity));

//   final tax = totalSales * 0.07;
//   final subtotal = totalSales + tax - voucher;

//   // Return updated SalesDetails with discount and voucher applied
//   return SalesDetails(
//     totalSales: totalSales,
//     voucher: voucher,
//     tax: tax,
//     subtotal: subtotal,
//   );
// });

// bool isItemAddedInProvider(WidgetRef ref, AddOn addOnItem) {
//   final cart = ref.watch(cartProvider);

//   // Iterate through the cart to check if the add-on is already added
//   for (var entry in cart.entries) {
//     final productAddOns = entry.value.addOns;
//     if (productAddOns != null && productAddOns.contains(addOnItem)) {
//       return true;
//     }
//   }
//   return false;
// }

// void removeAddOnFromCart(WidgetRef ref, Product product, AddOn addOnItem) {
//   final cart = ref.read(cartProvider.notifier).state;

//   if (cart.containsKey(product)) {
//     final currentCartItem = cart[product]!;

//     // Remove the add-on if it exists
//     final updatedAddOns =
//         currentCartItem.addOns?.where((addOn) => addOn != addOnItem).toList();

//     cart[ProductWithAddOns(product, updatedAddOns)] = CartItem(
//       quantity: currentCartItem.quantity,
//       addOns: updatedAddOns,
//       notes: currentCartItem.notes,
//     );

//     // Update the cart state
//     ref.read(cartProvider.notifier).state = {...cart};
//   }
// }
