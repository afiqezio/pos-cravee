import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'cartProvider.dart';

// Widget flag
final isPhoneFlagProvider = StateProvider<bool>((ref) => false);

// Cash Paid
final cashProvider = StateProvider<double>((ref) => 0.0);

void clearCashProvider(WidgetRef ref) {
  ref.read(cashProvider.notifier).state = 0.0;
}

// Payment Change
// final paymentChangeProvider = StateProvider<double>(
//     (ref) => ref.watch(cashProvider) - ref.watch(cartSubtotalProvider));
final paymentChangeProvider = StateProvider<double>(
    (ref) => ref.watch(cashProvider) - ref.watch(cartSalesProvider).subtotal);

// Payment Type
// final paymentTypeProvider = StateProvider<String>((ref) => '');

// final progressStateProvider = StateProvider<List<bool>>((ref) {
//   return [true, false, false];
// });
