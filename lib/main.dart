import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:erg/api/auth/auth_api.dart';
import 'package:erg/managers/app_state_manager.dart';
import 'package:erg/managers/customer_manager.dart';
import 'package:erg/managers/listener_manager.dart';
import 'package:erg/navigation/router.dart';
import 'package:erg/repository/local_persistence.dart';

import './utils/theme.dart';

late ListenerManager listenerManager;
late CustomerManager customerManager;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  _setupLogging();
  final sharedPref = await SharedPreferences.getInstance();
  final LocalPersist dataPersist = LocalPersist(sharedPref);
  listenerManager = ListenerManager(dataPersist);
  customerManager = CustomerManager(persistence: dataPersist);
  runApp(MyApp(
    localPersist: dataPersist,
  ));
}

void _setupLogging() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((event) {
    print('${event.level.name}:${event.time}:${event.message}');
  });
}

class MyApp extends StatefulWidget {
  final LocalPersist localPersist;
  const MyApp({
    Key? key,
    required this.localPersist,
  }) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late AppStateManager _appStateManager;
  @override
  void initState() {
    _appStateManager = AppStateManager(persist: widget.localPersist);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: _appStateManager),
        Provider.value(value: listenerManager),
        Provider.value(value: customerManager),
        Provider<AppRouter>(
          create: (_) => AppRouter(_appStateManager),
        ),
        Provider(
          create: (_) => ErgAuthService.create(),
          dispose: (_, ErgAuthService service) => service.client.dispose(),
        ),
      ],
      builder: (context, child) {
        final goRouter = Provider.of<AppRouter>(context, listen: false).router;
        return MaterialApp.router(
          theme: ErgTheme.light(),
          darkTheme: ErgTheme.dark(),
          themeMode: ThemeMode.system,
          debugShowCheckedModeBanner: false,
          routeInformationParser: goRouter.routeInformationParser,
          routerDelegate: goRouter.routerDelegate,
        );
      },
    );
  }
}
