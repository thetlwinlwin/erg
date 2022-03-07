import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../api/customer/customer_api.dart';
import '../../managers/customer_manager.dart';
import '../../utils/constants.dart';
import '../shared/models/customers/customer_model.dart';
import '../shared/widget/widgets.dart';

class CustomerSearch extends StatefulWidget {
  const CustomerSearch({Key? key}) : super(key: key);

  @override
  State<CustomerSearch> createState() => _CustomerSearchState();
}

class _CustomerSearchState extends State<CustomerSearch> {
  late TextEditingController _searchController;
  bool loading = false;
  String? _selectedGender;

  @override
  void initState() {
    super.initState();

    _searchController = TextEditingController(text: '');
    _searchController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _searchRow(),
          // _searchText(),
          kPaddingBox,
          const Text(
            'example : "myint aye" or "0921312412" or "myint aye, 0921312412"',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
          kPaddingBox,
          Expanded(
            child: _futureBuilder(context),
          ),
        ],
      ),
    );
  }

  void _radioHandler(String? val) => setState(() => _selectedGender = val);

  Row _searchRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        GenderBuilder(
          radioHandler: _radioHandler,
          selectedGender: _selectedGender,
        ),
        kPaddingBox,
        Expanded(
          child: CustomTextField(
            controller: _searchController,
            hintText: 'Search Customer',
            textInputType: TextInputType.name,
            textInputAction: TextInputAction.search,
          ),
        ),
      ],
    );
  }

  Future<Response<List<CustomerOut>>> _customerSearch(String value) async {
    final int? isPhone = int.tryParse(value);
    Response<List<CustomerOut>> data = isPhone != null
        ? await Provider.of<ErgCustomerService>(context, listen: false)
            .searchCustomer(
            phone: value,
          )
        : await Provider.of<ErgCustomerService>(context, listen: false)
            .searchCustomer(
            name: value,
            gender: _selectedGender,
          );
    return data;
  }

  FutureBuilder _futureBuilder(BuildContext context) {
    return FutureBuilder<Response<List<CustomerOut>>>(
      future: _customerSearch(_searchController.text),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            // this error is for http call error.
            return Center(
              child: Text(snapshot.error.toString()),
            );
          } else {
            final retrivedCustomers = snapshot.data!.body;
            if (retrivedCustomers != null) {
              return _buildResultList(customerList: retrivedCustomers);
            } else if (retrivedCustomers == null) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(snapshot.data!.error.toString()),
                    kPaddingBox,
                    _customerCreate(
                      dataPass: CustomerDataPass(
                        value: _searchController.text,
                        gender: _selectedGender,
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return Center(
                child: _customerCreate(
                  dataPass: CustomerDataPass(
                    value: _searchController.text,
                    gender: _selectedGender,
                  ),
                ),
              );
            }
          }
        } else {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        }
      },
    );
  }

  ListView _buildResultList({
    required List<CustomerOut> customerList,
  }) {
    return ListView.separated(
      separatorBuilder: (context, index) => kPaddingBox,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            try {
              Provider.of<CustomerManager>(context, listen: false)
                  .saveCustomer(newCustomer: customerList[index]);
            } catch (e) {
              errorSnackBar(e.toString(), context);
            }
            context.goNamed('home');
          },
          child: Container(
            height: 50,
            color: Theme.of(context).colorScheme.secondary.withOpacity(0.7),
            child: Center(
              child: Text(customerList[index].address.toString()),
            ),
          ),
        );
      },
      itemCount: customerList.length,
    );
  }

  Widget _customerCreate({
    required CustomerDataPass dataPass,
  }) {
    return ElevatedButton(
        onPressed: () {
          context.goNamed(
            'customers_create',
            extra: dataPass,
          );
        },
        child: const Padding(
          padding: EdgeInsets.all(20),
          child: Text('Create New Customer'),
        ));
  }
}
