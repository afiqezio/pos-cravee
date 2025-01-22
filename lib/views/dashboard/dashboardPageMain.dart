import 'package:flutter/material.dart';
import 'package:possystem/utils/appHelper.dart';
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
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: AppColors.secondary),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                spacing: 6,
                children: [
                  Text('Select Dates',
                      style: AppTexts.regular(
                          size: 16, color: AppColors.greyDark)),
                  Icon(Icons.calendar_month_outlined,
                      color: AppColors.greyDark, size: 20),
                ],
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: AppColors.secondary,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                spacing: 6,
                children: [
                  Text('Add Products',
                      style: AppTexts.regular(size: 16, color: Colors.white)),
                  Icon(Icons.add, color: Colors.white, size: 20),
                ],
              ),
            ),
          ),
        ],
        child: Row(children: [
          SummarySection(),
        ]));
  }
}
