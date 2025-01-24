import 'package:flutter/material.dart';
import 'package:possystem/utils/appHelper.dart';
import 'package:possystem/utils/widget/customButton.dart';
import 'package:possystem/utils/widget/customScaffold.dart';
import 'package:possystem/views/dashboard/summarySection.dart';

class DashboardPageMain extends StatelessWidget {
  const DashboardPageMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        title: 'Dashboard',
        subtitle: 'Allow users to tailor what metrics are displayed',
        settings: [
          CustomActionButton(
            label: 'Select Dates',
            icon: Icons.calendar_month_outlined,
            iconColor: AppColors.greyDark,
            borderColor: AppColors.secondary,
            backgroundColor: Colors.white,
            textStyle: AppTexts.regular(size: 16, color: AppColors.greyDark),
            onTap: () {
              // print("Circle tapped");
            },
          ),
          CustomActionButton(
            label: 'Add Products',
            icon: Icons.add,
            onTap: () {
              // print("Circle tapped");
            },
          ),
        ],
        child: Row(children: [
          SummarySection(),
        ]));
  }
}
