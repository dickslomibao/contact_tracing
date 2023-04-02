import 'package:contact_tracing/constant/style.dart';
import 'package:flutter/material.dart';

void dialogProccess({
  required BuildContext context,
  bool dismissible = true,
  required String label,
}) {
  showDialog(
    barrierDismissible: dismissible,
    context: context,
    builder: (context) => AlertDialog(
      content: Text(
        label,
        style: const TextStyle(
          fontSize: 18,
          color: txtColor,
        ),
      ),
    ),
  );
}
