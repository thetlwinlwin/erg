import 'package:flutter/material.dart';

class AuthScreen extends StatelessWidget {
  static Page page(
          {LocalKey? key, required mobileAuth, required desktopAuth}) =>
      MaterialPage<void>(
        key: key,
        child: AuthScreen(
          mobileAuth: mobileAuth,
          desktopAuth: desktopAuth,
        ),
      );

  final Widget mobileAuth;
  final Widget desktopAuth;
  const AuthScreen({
    Key? key,
    required this.mobileAuth,
    required this.desktopAuth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 600) {
            return mobileAuth;
          } else {
            return desktopAuth;
          }
        },
      ),
    );
  }
}
