bool _kWidthValidate(double value) => value >= 1 && value <= 8;
bool _kHeightValidate(double value) => value >= 1 && value <= 3;

String? channelHeightValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Fill the form.';
  }
  final double? doubleValue = double.tryParse(value);
  if (doubleValue == null) {
    return 'Fill with only numbers.';
  }
  if (_kHeightValidate(doubleValue) == false) {
    return 'Fill with correct numbers.';
  }
  return null;
}

String? channelWidthValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Fill the form.';
  }
  final double? doubleValue = double.tryParse(value);
  if (doubleValue == null) {
    return 'Fill with only numbers.';
  }
  if (_kWidthValidate(doubleValue) == false) {
    return 'Fill with correct numbers.';
  }
  return null;
}
