import 'package:flutter/material.dart';

class DashboardContainer extends StatelessWidget {
  final Widget child;
  final Color? backgroundColor;
  final double? width;

  const DashboardContainer(
      {required this.child,
      this.backgroundColor = Colors.white,
      this.width,
      super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 12.0),
            padding: const EdgeInsets.all(16.0),
            width: width,
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: child));
  }
}
