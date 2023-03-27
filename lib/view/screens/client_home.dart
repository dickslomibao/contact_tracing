import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ClientHome extends StatelessWidget {
  ClientHome({super.key, required this.uuid});
  String uuid;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: QrImage(
          data: uuid,
        ),
      ),
    );
  }
}
