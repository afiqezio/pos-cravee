class Voucher {
  final String id;
  final String title;
  final DateTime expired;
  final double amount;
  final String tier;
  final bool isGeneral;
  final String? productId;

  Voucher({
    required this.id,
    required this.title,
    required this.expired,
    required this.amount,
    required this.tier,
    required this.isGeneral,
    required this.productId,
  });
}

final List<Voucher> vouchers = [
  Voucher(
    id: '1',
    title: 'Exciting and Rewarding',
    expired: DateTime(2024, 8, 30),
    amount: 3.00,
    tier: 'Gold',
    isGeneral: true,
    productId: null,
  ),
  Voucher(
    id: '2',
    title: 'Premium Offer',
    expired: DateTime(2024, 12, 31),
    amount: 5.00,
    tier: 'Platinum',
    isGeneral: false,
    productId: '1',
  ),
];
