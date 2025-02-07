// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:go_router/go_router.dart';
// import 'package:possystem/features/constant/sidebar/viewmodels/sidebarViewmodel.dart';
// import 'package:possystem/core/utils/appHelper.dart';
// import 'package:possystem/features/constant/sidebar/views/appbarMain.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// class ScaffoldWithNavBar extends ConsumerStatefulWidget {
//   final Widget child;

//   const ScaffoldWithNavBar({Key? key, required this.child}) : super(key: key);

//   @override
//   _ScaffoldWithNavBarState createState() => _ScaffoldWithNavBarState();
// }

// class _ScaffoldWithNavBarState extends ConsumerState<ScaffoldWithNavBar> {
//   bool _isCollapsed = true;
//   Map<int, bool> _sublistExpanded = {};

//   final List<Map<String, dynamic>> _sidebarItems = [
//     {
//       'index': 1,
//       'icon': 'assets/svg/sidebar/dashboard.svg',
//       'text': 'Dashboard',
//       'route': '/dashboard',
//     },
//     {
//       'index': 2,
//       'icon': 'assets/svg/sidebar/menu.svg',
//       'text': 'Menu',
//       'route': '/menu',
//     },
//     {
//       'index': 3,
//       'icon': 'assets/svg/sidebar/transactions.svg',
//       'text': 'Transactions',
//       'route': '/transactions',
//     },
//     {
//       'index': 4,
//       'icon': 'assets/svg/sidebar/product.svg',
//       'text': 'Product',
//       'route': '/product',
//       'subItems': [
//         {
//           'index': 1,
//           'icon': 'assets/svg/sidebar/product.svg',
//           'text': 'Category',
//           'route': '/product/category',
//         },
//         {
//           'index': 2,
//           'icon': 'assets/svg/sidebar/product.svg',
//           'text': 'Remove Menu',
//           'route': '/product/category',
//         },
//         {
//           'index': 3,
//           'icon': 'assets/svg/sidebar/product.svg',
//           'text': 'Remove Menu',
//           'route': '/product/category',
//         },
//         {
//           'index': 4,
//           'icon': 'assets/svg/sidebar/product.svg',
//           'text': 'Remove Menu',
//           'route': '/product/category',
//         },
//       ],
//     },
//     {
//       'index': 5,
//       'icon': 'assets/svg/sidebar/report.svg',
//       'text': 'Report',
//       'route': '/report',
//     }
//   ];

//   final List<Map<String, dynamic>> _sidebarFooterItems = [
//     {
//       'index': 1,
//       'icon': 'assets/svg/sidebar/settings.svg',
//       'text': 'Settings',
//       'route': '/settings',
//     },
//     {
//       'index': 2,
//       'icon': 'assets/svg/sidebar/logout.svg',
//       'text': 'Logout',
//       'route': '/logout',
//     },
//   ];

//   void toggleSidebar() {
//     if (!mounted) return;
//     setState(() {
//       _isCollapsed = !_isCollapsed;
//     });
//   }

