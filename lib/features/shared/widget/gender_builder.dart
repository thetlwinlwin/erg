import 'package:erg/utils/constants.dart';
import 'package:flutter/material.dart';

class GenderBuilder extends StatelessWidget {
  final Function(String?) radioHandler;
  final String? selectedGender;
  const GenderBuilder({
    Key? key,
    required this.radioHandler,
    this.selectedGender,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ...genderList.map((String e) {
          return Row(
            children: [
              Column(
                children: [
                  Text(e),
                  kPaddingBox,
                  Radio(
                    value: e,
                    groupValue: selectedGender,
                    onChanged: radioHandler,
                  ),
                ],
              ),
              kPaddingBox,
            ],
          );
        }).toList(),
      ],
    );
  }
}
