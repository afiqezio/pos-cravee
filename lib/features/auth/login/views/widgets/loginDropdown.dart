import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:possystem/features/auth/login/views/login.dart';
import 'package:possystem/features/auth/login/views/widgets/dropdownModel.dart';
import 'package:possystem/features/auth/passkey/viewmodels/passkeyViewmodel.dart';
import 'package:possystem/utils/appHelper.dart';

class LoginDropdown extends ConsumerWidget {
  final String? imagePath;
  final List<DropdownModel> items;
  final ValueChanged<String>? onItemSelected;

  const LoginDropdown({
    Key? key,
    this.imagePath,
    required this.items,
    this.onItemSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedValue = ref.watch(selectedDropdownValueProvider);

    return Container(
      width: MediaQuery.of(context).size.width * 0.36,
      decoration: BoxDecoration(
        color: AppColors.orangeDark50,
        borderRadius: BorderRadius.circular(6),
      ),
      child: PopupMenuButton<String>(
        surfaceTintColor: Colors.white,
        onSelected: (value) {
          if (value == 'Add Account') {
            // Navigate to the login page
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => LoginPage()),
            );
          } else {
            final selectedItem = items.firstWhere(
              (item) => item.title == value,
              orElse: () => items.first,
            );

            // Update the selected value in the provider
            ref.read(selectedDropdownValueProvider.notifier).state =
                selectedItem;

            if (onItemSelected != null) {
              onItemSelected!(value);
            }
          }
        },
        constraints: BoxConstraints.tightFor(
          width: MediaQuery.of(context).size.width * 0.36,
        ),
        itemBuilder: (context) {
          return [
            PopupMenuItem<String>(
              enabled: true,
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: 200,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: items
                        .map((item) => ListTile(
                              contentPadding: EdgeInsets.zero,
                              title: Text(
                                item.title,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                              subtitle: item.description != null
                                  ? Text(
                                      item.description!,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: AppColors.secondary,
                                      ),
                                    )
                                  : null,
                              onTap: () {
                                Navigator.pop(context, item.title);
                                ref
                                    .read(
                                        selectedDropdownValueProvider.notifier)
                                    .state = item;
                                if (onItemSelected != null) {
                                  onItemSelected!(item.title);
                                }
                              },
                            ))
                        .toList(),
                  ),
                ),
              ),
            ),
            PopupMenuItem<String>(
              value: 'Add Account',
              child: Row(
                children: [
                  Icon(Icons.add),
                  SizedBox(width: 8),
                  Text(
                    'Add Account',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ];
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                imagePath != null && imagePath!.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          radius: 25,
                          backgroundImage: AssetImage(imagePath!),
                        ),
                      )
                    : SizedBox(),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      selectedValue?.title ??
                          (items.isNotEmpty
                              ? items.first.title
                              : 'Add Account'),
                      style: AppTexts.medium(size: 16, color: Colors.black),
                    ),
                    items.isNotEmpty &&
                            items.first.description != null &&
                            items.first.description!.isNotEmpty
                        ? Text(
                            selectedValue?.description ??
                                (items.isNotEmpty
                                    ? items.first.description!
                                    : ''),
                            style: AppTexts.medium(
                                size: 16, color: AppColors.secondary),
                          )
                        : SizedBox(),
                  ],
                ),
              ],
            ),
            Icon(
              Icons.keyboard_arrow_down_outlined,
              size: 32,
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}
