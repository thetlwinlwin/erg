import 'package:flutter/material.dart';

import '../../shared/models/base_model/base_validator.dart';
import '../../shared/widget/custom_text_form_field.dart';
import 'validators.dart';

List<CustomTextFormField> dsOrderTextFields({
  required TextEditingController dsDepthController,
  required TextEditingController gradeController,
  required FocusNode dpNode,
}) {
  return [
    CustomTextFormField(
      validator: gradeValidator,
      controller: gradeController,
      labelText: 'Zinc (0, 40, 60, 80, 120)',
      inputType: TextInputType.number,
      inputAction: TextInputAction.next,
      callBack: () {
        dpNode.requestFocus();
      },
    ),
    CustomTextFormField(
      node: dpNode,
      validator: dsDepthValidator,
      controller: dsDepthController,
      labelText: 'DSအခုံး အမြင့်',
      inputType: TextInputType.number,
      inputAction: TextInputAction.done,
      callBack: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
    )
  ];
}
