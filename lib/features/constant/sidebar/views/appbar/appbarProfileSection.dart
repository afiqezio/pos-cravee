import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:possystem/core/utils/appHelper.dart';
import 'package:possystem/features/auth/login/viewmodels/userViewmodel.dart';

class AppbarProfileSection extends ConsumerWidget {
  const AppbarProfileSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    return Container(
      color: AppColors.violet100,
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage('assets/images/person.png'),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      user?.firstName ?? 'Guest',
                      style: AppTexts.medium(size: 16),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      user?.lastName ?? '',
                      style: AppTexts.medium(size: 16),
                    ),
                  ],
                ),
                Text(
                  user?.gender ?? 'Gender',
                  style: AppTexts.regular(size: 16),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
