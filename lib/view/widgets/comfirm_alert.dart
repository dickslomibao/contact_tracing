import 'package:contact_tracing/constant/style.dart';
import 'package:contact_tracing/view/widgets/elevated_btn.dart';
import 'package:contact_tracing/view/widgets/outline_btn.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ComfirmAlert extends StatelessWidget {
  ComfirmAlert({super.key, required this.onYes, required this.onCancel});
  Function onYes;
  Function onCancel;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Comfirm Registration',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
      ),
      content: SingleChildScrollView(
        child: SizedBox(
          width: 280,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Are you sure to create an account?',
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
            ],
          ),
        ),
      ),
      actionsPadding: const EdgeInsets.only(bottom: 20, right: 20, left: 20),
      actions: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButtonWidget(
                onPressed: () {
                  onYes();
                },
                label: 'Yes'),
            spacer(10),
            OutlineBtnWidget(
                label: 'No',
                onPressed: () {
                  onCancel();
                })
          ],
        )
      ],
    );
    
  }
}
