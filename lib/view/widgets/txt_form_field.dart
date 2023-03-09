import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatelessWidget {
  TextFormFieldWidget({
    super.key,
    required this.controller,
    required this.validator,
    required this.label,
  });
  TextEditingController controller;
  Function validator;
  String label;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: (value) {
        return validator(value);
      },
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.email_outlined),
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      style: const TextStyle(
        fontSize: 16,
      ),
    );
  }
}
