import 'package:erg/managers/app_state_manager.dart';
import 'package:erg/managers/customer_manager.dart';
import 'package:erg/managers/listener_manager.dart';
import 'package:provider/provider.dart';

import '../../utils/constants.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  static Page page({LocalKey? key}) => MaterialPage<void>(
        child: const SplashScreen(),
        key: key,
      );

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    );
    onStartUp();
    _controller.forward();
  }

  void onStartUp() async {
    final isLoggedIn =
        Provider.of<ListenerManager>(context, listen: false).isManagerDataThere;
    final anyCustomer = Provider.of<CustomerManager>(context, listen: false)
        .isThereSavedCustomer;
    await Provider.of<AppStateManager>(context, listen: false).onAppStart(
      isLoggedIn: isLoggedIn,
      anyCustomer: anyCustomer,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FadeTransition(
        opacity: CurvedAnimation(curve: Curves.easeIn, parent: _controller),
        child: Center(
          child: Hero(
            tag: 'logo',
            child: Image.asset(
              getLogoPath(),
              height: 400,
              width: 400,
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
    );
  }
}
