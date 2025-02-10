import 'package:flutter/material.dart';
import 'package:possystem/widgets/constant/dashboardContainer.dart';
import 'components/paymentTypeGraph.dart';
import 'components/topSelling.dart';

class DonutChartPlaceholder extends StatelessWidget {
  final String chartTitle;
  final double progress;

  const DonutChartPlaceholder({
    Key? key,
    required this.chartTitle,
    this.progress = 0.7,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 120,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: 120,
            height: 120,
            child: CircularProgressIndicator(
              value: progress,
              strokeWidth: 10,
              backgroundColor: Colors.grey.shade200,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
          ),
          Text(
            chartTitle,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

class GraphSection extends StatelessWidget {
  const GraphSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 340,
      child: Column(
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                DashboardContainer(
                  title: "Payments Types",
                  child: PaymentTypeGraph(),
                ),
                DashboardContainer(
                  title: "Top Selling Products",
                  child: TopSelling(),
                ),
                DashboardContainer(
                  title: "Payments Types",
                  child: PaymentTypeGraph(),
                ),
              ],
            ),
          ),
          // Er
        ],
      ),
    );
  }
}
