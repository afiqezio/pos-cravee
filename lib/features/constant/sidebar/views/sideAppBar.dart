import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:possystem/features/constant/sidebar/viewmodels/sidebarViewmodel.dart';
import 'package:possystem/core/utils/appHelper.dart';
import 'package:possystem/features/constant/sidebar/views/appbar/appbarMain.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:possystem/features/constant/sidebar/views/sidebar/sidebarConfig.dart';
import 'package:possystem/features/constant/sidebar/views/sidebar/sidebarItem.dart';

class ScaffoldWithNavBar extends ConsumerWidget {
  final Widget child;
  const ScaffoldWithNavBar({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sidebarState = ref.watch(sidebarProvider);
    final notifier = ref.read(sidebarProvider.notifier);

    return Scaffold(
      body: Row(
        children: [
          GestureDetector(
            onHorizontalDragUpdate: (details) {
              if (details.delta.dx > 10 && sidebarState.isCollapsed) {
                notifier.toggleSidebar();
              } else if (details.delta.dx < -10 && !sidebarState.isCollapsed) {
                notifier.toggleSidebar();
              }
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: sidebarState.isCollapsed ? 80 : 240,
              decoration: BoxDecoration(color: AppColors.primary),
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  // Logo section
                  GestureDetector(
                    onTap: () => notifier.toggleSidebar(),
                    child: _buildLogo(sidebarState.isCollapsed),
                  ),
                  // Scrollable header items
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: SidebarConfig.mainItems.map((item) {
                          return _SidebarItem(
                            item: item,
                            isCollapsed: sidebarState.isCollapsed,
                            isSelected:
                                sidebarState.selectedIndex == item.uniqueIndex,
                            isExpanded:
                                sidebarState.sublistExpanded[item.index] ??
                                    false,
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  // Footer items
                  ...SidebarConfig.footerItems.map((item) {
                    return _SidebarItem(
                      item: item,
                      isCollapsed: sidebarState.isCollapsed,
                      isSelected:
                          sidebarState.selectedIndex == item.uniqueIndex,
                      isFooter: true,
                    );
                  }).toList(),
                ],
              ),
            ),
          ),
          Expanded(
            child: Scaffold(
              backgroundColor: AppColors.background,
              appBar: const CustomAppBar(),
              body: child,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLogo(bool isCollapsed) {
    return Padding(
      padding: isCollapsed
          ? const EdgeInsets.fromLTRB(6.0, 6, 6.0, 30)
          : const EdgeInsets.fromLTRB(2.0, 8, 2.0, 30),
      child: Center(
        child: SvgPicture.asset(
          'assets/svg/pretzley_logo.svg',
          height: 70,
          key: const ValueKey('collapsed_logo'),
        ),
      ),
    );
  }
}

class _SidebarItem extends ConsumerWidget {
  final SidebarItem item;
  final bool isCollapsed;
  final bool isSelected;
  final bool isExpanded;
  final bool isFooter;

  const _SidebarItem({
    required this.item,
    required this.isCollapsed,
    required this.isSelected,
    this.isExpanded = false,
    this.isFooter = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hasSubItems = item.subItems != null && item.subItems!.isNotEmpty;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          child: GestureDetector(
            onTap: () {
              if (isCollapsed && hasSubItems) {
                // Expand the sidebar first only if the item has subitems
                ref.read(sidebarProvider.notifier).toggleSidebar();
              }
              if (hasSubItems) {
                ref.read(sidebarProvider.notifier).toggleSublist(item.index);
              } else {
                if (item.isFooter) {
                  ref
                      .read(sidebarProvider.notifier)
                      .selectFooterIndex(item.uniqueIndex);
                } else {
                  ref
                      .read(sidebarProvider.notifier)
                      .selectHeaderIndex(item.uniqueIndex);
                }
                context.go(item.routePath);
              }
            },
            child: _buildItemContent(context),
          ),
        ),
        if (hasSubItems && isExpanded && !isCollapsed)
          ..._buildSubItems(context, ref),
      ],
    );
  }

  Widget _buildItemContent(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isSelected ? AppColors.secondary : AppColors.transparent,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          mainAxisAlignment:
              isCollapsed ? MainAxisAlignment.center : MainAxisAlignment.start,
          children: [
            SvgPicture.asset(
              item.icon,
              width: 22,
              colorFilter: const ColorFilter.mode(
                AppColors.canvasPrimary,
                BlendMode.srcIn,
              ),
            ),
            if (!isCollapsed) ...[
              const SizedBox(width: 12),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        item.text,
                        style: AppTexts.regular(
                          size: 16,
                          color: AppColors.secondaryText,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                    if (item.subItems != null)
                      Flexible(
                        child: Icon(
                          isExpanded
                              ? Icons.keyboard_arrow_down_outlined
                              : Icons.keyboard_arrow_right_outlined,
                          color: AppColors.canvasPrimary,
                          size: 18,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  List<Widget> _buildSubItems(BuildContext context, WidgetRef ref) {
    return (item.subItems!).map<Widget>((subItem) {
      return Padding(
        padding: const EdgeInsets.only(left: 6),
        child: _SidebarItem(
          item: subItem,
          isCollapsed: isCollapsed,
          isSelected:
              ref.watch(sidebarProvider).selectedIndex == subItem.uniqueIndex,
        ),
      );
    }).toList();
  }
}
