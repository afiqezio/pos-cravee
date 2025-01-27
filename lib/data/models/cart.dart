import 'package:possystem/data/models/addOn.dart';

class CartItem {
  final int quantity;
  final List<AddOn>? addOns;
  final String? notes;

  CartItem({
    required this.quantity,
    this.addOns = const [],
    this.notes = '',
  });
}
