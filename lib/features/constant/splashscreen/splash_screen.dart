import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:possystem/features/auth/login/viewmodels/authViewmodel.dart';
import 'package:possystem/features/auth/login/views/loginPageMain.dart';
import 'package:possystem/features/auth/passkey/views/passkeyMain.dart';
import 'package:possystem/core/utils/appHelper.dart';

class SplashScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoggedIn = ref.watch(authStateProvider);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 3), () {
        if (isLoggedIn) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => PasskeyPage()),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LoginPage()),
          );
        }
      });
    });

    return Scaffold(
      backgroundColor: AppColors.canvasPrimary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/svg/pretzley.svg',
              width: 120,
              height: 120,
            ),
          ],
        ),
      ),
    );
  }
}
