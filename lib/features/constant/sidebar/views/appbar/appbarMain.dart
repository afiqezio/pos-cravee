import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:possystem/features/constant/sidebar/views/appbar/appbarProfileSection.dart';
import 'package:possystem/core/utils/appHelper.dart';

class CustomAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppBar(
      backgroundColor: AppColors.canvasPrimary,
      title: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Row(
          children: [
            // Search Bar
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search your menu order',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: AppColors.keypad,
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 0,
                    horizontal: 16,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            // Profile Section
            AppbarProfileSection(),
            const SizedBox(width: 16),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
