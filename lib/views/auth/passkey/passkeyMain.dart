import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:possystem/providers/loginProvider.dart';

import 'imageSlideSection.dart';
import 'passkeySection.dart';

class PasskeyPage extends ConsumerStatefulWidget {
  const PasskeyPage({Key? key}) : super(key: key);

  @override
  ConsumerState<PasskeyPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<PasskeyPage> {
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
          Expanded(child: PasskeySection()),
        ],
      ),
    );
  }
}
