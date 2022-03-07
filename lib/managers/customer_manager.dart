import 'package:erg/features/shared/models/customers/customer_model.dart';

import '../repository/local_persistence.dart';

class CustomerManager {
  late int? _id;
  late String? _name;
  late Persistence _persistence;
  static const String _customerIdKey = 'customer_id';
  static const String _customerNameKey = 'customer_name';

  bool get isThereSavedCustomer => _id != null;
  int? get customerId => _id;
  String? get customerName => _name;

//TODO: We have to specify context.go everytime we alter something.
  CustomerManager() {
    _readFromPersistence();
  }

  void _readFromPersistence() async {
    _persistence = await getSharedPref();
    _id = _persistence.getIntKey(_customerIdKey);
    _name = _persistence.getKey(_customerNameKey);
  }

  void saveCustomer({required CustomerOut newCustomer}) async {
    _id = newCustomer.id;
    _name = newCustomer.name;
    _persistence.setIntKey(_customerIdKey, newCustomer.id);
    _persistence.setKey(_customerNameKey, newCustomer.name);
  }

  void deleteCustomer() async {
    _id = null;
    _name = null;
    _persistence.removeKey(_customerIdKey);
    _persistence.removeKey(_customerNameKey);
  }
}

CustomerManager customerManager = CustomerManager();
