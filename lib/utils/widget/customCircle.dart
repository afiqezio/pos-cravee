import 'package:flutter/material.dart';

class CustomCircle extends StatelessWidget {
  final double size;
  final Color fillColor;
  final Color borderColor;
  final double borderThickness;
  final Widget child;
  final Function(String)? onChanged;

  const CustomCircle({
    Key? key,
    this.size = 100.0,
    this.fillColor = Colors.blue,
    this.borderColor = Colors.black,
    this.borderThickness = 4.0,
    this.child = const Center(child: Text('')),
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onChanged?.call("Circle tapped");
      },
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: fillColor,
          shape: BoxShape.circle,
          border: Border.all(
            color: borderColor,
            width: borderThickness,
          ),
        ),
        child: Center(
          child: child,
        ),
      ),
    );
  }
}
