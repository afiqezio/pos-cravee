import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../selectionPage/providers/cartProvider.dart';

// Widget flag
final isPhoneFlagProvider = StateProvider<bool>((ref) => false);

// Cash Paid
final cashProvider = StateProvider<double>((ref) => 0.0);

void clearCashProvider(WidgetRef ref) {
  ref.read(cashProvider.notifier).state = 0.0;
}

final paymentChangeProvider = StateProvider<double>(
    (ref) => ref.watch(cashProvider) - ref.watch(cartSalesProvider).subtotal);
