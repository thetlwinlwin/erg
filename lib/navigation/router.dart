import 'package:erg/navigation/routes.dart';
import 'package:go_router/go_router.dart';
import '../managers/app_state_manager.dart';

class AppRouter {
  late final AppStateManager _appStateManager;
  GoRouter get router => _goRouter;
  AppRouter(this._appStateManager);
  late final GoRouter _goRouter = GoRouter(
      initialLocation: Routes.splash.path,
      routes: [
        Routes.splash,
        Routes.login,
        Routes.customersSearch,
        Routes.customerCreate,
        Routes.home,
      ],
      urlPathStrategy: UrlPathStrategy.path,
      refreshListenable: _appStateManager,
      redirect: (GoRouterState state) {
        if (!_appStateManager.isInitialized) {
          if (state.subloc != Routes.splash.path) {
            return Routes.splash.path;
          }
        }
        if (state.subloc == Routes.splash.path &&
            _appStateManager.isInitialized) {
          if (_appStateManager.isLoggedIn) {
            if (_appStateManager.anySavedCustomer) {
              return Routes.home.path;
            } else {
              return Routes.customersSearch.path;
            }
          } else if (_appStateManager.isLoggedIn == false) {
            return Routes.login.path;
          }
        }
        if (_appStateManager.isLoggedIn && state.subloc == Routes.login.path) {
          if (_appStateManager.anySavedCustomer) {
            return Routes.home.path;
          } else {
            return Routes.customersSearch.path;
          }
        }
        return null;
      });
}
