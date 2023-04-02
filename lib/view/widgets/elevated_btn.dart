import 'package:contact_tracing/constant/style.dart';
import 'package:flutter/material.dart';

class ElevatedButtonWidget extends StatelessWidget {
 const ElevatedButtonWidget(
      {super.key, required this.onPressed, required this.label});
  final Function onPressed;
  final String label;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        onPressed();
      },
      style: ElevatedButton.styleFrom(
        shape: roundedBtn,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14),
        child: Text(
          label,
          style: btnTxtStyle,
        ),
      ),
    );
  }
}
