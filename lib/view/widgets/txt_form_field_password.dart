import 'package:flutter/material.dart';

class TxtFormPasswordWidget extends StatelessWidget {
  TxtFormPasswordWidget(
      {super.key,
      required this.controller,
      this.obscure = true,
      required this.suffixOnpressed,
      required this.validator,
      required this.label});
  TextEditingController controller;
  bool obscure;
  Function suffixOnpressed;
  Function validator;
  String label;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: (value) {
        return validator(value);
      },
      obscureText: obscure,
      style: const TextStyle(
        fontSize: 16,
      ),
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.key_outlined),
        labelText: label,
        suffixIcon: IconButton(
          icon: Icon(obscure ? Icons.visibility : Icons.visibility_off),
          onPressed: () {
            suffixOnpressed();
          },
        ),
        border: const OutlineInputBorder(),
      ),
    );
  }
}
