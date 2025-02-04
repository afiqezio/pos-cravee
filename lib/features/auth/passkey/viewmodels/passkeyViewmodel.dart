import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:possystem/data/repo/auth_repo.dart';
import 'package:possystem/data/repo/user_repo.dart';
import 'package:possystem/features/auth/login/viewmodels/userViewmodel.dart';
import 'package:possystem/features/auth/passkey/views/widgets/loginDropdown.dart';
import 'package:possystem/core/utils/appHelper.dart';

final loginErrorProvider = StateProvider<String>((ref) => "");
final pinProvider = StateProvider<String>((ref) => '');
// StateProvider to hold the selected value
final selectedDropdownValueProvider =
    StateProvider<DropdownModel?>((ref) => null);

Future<bool> loginByKey(String pin, WidgetRef ref) async {
  final repository = ref.watch(authRepositoryProvider);
  final userRepository = ref.watch(userRepositoryProvider);
  final username = ref.watch(selectedDropdownValueProvider);

  if (username == null) {
    return false;
  }

  final success = await repository.loginByKey(username.title, pin);

  if (success) {
    final selectedUser = ref.watch(selectedDropdownValueProvider);

    // Convert DropdownModel to User (assuming you have a User class)
    if (selectedUser != null) {
      final user = await userRepository.fetchUserById(selectedUser.id);

      // Assign the selected user to the userProvider
      ref.read(userProvider.notifier).setUser(user);
    }
  }

  return success;
}

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
