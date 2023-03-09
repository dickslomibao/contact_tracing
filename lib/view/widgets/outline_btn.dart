import 'package:contact_tracing/constant/style.dart';
import 'package:flutter/material.dart';

class OutlineBtnWidget extends StatelessWidget {
  OutlineBtnWidget({
    Key? key,
    required this.label,
    required this.onPressed,
  });
  Function onPressed;
  String label;
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: outlineBtnStyle,
      onPressed: () {
        onPressed();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14),
        child: Text(
          label,
          style: outlineBtnTxtStyle,
        ),
      ),
    );
  }
}
