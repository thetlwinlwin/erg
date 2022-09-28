import 'package:erg/managers/app_state_manager.dart';
import 'package:erg/managers/customer_manager.dart';
import 'package:erg/managers/listener_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../utils/constants.dart';
import './custom_tile.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  static Page page({LocalKey? key}) => MaterialPage<void>(
        child: const HomeScreen(),
        key: key,
      );

  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(slivers: [
        SliverAppBar(
          actions: [
            IconButton(
                icon: const Icon(Icons.logout_sharp),
                onPressed: () {
                  Provider.of<ListenerManager>(context, listen: false)
                      .removeToken();
                  Provider.of<AppStateManager>(context, listen: false).logout();
                  Provider.of<CustomerManager>(context, listen: false)
                      .deleteCustomer();
                }),
            IconButton(
                icon: const Icon(Icons.cancel_outlined),
                onPressed: () {
                  Provider.of<CustomerManager>(context, listen: false)
                      .deleteCustomer();
                  context.goNamed('customers_search');
                }),
          ],
          floating: true,
          snap: true,
          title: Text(Provider.of<CustomerManager>(context, listen: false)
              .customerName!),
        ),
        SliverPadding(
          padding: const EdgeInsets.all(20),
          sliver: SliverGrid.extent(
            maxCrossAxisExtent: maxGridItemExtent,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            children: availableItems
                .map(
                  (String product) => CustomTile(
                    callbackFunction: () {
                      context.goNamed(product);
                    },
                    imageLocation: getProductPath(product: product),
                    imageText: product,
                  ),
                )
                .toList(),
          ),
        ),
      ]),
    );
  }
}
