import 'package:flutter_riverpod/flutter_riverpod.dart';

class SummaryData {
  final String value;
  final String label;

  SummaryData({required this.value, required this.label});
}

final summaryProvider = Provider<List<SummaryData>>((ref) {
  return [
    SummaryData(value: 'RM1,500', label: 'Total Revenue'),
    SummaryData(value: 'RM12,234', label: 'Gross Sales'),
    SummaryData(value: 'RM25,000', label: 'Net Sales'),
    SummaryData(value: 'RM45,000', label: 'Avg. Net Sale'),
  ];
});
