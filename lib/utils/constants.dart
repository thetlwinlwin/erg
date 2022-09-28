import 'package:flutter/cupertino.dart';

const List<String> availableItems = [
  'Hollow',
  'Deck Sheet',
  'C Channel',
  'Omega',
  'U beam',
  'H beam',
  'Roof'
];

class ProudctStageValues {
  static const String pending = 'pending';
  static const String producing = 'producing';
  static const String done = 'done';

  static const List<String> valueList = ['pending', 'producing', 'done'];
}

class RouterPath {
  static const String authApiUrl = 'http://192.168.100.4:8000/manager';
  static const String customerBaseUrl = 'http://192.168.100.4:8000/customers';
  static const String dsOrderBaseUrl = 'http://192.168.100.4:8000/ds';
  static const String roofOrderBaseUrl = 'http://192.168.100.4:8000/roof';
  static const String cchannelOrderBaseUrl =
      'http://192.168.100.4:8000/cchannel';
}

class BasicMMText {
  static const String totalSheets = 'အချပ်ရေ';
  static const String sheetPerLength = 'အရှည်';
  static const String thickness = 'အထူအပါး';
  static const String notes = 'မှတ်ချက်';
  static const String productionStage = 'ထုပ်လုပ်မှု့အခြေအနေ';
  static const String pickUpTime = 'order အပ်ရမည့်ရက်';
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

Iterable<int> kGrades = {0, 40, 60, 80, 100, 120};

const Duration allowablepickupDays = Duration(days: 60);

bool kThicknessValidate(double value) => value >= 0.6 && value <= 2.0;
