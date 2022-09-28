import 'package:flutter/material.dart';
import '../../shared/widget/custom_text_form_field.dart';
import 'validators.dart';

List<CustomTextFormField> roofOrderTextFields({
  required TextEditingController colorController,
  required TextEditingController countryController,
  required FocusNode colorNode,
}) {
  return [
    CustomTextFormField(
      validator: countryValidator,
      controller: countryController,
      labelText: 'coil ထုပ်လုပ်သည့်နိုင်ငံ',
      inputType: TextInputType.text,
      inputAction: TextInputAction.next,
      callBack: () {
        colorNode.requestFocus();
      },
    ),
    CustomTextFormField(
      node: colorNode,
      validator: colorValidator,
      controller: colorController,
      labelText: 'အရောင်',
      inputType: TextInputType.text,
      inputAction: TextInputAction.done,
      callBack: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
    )
  ];
}
