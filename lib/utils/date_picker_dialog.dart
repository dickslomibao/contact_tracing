import 'package:flutter/material.dart';

Future<DateTime?> datePicker(BuildContext ctx) async {
  return await showDatePicker(
    context: ctx,
    initialDate: DateTime.now(),
    firstDate: DateTime(1900),
    lastDate: DateTime(DateTime.now().year + 1),
  );
}
