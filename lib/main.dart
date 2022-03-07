import 'package:erg/api/auth/auth_api.dart';
import 'package:erg/api/customer/customer_api.dart';
import 'package:erg/managers/app_state_manager.dart';
import 'package:erg/managers/customer_manager.dart';
import 'package:erg/navigation/router.dart';

import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './utils/theme.dart';
import 'repository/data_contract.dart';
import 'repository/persistence_model.dart';

late LocalPersist<String> persistence;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final _pref = await SharedPreferences.getInstance();
  persistence = LocalPersist<String>(
    pref: _pref,
    keyList: PersistenceKeys.listOfKeys,
  );
  persistence.ready();
  _setupLogging();
  runApp(const MyApp());
}

void _setupLogging() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((event) {
    print('${event.level.name}:${event.time}:${event.message}');
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: appStateManager),
        Provider.value(value: persistence),
        Provider.value(value: customerManager),
        Provider(
          create: (_) => ErgAuthService.create(),
          dispose: (_, ErgAuthService service) => service.client.dispose(),
        ),
        Provider(
          create: (_) =>
              ErgCustomerService.create(tokenPayload: appStateManager.bearer),
          dispose: (_, ErgCustomerService service) => service.client.dispose(),
        ),
      ],
      child: MaterialApp.router(
        theme: ErgTheme.light(),
        darkTheme: ErgTheme.dark(),
        themeMode: ThemeMode.system,
        debugShowCheckedModeBanner: false,
        routeInformationParser: goRouter.routeInformationParser,
        routerDelegate: goRouter.routerDelegate,
      ),
    );
  }
}
