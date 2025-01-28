import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:possystem/utils/appHelper.dart';

final loginErrorProvider = StateProvider<String>((ref) => "");
final pinProvider = StateProvider<String>((ref) => '');

Widget buildKeypadButton(
    String digit, TextEditingController pinController, WidgetRef ref) {
  return SizedBox(
    width: 70,
    height: 70,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.loginKeypad,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(35),
        ),
      ),
      onPressed: () {
        final currentPin = ref.read(pinProvider);
        if (currentPin.length < 6) {
          ref.read(pinProvider.notifier).state = currentPin + digit;
          ref.read(loginErrorProvider.notifier).state = "";
        }
      },
      child: Text(
        digit,
        style: TextStyle(fontSize: 36, color: AppColors.secondaryText),
      ),
    ),
  );
}
