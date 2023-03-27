import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatelessWidget {
  TextFormFieldWidget({
    super.key,
    required this.controller,
    required this.validator,
    required this.label,
    required this.icon,
  });
  TextEditingController controller;
  Function validator;
  String label;
  Icon icon;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: (value) {
        return validator(value);
      },
      decoration: InputDecoration(
        prefixIcon: icon,
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      style: const TextStyle(
        fontSize: 16,
      ),
    );
  }
}
