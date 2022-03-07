import 'package:erg/managers/app_state_manager.dart';
import 'package:erg/repository/local_persistence.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    // getRead();
    _controller.forward();

    appStateManager.initializeApp();
  }

  // void getRead() async {
  //   final dataString = await rootBundle.loadString('assets/gg.json');

  //   List<DSOrderFetchModel> orderList = (json.decode(dataString) as List)
  //       .map((i) => DSOrderFetchModel.fromJson(i))
  //       .toList();
  //   print(orderList[0].detail.isProductionDone);
  // }

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
