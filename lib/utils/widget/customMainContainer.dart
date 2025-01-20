import 'package:flutter/material.dart';

class CustomMainContainer extends StatelessWidget {
  final Widget child;
  final Color? backgroundColor;

  const CustomMainContainer(
      {required this.child, this.backgroundColor = Colors.white, super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
            margin: const EdgeInsets.all(14.0),
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 6,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: child));
  }
}
