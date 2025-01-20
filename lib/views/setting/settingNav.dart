import 'package:flutter/material.dart';
import 'package:possystem/utils/appColors.dart';
import 'package:possystem/utils/appTexts.dart';

class SettingNav extends StatefulWidget {
  final Function(int) onPageChange;
  final int currentIndex;

  const SettingNav({
    super.key,
    required this.onPageChange,
    required this.currentIndex,
  });

  @override
  State<SettingNav> createState() => _SettingNavState();
}

class _SettingNavState extends State<SettingNav> {
  final List<Map<String, dynamic>> _navItems = [
    {
      'icon': Icons.remove_red_eye_outlined,
      'label': 'Appearance',
    },
    {
      'icon': Icons.notifications_outlined,
      'label': 'Notifications',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ..._navItems.asMap().entries.map((entry) {
            final index = entry.key;
            final item = entry.value;
            final isSelected = widget.currentIndex == index;

            return Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: InkWell(
                onTap: () => widget.onPageChange(index),
                borderRadius: BorderRadius.circular(6),
                child: Container(
                  decoration: BoxDecoration(
                    color:
                        isSelected ? AppColors.primary : AppColors.transparent,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                    child: Row(
                      children: [
                        Icon(
                          item['icon'] as IconData,
                          color: isSelected ? Colors.white : Colors.black,
                        ),
                        SizedBox(width: 8),
                        Text(
                          item['label'] as String,
                          style: AppTexts.regular(
                            size: 16,
                            color: isSelected ? Colors.white : Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}
