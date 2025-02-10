import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:possystem/core/utils/appHelper.dart';
import 'package:possystem/widgets/custom/customButton.dart';
import 'package:possystem/widgets/constant/appScaffold.dart';
import 'package:possystem/features/dashboard/views/summarySection.dart';
import 'package:possystem/features/dashboard/views/graphSection.dart';

class DashboardPageMain extends StatelessWidget {
  const DashboardPageMain({Key? key}) : super(key: key);

  Future<void> testPrint() async {
    final storage = FlutterSecureStorage();
    const kAccessTokenKey = 'access_token';
    String? value = await storage.read(key: kAccessTokenKey);
    print(value);
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        title: 'Dashboard',
        subtitle: 'Allow users to tailor what metrics are displayed',
        settings: [
          CustomActionButton(
            label: 'Select Dates',
            icon: Icons.calendar_month_outlined,
            iconColor: AppColors.greyDark,
            borderColor: AppColors.secondary,
            backgroundColor: AppColors.canvasPrimary,
            textStyle: AppTexts.regular(size: 16, color: AppColors.greyDark),
            onTap: () {
              // print("Circle tapped");
            },
          ),
          CustomActionButton(
            label: 'Add Products',
            icon: Icons.add,
            onTap: () {
              testPrint();
            },
          ),
        ],
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Column(children: [
            SummarySection(),
            GraphSection(),
          ]),
        ));
  }
}
