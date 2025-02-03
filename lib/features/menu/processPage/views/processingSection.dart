import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:possystem/core/utils/appHelper.dart';
import 'package:possystem/widgets/customLoading.dart';
import 'dart:async';

class ProcessingSection extends ConsumerStatefulWidget {
  @override
  _ProcessingSectionState createState() => _ProcessingSectionState();
}

class _ProcessingSectionState extends ConsumerState<ProcessingSection> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), () {
      context.go(
          '/menu/productpicker/process/membership/confirmationCart/processCard/receipt');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(36.0),
        child: Column(
          children: [
            CustomLoading(),
            Padding(
              padding: const EdgeInsets.all(28.0),
              child: Text(
                'Processing Payment',
                style: AppTexts.semiBold(size: 24),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
