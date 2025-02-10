import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:possystem/features/constant/sidebar/viewmodels/sidebarViewmodel.dart';
import 'package:possystem/features/menu/selectionPage/viewmodels/cartProvider.dart';
import 'package:possystem/features/menu/processPage/viewmodels/cashProvider.dart';
import 'package:possystem/core/utils/appHelper.dart';
import 'package:possystem/widgets/constant/appScaffold.dart';
import 'package:possystem/features/auth/passkey/views/passkeyMain.dart';

class LogoutPage extends ConsumerWidget {
  const LogoutPage({Key? key}) : super(key: key);

  void _showConfirmationDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Close Register'),
          content: const Text('Are you sure you want to close this register?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'Cancel',
                style: TextStyle(color: AppColors.greyText),
              ),
            ),
            TextButton(
              onPressed: () {
                ref.read(sidebarProvider.notifier).resetSelection();
                clearCart(ref);
                clearCashProvider(ref);
                Navigator.of(context).pop();
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) => PasskeyPage(),
                  ),
                  (route) => false,
                );
              },
              child: const Text(
                'Close Register',
                style: TextStyle(
                  color: AppColors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppScaffold(
      title: 'Log Out',
      subtitle:
          'Confirmation screen before logging you out to prevent accidental logouts.',
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        spacing: 18,
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () => (),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 12.0,
              ),
              child: Text(
                'Discard',
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.secondaryText,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () => _showConfirmationDialog(context, ref),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 12.0,
              ),
              child: Text(
                'Close Register',
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.secondaryText,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
