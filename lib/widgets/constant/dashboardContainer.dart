import 'package:flutter/material.dart';
import 'package:possystem/core/utils/appHelper.dart';

class DashboardContainer extends StatelessWidget {
  final Widget child;
  final Color? backgroundColor;
  final double? width;
  final String? title;
  final int? flex;

  const DashboardContainer(
      {required this.child,
      this.backgroundColor = Colors.white,
      this.width,
      this.title,
      this.flex = 1,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex!,
      child: SafeArea(
          child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 12.0),
              padding: const EdgeInsets.all(16.0),
              width: width,
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: title != null
                  ? Column(
                      crossAxisAlignment: title != null
                          ? CrossAxisAlignment.center
                          : CrossAxisAlignment.start,
                      mainAxisAlignment: title != null
                          ? MainAxisAlignment.start
                          : MainAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title!,
                              style: AppTexts.medium(
                                  size: 16, color: AppColors.primaryText),
                            ),
                            Divider(
                              color: AppColors.grey,
                              thickness: 1,
                            ),
                            SizedBox(height: 20.0),
                          ],
                        ),
                        Expanded(
                          child: child,
                        ),
                      ],
                    )
                  : child)),
    );
  }
}
