import 'package:erg/managers/customer_manager.dart';
import 'package:erg/navigation/routes.dart';
import 'package:go_router/go_router.dart';
import '../managers/app_state_manager.dart';

final GoRouter goRouter = GoRouter(
    initialLocation: Routes.splash.path,
    routes: [
      Routes.splash,
      Routes.login,
      Routes.customersSearch,
      Routes.customerCreate,
      Routes.home,
    ],
    urlPathStrategy: UrlPathStrategy.path,
    refreshListenable: appStateManager,
    redirect: (GoRouterState state) {
      if (!appStateManager.isInitialized) {
        if (state.subloc != Routes.splash.path) {
          return Routes.splash.path;
        }
      }
      if (state.subloc == Routes.splash.path && appStateManager.isInitialized) {
        if (appStateManager.isLoggedIn) {
          if (customerManager.isThereSavedCustomer) {
            return Routes.home.path;
          } else {
            return Routes.customersSearch.path;
          }
        } else if (appStateManager.isLoggedIn == false) {
          return Routes.login.path;
        }
      }
      if (appStateManager.isLoggedIn && state.subloc == Routes.login.path) {
        if (customerManager.isThereSavedCustomer) {
          return Routes.home.path;
        } else {
          return Routes.customersSearch.path;
        }
      }
      return null;
    });
