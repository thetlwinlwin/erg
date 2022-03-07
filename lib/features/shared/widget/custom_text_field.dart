import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final TextInputType textInputType;
  final TextInputAction textInputAction;
  const CustomTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.textInputType,
    required this.textInputAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onSubmitted: (String value) {
        if (value.isNotEmpty) {
          FocusScope.of(context).nextFocus();
        }
      },
      decoration: InputDecoration(
        hintText: hintText,
        suffixIcon: controller.text.isEmpty
            ? Container(width: 0)
            : IconButton(
                onPressed: () => controller.clear(),
                icon: const Icon(Icons.close),
              ),
      ),
      textInputAction: textInputAction,
      keyboardType: textInputType,
    );
  }
}
