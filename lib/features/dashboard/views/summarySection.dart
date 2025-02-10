import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:possystem/core/utils/appHelper.dart';
import 'package:possystem/features/dashboard/viewmodels/summaryViewmodel.dart';
import 'package:possystem/widgets/constant/dashboardContainer.dart';

class SummarySection extends ConsumerWidget {
  const SummarySection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final summaryItems = ref.watch(summaryProvider);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: summaryItems.map((item) {
        return DashboardContainer(
          child: SummaryItem(
            value: item.value,
            label: item.label,
          ),
        );
      }).toList(),
    );
  }
}

class SummaryItem extends StatelessWidget {
  final String value;
  final String label;

  const SummaryItem({
    Key? key,
    required this.value,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        AutoSizeText(
          value,
          style: AppTexts.medium(size: 20, color: AppColors.primaryText),
          maxLines: 1,
        ),
        AutoSizeText(
          label,
          style: AppTexts.regular(size: 16, color: AppColors.greyDark),
          maxLines: 1,
        ),
      ],
    );
  }
}
