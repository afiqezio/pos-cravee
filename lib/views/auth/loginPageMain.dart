import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:possystem/providers/loginProvider.dart';
import 'package:possystem/views/auth/loginSection.dart';
import 'imageSlideSection.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  @override
  void initState() {
    super.initState();
    // Clear PIN when page is initialized
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(pinProvider.notifier).state = '';
      ref.read(loginErrorProvider.notifier).state = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Row(
        children: [
          // Left half - Image with SVG overlay
          Expanded(child: ImageSlideSection()),
          // Right half - PIN input
          Expanded(child: LoginSection()),
        ],
      ),
    );
  }
}
