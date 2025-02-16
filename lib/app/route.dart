import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:possystem/features/dashboard/views/dashboardPageMain.dart';
import 'package:possystem/features/logout/views/logout.dart';
import 'package:possystem/features/menu/entryPage/views/entryPageMain.dart';
import 'package:possystem/features/menu/membershipPage/views/membershipPageMain.dart';
import 'package:possystem/features/menu/processPage/views/processPageMain.dart';
import 'package:possystem/features/menu/receiptPage/views/receiptPageMain.dart';
import 'package:possystem/features/menu/selectionPage/views/selectionPageMain.dart';
import 'package:possystem/features/plain.dart';
import 'package:possystem/features/product/category/views/categoryPageMain.dart';
import 'package:possystem/features/setting/settingPageMain.dart';
import 'package:possystem/features/constant/sidebar/views/sideAppBar.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/dashboard',
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        return ScaffoldWithNavBar(child: child);
      },
      routes: [
        GoRoute(
          path: '/dashboard',
          pageBuilder: (context, state) {
            return _buildPageTransition(
              DashboardPageMain(),
            );
          },
        ),
        GoRoute(
          path: '/menu',
          pageBuilder: (context, state) {
            return _buildPageTransition(
              EntryPageMain(),
            );
          },
          routes: [
            GoRoute(
              path: 'productpicker',
              pageBuilder: (context, state) {
                return _buildPageTransition(
                  SelectionPageMain(
                    isConfirmation: false,
                  ),
                );
              },
              routes: [
                GoRoute(
                  path: 'process',
                  pageBuilder: (context, state) {
                    return _buildPageTransition(
                      ProcessPageMain(
                        isMembership: true,
                        isPayment: false,
                        isSuccesful: false,
                        type: 'membership',
                      ),
                    );
                  },
                  routes: [
                    GoRoute(
                      path: 'membership',
                      pageBuilder: (context, state) {
                        return _buildPageTransition(
                          MembershipPageMain(),
                        );
                      },
                      routes: [
                        GoRoute(
                          path: 'confirmationCart',
                          pageBuilder: (context, state) {
                            return _buildPageTransition(
                              SelectionPageMain(
                                isConfirmation: true,
                              ),
                            );
                          },
                          routes: [
                            GoRoute(
                                path: 'processQr',
                                pageBuilder: (context, state) {
                                  return _buildPageTransition(
                                    ProcessPageMain(
                                      isMembership: false,
                                      isPayment: true,
                                      isSuccesful: false,
                                      type: 'qr',
                                    ),
                                  );
                                },
                                routes: [
                                  GoRoute(
                                    path: 'processSuccessful',
                                    pageBuilder: (context, state) {
                                      return _buildPageTransition(
                                        ProcessPageMain(
                                          isMembership: false,
                                          isPayment: false,
                                          isSuccesful: true,
                                          type: 'success',
                                        ),
                                      );
                                    },
                                  ),
                                ]),
                            GoRoute(
                                path: 'processCard',
                                pageBuilder: (context, state) {
                                  return _buildPageTransition(
                                    ProcessPageMain(
                                      isMembership: false,
                                      isPayment: false,
                                      isSuccesful: true,
                                      type: 'processing',
                                    ),
                                  );
                                },
                                routes: [
                                  GoRoute(
                                    path: 'receipt',
                                    pageBuilder: (context, state) {
                                      return _buildPageTransition(
                                        ReceiptPageMain(),
                                      );
                                    },
                                  )
                                ]),
                            GoRoute(
                                path: 'processCash',
                                pageBuilder: (context, state) {
                                  return _buildPageTransition(
                                    ProcessPageMain(
                                      isMembership: false,
                                      isPayment: true,
                                      isSuccesful: false,
                                      type: 'cash',
                                    ),
                                  );
                                },
                                routes: [
                                  GoRoute(
                                    path: 'processSuccessful',
                                    pageBuilder: (context, state) {
                                      return _buildPageTransition(
                                        ProcessPageMain(
                                          isMembership: false,
                                          isPayment: false,
                                          isSuccesful: true,
                                          type: 'success',
                                        ),
                                      );
                                    },
                                  ),
                                ]),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        GoRoute(
          path: '/transactions',
          pageBuilder: (context, state) {
            return _buildPageTransition(
              DashboardPageMain(),
            );
          },
        ),
        GoRoute(
            path: '/product',
            pageBuilder: (context, state) {
              return _buildPageTransition(
                PlainPage(),
              );
            },
            routes: [
              GoRoute(
                path: 'category',
                pageBuilder: (context, state) {
                  return _buildPageTransition(
                    CategoryPageMain(),
                  );
                },
              ),
            ]),
        GoRoute(
          path: '/report',
          pageBuilder: (context, state) {
            return _buildPageTransition(
              DashboardPageMain(),
            );
          },
        ),
        GoRoute(
          path: '/settings',
          pageBuilder: (context, state) {
            return _buildPageTransition(
              SettingPageMain(),
            );
          },
        ),
        GoRoute(
          path: '/logout',
          pageBuilder: (context, state) {
            return _buildPageTransition(
              LogoutPage(),
            );
          },
        ),
      ],
    ),
  ],
);

Page _buildPageTransition(Widget child) {
  return CustomTransitionPage(
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.easeInOut;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      var offsetAnimation = animation.drive(tween);

      return SlideTransition(position: offsetAnimation, child: child);
    },
  );
}
