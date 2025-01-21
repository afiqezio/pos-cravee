import 'package:flutter/material.dart';
import 'package:possystem/utils/appColors.dart';
import 'package:possystem/utils/appTexts.dart';

class CustomScaffold extends StatelessWidget {
  final String title;
  final String subtitle;
  final List<Widget> settings;
  final Widget child;

  const CustomScaffold(
      {super.key,
      required this.title,
      required this.subtitle,
      this.settings = const [],
      required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppTexts.medium(size: 20),
                    ),
                    Text(
                      subtitle,
                      style:
                          AppTexts.regular(size: 16, color: AppColors.greyDark),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  spacing: 10,
                  children: settings,
                ),
              ],
            ),
          ),
          // Content
          child,
        ],
      ),
    );
  }
}
