import 'package:flutter/cupertino.dart';

const List<String> availableItems = [
  'Hollow',
  'Deck Sheet',
  'C-Purlin',
  'Omega',
  'U beam',
  'H beam',
  'Color Roof'
];

class RouterPath {
  static const String authApiUrl = 'http://127.0.0.1:8000/manager';
  static const String customerBaseUrl = 'http://127.0.0.1:8000/customers';
}

const double maxGridItemExtent = 300.0;

String getProductPath({required String product}) {
  return 'assets/products/$product.png';
}

const SizedBox kPaddingBox = SizedBox(
  height: 10,
  width: 10,
);

String getLogoPath() {
  return 'assets/logo.png';
}

const List<String> genderList = [
  'male',
  'female',
];
