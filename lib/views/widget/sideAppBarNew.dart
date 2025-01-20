// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:go_router/go_router.dart';
// import 'package:possystem/utils/appColors.dart';
// import 'package:possystem/views/widget/appbar.dart';

// class ScaffoldWithNavBar extends StatefulWidget {
//   final Widget child;

//   const ScaffoldWithNavBar({Key? key, required this.child}) : super(key: key);

//   @override
//   _ScaffoldWithNavBarState createState() => _ScaffoldWithNavBarState();
// }

// class _ScaffoldWithNavBarState extends State<ScaffoldWithNavBar> {
//   bool _isCollapsed = true;
//   int _selectedIndex = 0;

//   final List<Map<String, dynamic>> _sidebarItems = [
//     {
//       'icon': 'assets/svg/sidebar/dashboard.svg',
//       'text': 'Dashboard',
//       'route': '/dashboard',
//     },
//     {
//       'icon': 'assets/svg/sidebar/menu.svg',
//       'text': 'Menu',
//       'route': '/menu',
//     },
//     {
//       'icon': 'assets/svg/sidebar/transactions.svg',
//       'text': 'Transactions',
//       'route': '/transactions',
//     },
//     {
//       'icon': 'assets/svg/sidebar/product.svg',
//       'text': 'Product',
//       'route': '/product',
//     },
//     {
//       'icon': 'assets/svg/sidebar/report.svg',
//       'text': 'Report',
//       'route': '/report',
//     },
//   ];

//   // final List<Map<String, dynamic>> _sidebarFooterItems = [
//   //   {
//   //     'icon': 'assets/svg/sidebar/settings.svg',
//   //     'text': 'Settings',
//   //     'route': '/settings',
//   //   },
//   //   {
//   //     'icon': 'assets/svg/sidebar/logout.svg',
//   //     'text': 'Logout',
//   //     'route': '/logout',
//   //   },
//   // ];

//   void toggleSidebar() {
//     setState(() {
//       _isCollapsed = !_isCollapsed;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Row(
//         children: [
//           // Sidebar
//           AnimatedContainer(
//             duration: Duration(milliseconds: 300),
//             width: _isCollapsed ? 80 : 200,
//             decoration: BoxDecoration(
//               color: AppColors.primary,
//               // boxShadow: [
//               //   BoxShadow(
//               //     color: Colors.black.withOpacity(0.2),
//               //     blurRadius: 10,
//               //     offset: Offset(0, 4),
//               //   ),
//               // ],
//             ),
//             child: Column(
//               children: [
//                 SizedBox(height: 16),
//                 // Logo at the top of the sidebar
//                 Padding(
//                   padding: _isCollapsed
//                       ? EdgeInsets.all(6.0)
//                       : EdgeInsets.symmetric(vertical: 2.0, horizontal: 20),
//                   child: Center(
//                     child: _isCollapsed
//                         ? SvgPicture.asset('assets/svg/pretzley_logo.svg',
//                             height: 70)
//                         : SvgPicture.asset('assets/svg/pretzley_text.svg',
//                             height: 100),
//                   ),
//                 ),
//                 // Header
//                 ..._sidebarItems.map((item) {
//                   final index = _sidebarItems.indexOf(item);
//                   return _buildSidebarItem(
//                     icon: item['icon'],
//                     text: item['text'],
//                     route: item['route'],
//                     index: index,
//                   );
//                 }).toList(),
//                 Spacer(),
//                 // // Footer
//                 // ..._sidebarFooterItems.map((item) {
//                 //   final index = _sidebarFooterItems.indexOf(item);
//                 //   return _buildSidebarItem(
//                 //     icon: item['icon'],
//                 //     text: item['text'],
//                 //     route: item['route'],
//                 //     index: index,
//                 //   );
//                 // }).toList(),
//                 Divider(color: Colors.white.withOpacity(0.5)),
//                 IconButton(
//                     icon: Icon(
//                       _isCollapsed
//                           ? Icons.arrow_right_outlined
//                           : Icons.arrow_left_outlined,
//                       color: Colors.white,
//                     ),
//                     onPressed: toggleSidebar),
//               ],
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
//   }) {
//     return Padding(
//       padding: const EdgeInsets.all(12),
//       child: GestureDetector(
//         onTap: () {
//           setState(() {
//             _selectedIndex = index;
//           });
//           context.go(route);
//         },
//         child: Container(
//           decoration: BoxDecoration(
//             color: _selectedIndex == index
//                 ? AppColors.secondary
//                 : Colors.transparent,
//             borderRadius: BorderRadius.circular(8.0),
//           ),
//           child: Padding(
//             padding: const EdgeInsets.all(14),
//             child: Row(
//               mainAxisAlignment: _isCollapsed
//                   ? MainAxisAlignment.center
//                   : MainAxisAlignment.start,
//               children: [
//                 SvgPicture.asset(icon, width: 22, color: Colors.white),
//                 if (!_isCollapsed) SizedBox(width: 12),
//                 if (!_isCollapsed)
//                   Expanded(
//                     child: Text(
//                       text,
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.w700,
//                         fontSize: 16,
//                       ),
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                   ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
