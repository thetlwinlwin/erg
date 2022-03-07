import 'package:erg/features/auth/auth.dart';
import 'package:erg/features/auth/mobile_auth.dart';
import 'package:erg/features/customers/create_customer_screen.dart';
import 'package:erg/features/customers/customers_screen.dart';
import 'package:erg/features/home/home_screen.dart';
import 'package:erg/features/shared/models/customers/customer_model.dart';
import 'package:erg/features/splash/splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

class Routes {
  static final splash = GoRoute(
    path: '/splash',
    pageBuilder: (BuildContext context, GoRouterState state) {
      return SplashScreen.page(key: state.pageKey);
    },
  );
  static final login = GoRoute(
    path: '/login',
    pageBuilder: (BuildContext context, GoRouterState state) {
      return AuthScreen.page(
        mobileAuth: const MobileAuth(),
        desktopAuth: const MobileAuth(),
      );
    },
  );
  static final home = GoRoute(
    path: '/home',
    name: 'home',
    pageBuilder: (BuildContext context, GoRouterState state) {
      return HomeScreen.page();
    },
  );
  static final customerCreate = GoRoute(
    path: '/customers/create',
    name: 'customers_create',
    pageBuilder: (BuildContext context, GoRouterState state) {
      return CreateCustomerScreen.page(
        dataPass: state.extra as CustomerDataPass,
        key: state.pageKey,
      );
    },
  );
  static final customersSearch = GoRoute(
    path: '/customers/search',
    name: 'customers_search',
    pageBuilder: (BuildContext context, GoRouterState state) {
      return CustomersScreen.page();
    },
  );
}
