import 'package:flutter/material.dart';

class TxtFormPasswordWidget extends StatelessWidget {
 const TxtFormPasswordWidget(
      {super.key,
      required this.controller,
      this.obscure = true,
      required this.suffixOnpressed,
      required this.validator,
      required this.label,
      this.isPassword = true});
  final TextEditingController controller;
 final bool obscure;
 final Function suffixOnpressed;
 final Function validator;
 final String label;
 final bool isPassword;
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
        labelText: label,
        suffixIcon: Visibility(
          visible: isPassword,
          child: IconButton(
            icon: Icon(obscure ? Icons.visibility_off : Icons.visibility),
            onPressed: () {
              suffixOnpressed();
            },
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
