import 'package:possystem/features/constant/sidebar/views/sidebar/sidebarItem.dart';

class SidebarConfig {
  static const List<SidebarItem> mainItems = [
    SidebarItem(
      index: 1,
      icon: 'assets/svg/sidebar/dashboard.svg',
      text: 'Dashboard',
      route: SidebarRoute.dashboard,
    ),
    SidebarItem(
      index: 2,
      icon: 'assets/svg/sidebar/menu.svg',
      text: 'Menu',
      route: SidebarRoute.menu,
    ),
    SidebarItem(
      index: 3,
      icon: 'assets/svg/sidebar/transactions.svg',
      text: 'Transactions',
      route: SidebarRoute.transactions,
    ),
    SidebarItem(
      index: 4,
      icon: 'assets/svg/sidebar/product.svg',
      text: 'Product',
      route: SidebarRoute.product,
      subItems: [
        SidebarItem(
          index: 1,
          parentIndex: 4,
          icon: 'assets/svg/sidebar/product.svg',
          text: 'Category',
          route: SidebarRoute.productCategory,
        ),
        SidebarItem(
          index: 2,
          parentIndex: 4,
          icon: 'assets/svg/sidebar/product.svg',
          text: 'Remove Menu',
          route: SidebarRoute.productCategory,
        ),
      ],
    ),
    SidebarItem(
      index: 5,
      icon: 'assets/svg/sidebar/report.svg',
      text: 'Report',
      route: SidebarRoute.report,
    ),
  ];

  static const List<SidebarItem> footerItems = [
    SidebarItem(
      index: -1,
      icon: 'assets/svg/sidebar/settings.svg',
      text: 'Settings',
      route: SidebarRoute.settings,
      isFooter: true,
    ),
    SidebarItem(
      index: -2,
      icon: 'assets/svg/sidebar/logout.svg',
      text: 'Logout',
      route: SidebarRoute.logout,
      isFooter: true,
    ),
  ];
}
