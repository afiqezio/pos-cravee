import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:possystem/core/utils/appHelper.dart';

class PaymentTypeGraph extends StatefulWidget {
  const PaymentTypeGraph({super.key});

  @override
  State<PaymentTypeGraph> createState() => _PaymentTypeGraphState();
}

class _PaymentTypeGraphState extends State<PaymentTypeGraph> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double scale = constraints.maxWidth / 300.0;
        final double normalRadius = 30.0 * scale;
        final double touchedRadius = 36.0 * scale;

        return Stack(
          alignment: Alignment.center,
          children: [
            PieChart(
              PieChartData(
                pieTouchData: PieTouchData(
                  touchCallback: (FlTouchEvent event, pieTouchResponse) {
                    setState(() {
                      if (!event.isInterestedForInteractions ||
                          pieTouchResponse == null ||
                          pieTouchResponse.touchedSection == null) {
                        touchedIndex = -1;
                        return;
                      }
                      touchedIndex =
                          pieTouchResponse.touchedSection!.touchedSectionIndex;
                    });
                  },
                ),
                borderData: FlBorderData(
                  show: false,
                ),
                sectionsSpace: 0,
                centerSpaceRadius: 50.0 * scale,
                sections: showingSections(scale, normalRadius, touchedRadius),
              ),
            ),
            Text(
              "RM 9,199.20",
              style: AppTexts.medium(
                size: 14.0 * scale,
                color: AppColors.primaryText,
              ),
            ),
          ],
        );
      },
    );
  }

  List<PieChartSectionData> showingSections(
      double scale, double normalRadius, double touchedRadius) {
    return List.generate(4, (i) {
      final bool isTouched = i == touchedIndex;
      final double fontSize = isTouched ? 25.0 * scale : 16.0 * scale;
      final double radius = isTouched ? touchedRadius : normalRadius;
      const List<Shadow> shadows = [Shadow(color: Colors.black, blurRadius: 2)];

      switch (i) {
        case 0:
          return PieChartSectionData(
            color: Colors.pink,
            value: 40,
            title: '',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryText,
              shadows: shadows,
            ),
          );
        case 1:
          return PieChartSectionData(
            color: Colors.green,
            value: 30,
            title: '',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryText,
              shadows: shadows,
            ),
          );
        case 2:
          return PieChartSectionData(
            color: Colors.blue,
            value: 15,
            title: '',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryText,
              shadows: shadows,
            ),
          );
        case 3:
          return PieChartSectionData(
            color: Colors.yellow,
            value: 15,
            title: '',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryText,
              shadows: shadows,
            ),
          );
        default:
          throw Error();
      }
    });
  }
}
