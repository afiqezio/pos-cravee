import 'package:flutter/material.dart';
import 'package:possystem/utils/appTexts.dart';
import 'package:possystem/utils/widget/customSubContainer.dart';
import 'package:possystem/utils/widget/customSwitch.dart';

class NotificationPageMain extends StatelessWidget {
  const NotificationPageMain({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomSubContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'New Message',
                style: AppTexts.regular(size: 16),
              ),
              CustomSwitch(onChanged: (value) {}),
            ],
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Weekly Report',
                style: AppTexts.regular(size: 16),
              ),
              CustomSwitch(value: false, onChanged: (value) {}),
            ],
          ),
        ],
      ),
    );
  }
}
