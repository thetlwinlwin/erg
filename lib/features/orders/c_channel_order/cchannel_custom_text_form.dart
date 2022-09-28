import 'package:flutter/material.dart';

import '../../shared/models/base_model/base_validator.dart';
import '../../shared/widget/custom_text_form_field.dart';
import 'validators.dart';

// TODO:: if we build others order screen. we need to write as follow. that's why it is comment out.
List cChannelOrderTextFields({
  required TextEditingController heightController,
  required TextEditingController widthController,
  required TextEditingController gradeController,
  required FocusNode widthFocus,
  required FocusNode gradeFocus,
}) {
  return [
    CustomTextFormField(
      validator: channelHeightValidator,
      controller: heightController,
      labelText: 'Height (inches)',
      inputType: TextInputType.number,
      inputAction: TextInputAction.next,
      callBack: () {
        widthFocus.requestFocus();
      },
    ),
    CustomTextFormField(
      node: widthFocus,
      validator: channelWidthValidator,
      controller: widthController,
      labelText: 'Width (inches)',
      inputType: TextInputType.number,
      inputAction: TextInputAction.next,
      callBack: () {
        gradeFocus.requestFocus();
      },
    ),
    CustomTextFormField(
      node: gradeFocus,
      validator: gradeValidator,
      controller: gradeController,
      labelText: 'Zinc (0, 40, 60, 80, 120)',
      inputType: TextInputType.number,
      inputAction: TextInputAction.done,
      callBack: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
    ),
  ];
}
