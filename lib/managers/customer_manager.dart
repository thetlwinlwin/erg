import 'package:erg/features/shared/models/customers/customer_model.dart';
import 'package:erg/managers/persistencekeys.dart';

import '../repository/local_persistence.dart';

// class CustomerManager {
//   int? _id;
//   String? _name;

//   late Persistence _persistence;

//   int? get customerId => _id;
//   String? get customerName => _name;

//   // bool get isThereSavedCustomer => _id != null;

// //TODO: We have to specify context.go everytime we alter something.
//   CustomerManager() {
//     _readFromPersistence();
//   }

//   void _readFromPersistence() async {
//     _persistence = await getSharedPref();
//     _id = int.tryParse(_persistence.getKey(PersistenceKeys.customerIdKey)!);
//     _name = _persistence.getKey(PersistenceKeys.customerNameKey);
//   }

//   void saveCustomer({required CustomerOut newCustomer}) async {
//     _id = newCustomer.id;
//     print('id is now $_id');
//     _name = newCustomer.name;
//     _persistence.setKey(
//         PersistenceKeys.customerIdKey, newCustomer.id.toString());
//     _persistence.setKey(PersistenceKeys.customerNameKey, newCustomer.name);
//   }

//   void deleteCustomer() async {
//     _id = null;
//     _name = null;

//     _persistence.removeKey(PersistenceKeys.customerIdKey);
//     _persistence.removeKey(PersistenceKeys.customerNameKey);
//   }
// }

class CustomerManager {
  int? _id;
  String? _name;
  String? _phone;
  String? _address;
  late LocalPersist persistence;
  CustomerManager({
    required this.persistence,
  }) {
    loadCustomer();
  }

  int? get customerId => _id;
  String? get customerName => _name;
  String? get customerPhone => _phone;
  String? get customerAddress => _address;
  bool get isThereSavedCustomer => _id != null;

//TODO: We have to specify context.go everytime we alter something.

  void loadCustomer() async {
    final customerId = persistence.getKey(PrefKeys.customerIdKey);
    if (customerId != null) {
      _id = int.tryParse(customerId);
    }
    _name = persistence.getKey(PrefKeys.customerNameKey);
    _address = persistence.getKey(PrefKeys.customerAddressKey);
    _phone = persistence.getKey(PrefKeys.customerPhoneKey);
  }

  Future<bool> saveCustomer({required CustomerOut newCustomer}) async {
    _id = newCustomer.id;
    _name = newCustomer.name;
    _phone = newCustomer.phone;
    if (newCustomer.address != null) {
      _address = newCustomer.address;
      persistence.setKey(PrefKeys.customerAddressKey, newCustomer.address!);
    }

    persistence.setKey(PrefKeys.customerIdKey, newCustomer.id.toString());
    persistence.setKey(PrefKeys.customerNameKey, newCustomer.name);
    persistence.setKey(PrefKeys.customerPhoneKey, newCustomer.phone);

    return true;
  }

  void deleteCustomer() async {
    _id = null;
    _name = null;
    _phone = null;
    _address = null;
    persistence.removeKey(PrefKeys.customerIdKey);
    persistence.removeKey(PrefKeys.customerNameKey);
    persistence.removeKey(PrefKeys.customerPhoneKey);
    persistence.removeKey(PrefKeys.customerAddressKey);
  }
}
