import 'package:flutter/material.dart';

class CustomSlidable extends StatelessWidget {
  final Function(BuildContext) onPressed;
  final Color backgroundColor;
  final Color foregroundColor;
  final IconData icon;

  const CustomSlidable({
    Key? key,
    required this.onPressed,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: () => onPressed(context),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          height: double.infinity,
          decoration: BoxDecoration(
            color: backgroundColor,
            // borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: foregroundColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
