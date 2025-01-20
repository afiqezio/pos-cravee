import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFF2F2F7),
      child: Center(
        child: Text(
          'Dashboard Page',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
