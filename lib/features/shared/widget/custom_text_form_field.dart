import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode? node;
  final String labelText;
  final TextInputType inputType;
  final TextInputAction inputAction;
  final String? Function(String?)? validator;
  final VoidCallback? callBack;

  const CustomTextFormField({
    Key? key,
    required this.controller,
    required this.labelText,
    required this.inputType,
    required this.inputAction,
    required this.validator,
    this.callBack,
    this.node,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        focusNode: node,
        onFieldSubmitted: (value) {
          if (callBack != null) {
            callBack!();
          } else {
            _onFieldSubimtted(value, context);
          }
        },
        validator: validator,
        controller: controller,
        textInputAction: inputAction,
        keyboardType: inputType,
        decoration: InputDecoration(
          labelText: labelText,
          suffixIcon: controller.text.isEmpty
              ? Container(width: 0)
              : IconButton(
                  onPressed: () => controller.clear(),
                  icon: const Icon(Icons.close),
                ),
        ),
      ),
    );
  }

  void _onFieldSubimtted(String? _, BuildContext context) {
    FocusScope.of(context).nextFocus();
  }
}
