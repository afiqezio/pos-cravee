import 'package:flutter/material.dart';
import 'package:possystem/utils/appColors.dart';
import 'package:possystem/utils/appTexts.dart';
import 'package:possystem/views/setting/appearance/appearancePageMain.dart';
import 'package:possystem/views/setting/notification/notificationPageMain.dart';
import 'settingNav.dart';

class SettingPageMain extends StatefulWidget {
  @override
  State<SettingPageMain> createState() => _SettingPageMainState();
}

class _SettingPageMainState extends State<SettingPageMain> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    AppearancePageMain(),
    NotificationPageMain(),
  ];

  void _handlePageChange(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Setting',
                  style: AppTexts.medium(size: 20),
                ),
                Text(
                  'Adjust business preferences, and integrate with third-party tools.',
                  style:
                      AppTexts.regular(size: 16, color: AppColors.greyDarkText),
                ),
              ],
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 1,
            children: [
              // Navigation sidebar
              SizedBox(
                width: 250,
                child: SettingNav(
                  currentIndex: _currentIndex,
                  onPageChange: _handlePageChange,
                ),
              ),
              // Content area
              Expanded(
                child: _pages[_currentIndex],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
