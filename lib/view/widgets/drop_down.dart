import 'package:contact_tracing/constant/style.dart';
import 'package:flutter/material.dart';

class DropDownWidget extends StatelessWidget {
  const DropDownWidget({super.key, required this.onChange});
  final Function onChange;
  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton(
        elevation: 0,
        icon: const Icon(Icons.more_vert),
        items: const [
          DropdownMenuItem(
            value: 'logout',
            child: Text(
              'Logout',
              style: TextStyle(
                fontSize: 16,
                color: txtColor,
              ),
            ),
          ),
          DropdownMenuItem(
            value: 'account',
            child: Text(
              'Profie',
              style: TextStyle(
                fontSize: 16,
                color: txtColor,
              ),
            ),
          ),
        ],
        onChanged: (value) async {
          await onChange(value);
        },
      ),
    );
  }
}
