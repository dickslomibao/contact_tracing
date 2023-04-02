import 'package:flutter/material.dart';

class DateField extends StatelessWidget {
  const DateField(
      {super.key,
      required this.controller,
      required this.label,
      required this.onTap});
 final dynamic controller;
  final String label;
  final Function onTap;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: const TextStyle(
        fontSize: 16,
      ),
      decoration: InputDecoration(
        label: Text(label),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.00),
        ),
      ),
      readOnly: true,
      onTap: () {
        onTap();
      },
    );
  }
}
