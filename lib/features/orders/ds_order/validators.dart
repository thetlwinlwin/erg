Iterable<double> kDsDepth = {1.5, 2, 3};

String? dsDepthValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Fill the form.';
  }
  final double? doubleValue = double.tryParse(value);
  if (doubleValue == null) {
    return 'Fill with only numbers.';
  }
  if (kDsDepth.contains(doubleValue) == false) {
    return 'Fill with correct numbers.';
  }
  return null;
}
