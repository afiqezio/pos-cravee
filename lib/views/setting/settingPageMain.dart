import 'package:flutter/material.dart';
import 'package:possystem/utils/widget/customScaffold.dart';
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
    return CustomScaffold(
      title: 'Setting',
      subtitle:
          'Adjust business preferences, and integrate with third-party tools.',
      child: Row(
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
    );
  }
}
