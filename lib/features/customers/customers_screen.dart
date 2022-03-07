import 'package:flutter/material.dart';

import 'customer_search.dart';

class CustomersScreen extends StatelessWidget {
  static Page page({LocalKey? key}) => MaterialPage(
        child: const CustomersScreen(),
        key: key,
      );

  const CustomersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20),
        child: CustomerSearch(),
      ),
    );
  }
}
