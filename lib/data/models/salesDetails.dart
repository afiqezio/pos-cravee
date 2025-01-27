class SalesDetails {
  final double totalSales;
  final double discount;
  final double voucher;
  final double tax;
  final double subtotal;

  SalesDetails({
    required this.totalSales,
    double? discount,
    double? voucher,
    double? tax,
    double? subtotal,
  })  : discount = discount ?? 0.0,
        voucher = voucher ?? 0.0,
        tax = tax ?? totalSales * 0.07,
        subtotal = subtotal ??
            totalSales -
                (discount ?? 0.0) -
                (voucher ?? 0.0) +
                (tax ?? totalSales * 0.07);
}
