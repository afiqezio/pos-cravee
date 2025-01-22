import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:possystem/providers/sidebarProvider.dart';
import 'package:possystem/utils/appHelper.dart';
import 'package:possystem/views/widget/appbar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ScaffoldWithNavBar extends ConsumerStatefulWidget {
  final Widget child;

  const ScaffoldWithNavBar({Key? key, required this.child}) : super(key: key);

  @override
  _ScaffoldWithNavBarState createState() => _ScaffoldWithNavBarState();
}

class _ScaffoldWithNavBarState extends ConsumerState<ScaffoldWithNavBar> {
  bool _isCollapsed = true;
  // int _selectedHeaderIndex = 0;
  // int _selectedFooterIndex = -1;
  Map<int, bool> _sublistExpanded = {};

  final List<Map<String, dynamic>> _sidebarItems = [
    {
      'icon': 'assets/svg/sidebar/dashboard.svg',
      'text': 'Dashboard',
      'route': '/dashboard',
    },
    {
      'icon': 'assets/svg/sidebar/menu.svg',
      'text': 'Menu',
      'route': '/menu',
    },
    {
      'icon': 'assets/svg/sidebar/transactions.svg',
      'text': 'Transactions',
      'route': '/transactions',
    },
    {
      'icon': 'assets/svg/sidebar/product.svg',
      'text': 'Product',
      'route': '/product',
      'subItems': [
        {
          'icon': 'assets/svg/sidebar/product.svg',
          'text': 'Category',
          'route': '/product/category',
        },
        {
          'icon': 'assets/svg/sidebar/product.svg',
          'text': 'Remove Menu',
          'route': '/product/category',
        },
      ],
    },
    {
      'icon': 'assets/svg/sidebar/report.svg',
      'text': 'Report',
      'route': '/report',
    },
  ];

  final List<Map<String, dynamic>> _sidebarFooterItems = [
    {
      'icon': 'assets/svg/sidebar/settings.svg',
      'text': 'Settings',
      'route': '/settings',
    },
    {
      'icon': 'assets/svg/sidebar/logout.svg',
      'text': 'Logout',
      'route': '/logout',
    },
  ];

  void toggleSidebar() {
    setState(() {
      _isCollapsed = !_isCollapsed;
    });
  }

