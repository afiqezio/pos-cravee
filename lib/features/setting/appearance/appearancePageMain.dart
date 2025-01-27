import 'package:flutter/material.dart';
import 'package:possystem/widgets/customSubContainer.dart';
import 'package:possystem/features/setting/appearance/size.dart';
import 'package:possystem/features/setting/appearance/theme.dart';

class AppearancePageMain extends StatelessWidget {
  const AppearancePageMain({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomSubContainer(
          child: ThemeSection(),
        ),
        CustomSubContainer(
          child: SizeSection(),
        ),
      ],
    );
  }
}
