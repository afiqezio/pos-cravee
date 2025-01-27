import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:possystem/data/models/voucher.dart';
import 'package:possystem/utils/appHelper.dart';
import 'package:possystem/widgets/customBackButton.dart';
import 'package:possystem/widgets/customMainContainer.dart';
import 'package:possystem/features/menu/membershipPage/views/voucherCard.dart';
import 'membershipProfile.dart';

class MembershipPageMain extends ConsumerWidget {
  const MembershipPageMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F7),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomMainContainer(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Row for Back and Skip buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomBackButton(),
                        TextButton(
                          onPressed: () {
                            context.go(
                                '/menu/productpicker/process/membership/confirmationCart');
                          },
                          child: const Text(
                            "Skip",
                            style: TextStyle(
                                color: AppColors.secondary, fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                    // Profile
                    Center(child: MembershipProfile()),
                  ],
                ),
              ),
              CustomMainContainer(
                  child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Voucher Code',
                        style: TextStyle(
                            color: AppColors.primaryText,
                            fontSize: 16,
                            fontWeight: FontWeight.w600)),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: vouchers
                            .map((voucher) => VoucherCard(voucher: voucher))
                            .toList(),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Voucher Code',
                        style: TextStyle(
                            color: AppColors.primaryText,
                            fontSize: 16,
                            fontWeight: FontWeight.w600)),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 4.0, vertical: 16),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 5,
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Please input your voucher code',
                              hintStyle: TextStyle(color: AppColors.greyText),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    BorderSide(color: Color(0xFF9599AD)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    BorderSide(color: Colors.orange, width: 2),
                              ),
                              filled: true,
                              fillColor: AppColors.canvasPrimary,
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 0,
                                horizontal: 16,
                              ),
                            ),
                            style: TextStyle(color: Color(0xFF9599AD)),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              color: AppColors.secondary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              elevation: 0,
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Center(
                                  child: Text(
                                    'Voucher',
                                    style: const TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w800,
                                      color: AppColors.secondaryText,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // SingleChildScrollView(
                  //   scrollDirection: Axis.horizontal,
                  //   child: Row(
                  //     children: vouchers
                  //         .map((voucher) => VoucherCard(voucher: voucher))
                  //         .toList(),
                  //   ),
                  // ),
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }
}