  @override
  void initState() {
    super.initState();
    // Initialize all parent items to be collapsed by default
    for (int i = 0; i < _sidebarItems.length; i++) {
      if (_sidebarItems[i]['subItems'] != null) {
        _sublistExpanded[i] = false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Row(
        children: [
          // Sidebar
          AnimatedContainer(
            duration: Duration(milliseconds: 300),
            width: _isCollapsed ? screenWidth * 0.07 : screenWidth * 0.19,
            // width: _isCollapsed ? 80 : 220,
            decoration: BoxDecoration(
              color: AppColors.primary,
            ),
            child: Column(
              children: [
                SizedBox(height: 16),
                // Logo at the top of the sidebar
                Padding(
                  padding: _isCollapsed
                      ? EdgeInsets.all(8.0)
                      : EdgeInsets.symmetric(vertical: 2.0, horizontal: 40),
                  child: Center(
                    child: AnimatedSwitcher(
                      duration: Duration(milliseconds: 250),
                      transitionBuilder:
                          (Widget child, Animation<double> animation) {
                        return FadeTransition(
                          opacity: animation,
                          child: ScaleTransition(
                            scale: animation,
                            child: child,
                          ),
                        );
                      },
                      child: _isCollapsed
                          ? SvgPicture.asset(
                              'assets/svg/pretzley_logo.svg',
                              height: 70,
                              key: ValueKey('collapsed_logo'),
                            )
                          : SvgPicture.asset(
                              'assets/svg/pretzley_text.svg',
                              height: 100,
                              key: ValueKey('expanded_logo'),
                            ),
                    ),
                  ),
                ),
                // Header
                ..._sidebarItems.map((item) {
                  final index = _sidebarItems.indexOf(item);
                  return _buildSidebarItem(
                    icon: item['icon'],
                    text: item['text'],
                    route:
                        item['subItems'] != null && item['subItems'].isNotEmpty
                            ? item['subItems'][0]['route']
                            : item['route'],
                    index: index,
                    isFooterItem: false,
                    subItems:
                        item['subItems']?.asMap().entries.map<Widget>((entry) {
                      int subIndex = entry.key;
                      var subItem = entry.value;
                      return _buildSidebarItem(
                        icon: subItem['icon'],
                        text: subItem['text'],
                        route: subItem['route'],
                        index: index * 100 + subIndex,
                        isFooterItem: false,
                      );
                    }).toList(),
                  );
                }).toList(),
                Spacer(),
                // Footer
                ..._sidebarFooterItems.map((item) {
                  final index = _sidebarFooterItems.indexOf(item);
                  return _buildSidebarItem(
                    icon: item['icon'],
                    text: item['text'],
                    route: item['route'],
                    index: index,
                    isFooterItem: true,
                  );
                }).toList(),
                Divider(color: Colors.white.withOpacity(0.5)),
                IconButton(
                    icon: Icon(
                      _isCollapsed
                          ? Icons.arrow_right_outlined
                          : Icons.arrow_left_outlined,
                      color: Colors.white,
                    ),
                    onPressed: toggleSidebar),
              ],
            ),
          ),
          // Main content
          Expanded(
              child: Scaffold(
            body: Scaffold(
              backgroundColor: AppColors.background,
              body: widget.child,
            ),
            appBar: CustomAppBar(),
          )),
        ],
      ),
    );
  }

  // Helper method to build ListTile with icon and text
  Widget _buildSidebarItem({
    required String icon,
    required String text,
    required String route,
    required int index,
    bool isFooterItem = false,
    List<Widget>? subItems,
  }) {
    final selectedIndices = ref.watch(sidebarProvider);
    final selectedHeaderIndex = selectedIndices['headerIndex'];
    final selectedFooterIndex = selectedIndices['footerIndex'];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              if (subItems != null && subItems.isNotEmpty) {
                setState(() {
                  // Collapse all other parent items
                  _sublistExpanded.forEach((key, value) {
                    if (key != index) {
                      _sublistExpanded[key] = false;
                    }
                  });
                  _sublistExpanded[index] = !(_sublistExpanded[index] ?? false);

                  if (_isCollapsed) {
                    _isCollapsed = false;
                    _sublistExpanded[index] = true;
                  }
                });
              } else {
                if (isFooterItem) {
                  ref.read(sidebarProvider.notifier).selectFooterIndex(
                      index); // Set the selected index for the footer item
                  ref
                      .read(sidebarProvider.notifier)
                      .selectHeaderIndex(-1); // Deselect any header item
                } else {
                  ref.read(sidebarProvider.notifier).selectHeaderIndex(
                      index); // Set the selected index for the header item
                  ref
                      .read(sidebarProvider.notifier)
                      .selectFooterIndex(-1); // Deselect any footer item
                }
                context.go(route);
              }
            },
            child: Container(
              decoration: BoxDecoration(
                color: (isFooterItem
                        ? selectedFooterIndex == index
                        // : _isCollapsed
                        //     ? (selectedHeaderIndex == index ||
                        //         (selectedHeaderIndex != null &&
                        //             selectedHeaderIndex >= index * 100 &&
                        //             selectedHeaderIndex <= index * 150))
                        : selectedHeaderIndex == index)
                    ? AppColors.secondary
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: _isCollapsed
                      ? MainAxisAlignment.center
                      : MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(icon, width: 22, color: Colors.white),
                    AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      width: _isCollapsed ? 0 : 12,
                    ),
                    if (!_isCollapsed)
                      Expanded(
                        child: AnimatedOpacity(
                          duration: Duration(milliseconds: 200),
                          opacity: _isCollapsed ? 0 : 1,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  text,
                                  style: AppTexts.regular(
                                      size: 16, color: Colors.white),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                              if (subItems != null && subItems.isNotEmpty)
                                Icon(
                                  (_sublistExpanded[index] ?? false)
                                      ? Icons.arrow_downward_outlined
                                      : Icons.arrow_forward_ios_outlined,
                                  color: Colors.white,
                                  size: 12,
                                ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
          // Render subitems if the parent is expanded
          if ((_sublistExpanded[index] ?? false) &&
              subItems != null &&
              subItems.isNotEmpty &&
              !_isCollapsed) ...[
            AnimatedSize(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              child: AnimatedOpacity(
                duration: Duration(milliseconds: 200),
                opacity: (_sublistExpanded[index] ?? false) ? 1.0 : 0.0,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: subItems.map<Widget>((subItem) {
                    return subItem; // Directly return the subItem
                  }).toList(),
                ),
              ),
            ),
          ] else ...[
            SizedBox.shrink(),
          ],
        ],
      ),
    );
  }
}
