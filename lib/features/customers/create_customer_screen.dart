import 'package:chopper/chopper.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../api/customer/customer_api.dart';
import '../../utils/constants.dart';
import '../../managers/customer_manager.dart';
import '../shared/models/customers/customer_model.dart';
import '../shared/widget/widgets.dart';
import 'address_null_check.dart';

class CreateCustomerScreen extends StatefulWidget {
  static Page page({LocalKey? key, required CustomerDataPass dataPass}) =>
      MaterialPage<void>(
        key: key,
        child: CreateCustomerScreen(
          dataPass: dataPass,
        ),
      );
  final CustomerDataPass dataPass;

  const CreateCustomerScreen({
    Key? key,
    required this.dataPass,
  }) : super(key: key);

  @override
  State<CreateCustomerScreen> createState() => _CreateCustomerScreenState();
}

class _CreateCustomerScreenState extends State<CreateCustomerScreen> {
  late int? _phone;
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _addressController;
  String? _selectedGender;

  @override
  void initState() {
    _selectedGender = widget.dataPass.gender;
    _phone = int.tryParse(widget.dataPass.value);
    if (_phone != null) {
      _phoneController = TextEditingController(text: _phone.toString());
      _nameController = TextEditingController();
    } else {
      _nameController = TextEditingController(text: widget.dataPass.value);
      _phoneController = TextEditingController();
    }
    _addressController = TextEditingController();

    _nameController.addListener(() => setState(() {}));
    _phoneController.addListener(() => setState(() {}));
    _addressController.addListener(() => setState(() {}));

    super.initState();
  }

  void _radioHandler(String? val) => setState(() => _selectedGender = val);

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: _size.height * 0.2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GenderBuilder(
                  radioHandler: _radioHandler,
                  selectedGender: _selectedGender,
                ),
              ],
            ),
          ),
          SizedBox(
            width: _size.width * 0.7,
            child: CustomTextField(
              controller: _nameController,
              textInputType: TextInputType.name,
              hintText: 'Name',
              textInputAction: TextInputAction.next,
            ),
          ),
          kPaddingBox,
          SizedBox(
            width: _size.width * 0.7,
            child: CustomTextField(
              controller: _phoneController,
              textInputType: TextInputType.phone,
              hintText: 'Phone',
              textInputAction: TextInputAction.next,
            ),
          ),
          kPaddingBox,
          SizedBox(
            width: _size.width * 0.7,
            child: _addressTextField(context),
          ),
        ],
      ),
    );
  }

  TextField _addressTextField(BuildContext context) {
    return TextField(
      controller: _addressController,
      onSubmitted: (String val) {
        if (val.isEmpty) {
          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (_) => AddressNullCheck(
                    addressText: 'No Address?',
                    createCustomer: _createCustomer,
                    genderText: _selectedGender == null ? 'No gender?' : null,
                  ));
        } else {
          _createCustomer();
        }
      },
      decoration: InputDecoration(
        hintText: 'Address',
        suffixIcon: _addressController.text.isEmpty
            ? Container(width: 0)
            : IconButton(
                onPressed: () => _addressController.clear(),
                icon: const Icon(Icons.close),
              ),
      ),
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.streetAddress,
    );
  }

  void _createCustomer() async {
    final _newCustomer = CustomerCreate(
      name: _nameController.text,
      phone: _phoneController.text,
      gender: _selectedGender!,
      // if not check like this, address text will be '' <= like that.
      address: _addressController.text.isEmpty ? null : _addressController.text,
    );
    Response<CustomerOut> _customerReturn =
        await Provider.of<ErgCustomerService>(context, listen: false)
            .createCustomer(newCustomer: _newCustomer);

    if (_customerReturn.isSuccessful) {
      Provider.of<CustomerManager>(context, listen: false)
          .saveCustomer(newCustomer: _customerReturn.body!);
      context.goNamed('home');
    } else {
      errorSnackBar(_customerReturn.error.toString(), context);
    }
  }
}
