import 'package:erg/features/shared/models/roof/roof_utils_model.dart';

String? countryValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Fill the form.';
  }
  if (PLAINMANUFACTURER.getCountries.contains(value) == false) {
    return 'Fill the correct country.';
  }
  return null;
}

String? colorValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Fill the form.';
  }
  return null;
}
