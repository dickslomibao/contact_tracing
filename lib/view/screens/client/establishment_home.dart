import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class EstablishmentHome extends StatelessWidget {
 const EstablishmentHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton(
                onPressed: () async {
                  String qr = await FlutterBarcodeScanner.scanBarcode(
                      '#ffffff', 'Cancel', true, ScanMode.BARCODE);
                  if (qr != '-1') {
                   await FirebaseFirestore.instance.collection('logs').add({
                      'user_uid': qr,
                      'establishment_uid':
                          FirebaseAuth.instance.currentUser!.uid,
                      'date': DateTime.now(),
                    });
                    EasyLoading.showSuccess('Success');
                  }
                },
                child: const Text('Scan'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
