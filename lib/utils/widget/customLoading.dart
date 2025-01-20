import 'package:flutter/material.dart';

class CustomLoading extends StatelessWidget {
  const CustomLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: Color(0xFFFA4C2F),
        backgroundColor: Color(0xFFE3663F),
        strokeWidth: 7,
      ),
    );
  }
}