//   @override
//   void initState() {
//     super.initState();
//     // Initialize all parent items to be collapsed by default
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       ref.read(sidebarProvider.notifier).selectHeaderIndex(1);
//       ref.read(sidebarProvider.notifier).selectFooterIndex(-1);
//       context.go('/dashboard');
//       for (int i = 0; i < _sidebarItems.length; i++) {
//         if (_sidebarItems[i]['subItems'] != null) {
//           _sublistExpanded[i] = false;
//         }
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Row(
//         children: [
//           // Sidebar
//           GestureDetector(
//             onHorizontalDragUpdate: (details) {
//               if (!mounted) return;
//               setState(() {
//                 // Adjust the width based on drag distance
//                 if (details.delta.dx > 10) {
//                   // Dragging right
//                   _isCollapsed = false;
//                 } else if (details.delta.dx < -10) {
//                   // Dragging left
//                   _isCollapsed = true;
//                 }
//               });
//             },
//             child: AnimatedContainer(
//               duration: Duration(milliseconds: 300),
//               width: _isCollapsed ? 80 : 240,
//               decoration: BoxDecoration(
//                 color: AppColors.primary,
//               ),
//               child: Column(
//                 children: [
//                   SizedBox(height: 16),
//                   // Logo at the top of the sidebar
//                   GestureDetector(
//                     onTap: toggleSidebar,
//                     child: Padding(
//                       padding: _isCollapsed
//                           ? EdgeInsets.fromLTRB(6.0, 6, 6.0, 30)
//                           : EdgeInsets.fromLTRB(2.0, 8, 2.0, 30),
//                       child: Center(
//                         child: SvgPicture.asset(
//                           'assets/svg/pretzley_logo.svg',
//                           height: 70,
//                           key: ValueKey('collapsed_logo'),
//                         ),
//                       ),
//                     ),
//                   ),
//                   // Header
//                   Expanded(
//                     flex: 7,
//                     child: SingleChildScrollView(
//                       child: Column(
//                         children: [
//                           ..._sidebarItems.map((item) {
//                             // final index = _sidebarItems.indexOf(item);
//                             return _buildSidebarItem(
//                               icon: item['icon'],
//                               text: item['text'],
//                               route: item['subItems'] != null &&
//                                       item['subItems'].isNotEmpty
//                                   ? item['subItems'][0]['route']
//                                   : item['route'],
//                               index: item['index'],
//                               isFooterItem: false,
//                               subItems: item['subItems']
//                                   ?.asMap()
//                                   .entries
//                                   .map<Widget>((entry) {
//                                 int subIndex = entry.key;
//                                 var subItem = entry.value;
//                                 return _buildSidebarItem(
//                                   icon: subItem['icon'],
//                                   text: subItem['text'],
//                                   route: subItem['route'],
//                                   index: item['index'] * 100 + subIndex,
//                                   isFooterItem: false,
//                                 );
//                               }).toList(),
//                             );
//                           }).toList(),
//                         ],
//                       ),
//                     ),
//                   ),
//                   // Footer
//                   Expanded(
//                       flex: 2,
//                       child: Column(
//                           mainAxisSize: MainAxisSize.min,
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             ..._sidebarFooterItems.map((item) {
//                               // final index = _sidebarFooterItems.indexOf(item);
//                               return _buildSidebarItem(
//                                 icon: item['icon'],
//                                 text: item['text'],
//                                 route: item['route'],
//                                 index: item['index'],
//                                 isFooterItem: true,
//                               );
//                             }).toList(),
//                           ])),
//                 ],
//               ),
//             ),
//           ),
//           // Main content
//           Expanded(
//               child: Scaffold(
//             body: Scaffold(
//               backgroundColor: AppColors.background,
//               body: widget.child,
//             ),
//             appBar: CustomAppBar(),
//           )),
//         ],
//       ),
//     );
//   }

//   // Helper method to build ListTile with icon and text
//   Widget _buildSidebarItem({
//     required String icon,
//     required String text,
//     required String route,
//     required int index,
//     bool isFooterItem = false,
//     List<Widget>? subItems,
//   }) {
//     final selectedIndices = ref.watch(sidebarProvider);
//     final selectedHeaderIndex = selectedIndices.headerIndex;
//     final selectedFooterIndex = selectedIndices.footerIndex;

//     bool isSelected = isFooterItem
//         ? selectedFooterIndex == index
//         : selectedHeaderIndex == index
//             ? true
//             : _isCollapsed
//                 ? (selectedHeaderIndex >= index * 100 &&
//                     selectedHeaderIndex < (index + 1) * 100)
//                 : _sublistExpanded[index] != null &&
//                         _sublistExpanded[index] == false
//                     ? (selectedHeaderIndex >= index * 100 &&
//                             selectedHeaderIndex < (index + 1) * 100)
//                         ? true
//                         : false
//                     : false;

//     Color backgroundColor =
//         isSelected ? AppColors.secondary : AppColors.transparent;

//     return Column(
//       children: [
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
//           child: GestureDetector(
//             onTap: () {
//               if (subItems != null && subItems.isNotEmpty) {
//                 if (!mounted) return;
//                 setState(() {
//                   // Collapse all other parent items
//                   _sublistExpanded.forEach((key, value) {
//                     if (key != index) {
//                       _sublistExpanded[key] = false;
//                     }
//                   });
//                   _sublistExpanded[index] = !(_sublistExpanded[index] ?? false);

//                   if (_isCollapsed) {
//                     _isCollapsed = false;
//                     _sublistExpanded[index] = true;
//                   }
//                 });
//               } else {
//                 if (isFooterItem) {
//                   ref.read(sidebarProvider.notifier).selectFooterIndex(
//                       index); // Set the selected index for the footer item
//                   ref
//                       .read(sidebarProvider.notifier)
//                       .selectHeaderIndex(-1); // Deselect any header item
//                 } else {
//                   ref.read(sidebarProvider.notifier).selectHeaderIndex(
//                       index); // Set the selected index for the header item
//                   ref
//                       .read(sidebarProvider.notifier)
//                       .selectFooterIndex(-1); // Deselect any footer item
//                 }
//                 context.go(route);
//               }
//             },
//             child: Container(
//               decoration: BoxDecoration(
//                 color: backgroundColor,
//                 borderRadius: BorderRadius.circular(8.0),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(12),
//                 child: Row(
//                   mainAxisAlignment: _isCollapsed
//                       ? MainAxisAlignment.center
//                       : MainAxisAlignment.start,
//                   children: [
//                     SvgPicture.asset(icon,
//                         width: 22, color: AppColors.canvasPrimary),
//                     AnimatedContainer(
//                       duration: Duration(milliseconds: 300),
//                       width: _isCollapsed ? 0 : 12,
//                     ),
//                     if (!_isCollapsed)
//                       Expanded(
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Expanded(
//                               child: Text(
//                                 text,
//                                 style: AppTexts.regular(
//                                     size: 16, color: AppColors.secondaryText),
//                                 overflow: TextOverflow.ellipsis,
//                                 maxLines: 1,
//                               ),
//                             ),
//                             if (subItems != null && subItems.isNotEmpty)
//                               Flexible(
//                                 child: Icon(
//                                   (_sublistExpanded[index] ?? false)
//                                       ? Icons.keyboard_arrow_down_outlined
//                                       : Icons.keyboard_arrow_right_outlined,
//                                   color: AppColors.canvasPrimary,
//                                   size: 18,
//                                 ),
//                               ),
//                           ],
//                         ),
//                       ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//         // Render subitems if the parent is expanded
//         if ((_sublistExpanded[index] ?? false) &&
//             subItems != null &&
//             subItems.isNotEmpty &&
//             !_isCollapsed) ...[
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 3),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: subItems.map<Widget>((subItem) {
//                 return subItem;
//               }).toList(),
//             ),
//           ),
//         ] else ...[
//           SizedBox.shrink(),
//         ],
//       ],
//     );
//   }

//   @override
//   void dispose() {
//     // Cancel any controllers, timers, etc. here
//     super.dispose();
//   }
// }
