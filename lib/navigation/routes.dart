import 'package:erg/features/auth/auth.dart';
import 'package:erg/features/auth/mobile_auth.dart';
import 'package:erg/features/customers/create_customer_screen.dart';
import 'package:erg/features/customers/customers_screen.dart';
import 'package:erg/features/home/home_screen.dart';
import 'package:erg/features/orders/c_channel_order/cchannel_order_screen.dart';
import 'package:erg/features/orders/ds_order/ds_order_screen.dart';
import 'package:erg/features/orders/roof_order/roof_order_screen.dart';
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
    name: 'Home',
    pageBuilder: (BuildContext context, GoRouterState state) {
      return HomeScreen.page();
    },
    routes: [
      GoRoute(
        path: 'ds/orders/create',
        name: 'Deck Sheet',
        pageBuilder: (BuildContext context, GoRouterState state) =>
            DsOrderScreen.page(key: state.pageKey),
      ),
      GoRoute(
        path: 'cchannel/orders/create',
        name: 'C Channel',
        pageBuilder: (BuildContext context, GoRouterState state) =>
            CChannelOrderScreen.page(key: state.pageKey),
      ),
      GoRoute(
        path: 'roof/orders/create',
        name: 'Roof',
        pageBuilder: (BuildContext context, GoRouterState state) =>
            RoofOrderScreen.page(key: state.pageKey),
      ),
    ],
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
      return CustomersScreen.page(key: state.pageKey);
    },
  );
}
