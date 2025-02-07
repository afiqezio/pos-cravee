enum SidebarRoute {
  dashboard,
  menu,
  transactions,
  product,
  productCategory,
  report,
  settings,
  logout,
}

class SidebarItem {
  final int index;
  final String icon;
  final String text;
  final SidebarRoute route;
  final List<SidebarItem>? subItems;
  final bool isFooter;
  final int? parentIndex;

  const SidebarItem({
    required this.index,
    required this.icon,
    required this.text,
    required this.route,
    this.subItems,
    this.isFooter = false,
    this.parentIndex,
  });

  String get routePath {
    switch (route) {
      case SidebarRoute.dashboard:
        return '/dashboard';
      case SidebarRoute.menu:
        return '/menu';
      case SidebarRoute.transactions:
        return '/transactions';
      case SidebarRoute.product:
        return '/product';
      case SidebarRoute.productCategory:
        return '/product/category';
      case SidebarRoute.report:
        return '/report';
      case SidebarRoute.settings:
        return '/settings';
      case SidebarRoute.logout:
        return '/logout';
    }
  }

  // Helper method to get unique index for items
  int get uniqueIndex => parentIndex != null
      ? (parentIndex! * 100) + index // Subitems: parentIndex * 100 + subIndex
      : index;
}
