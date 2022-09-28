import '../../../../utils/constants.dart';

String? lengthValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Fill the form.';
  }
  final double? doubleValue = double.tryParse(value);
  if (doubleValue == null) {
    return 'Fill with only numbers.';
  }
  return null;
}

String? thicknessValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Fill the form.';
  }
  final double? doubleValue = double.tryParse(value);
  if (doubleValue == null) {
    return 'Fill with only numbers.';
  }
  if (!kThicknessValidate(doubleValue)) {
    return 'Fill with correct numbers.';
  }
  return null;
}

String? notesValidator(String? value) {
  return null;
}

String? gradeValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Fill the form.';
  }
  final int? intValue = int.tryParse(value);
  if (intValue == null) {
    return 'Fill with only numbers.';
  }
  if (kGrades.contains(intValue) == false) {
    return 'Fill with correct numbers.';
  }
  return null;
}

String? totalSheetsValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Fill the form.';
  }
  final int? intValue = int.tryParse(value);
  if (intValue == null) {
    return 'Fill with only numbers.';
  }
  return null;
}
