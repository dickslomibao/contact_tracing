import 'package:contact_tracing/constant/style.dart';
import 'package:contact_tracing/services/firebase_services.dart';
import 'package:contact_tracing/utils/date_picker_dialog.dart';
import 'package:contact_tracing/utils/show_dialog_process.dart';
import 'package:contact_tracing/view/widgets/drop_down.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class EstablishmentHome extends StatelessWidget {
  const EstablishmentHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          String status = "Invalid qr code.";
          String qr = await FlutterBarcodeScanner.scanBarcode(
              '#ffffff', 'Cancel', true, ScanMode.BARCODE);
          if (qr != '-1') {
            if (await FirebaseService.uidIsValid(qr)) {
              await FirebaseService.storeLogs(qr);
              status = "Success...";
            }
            if (context.mounted) {
              dialogProccess(
                context: context,
                label: status,
                dismissible: true,
              );
            }
          }
        },
        child: const Icon(
          Icons.qr_code_scanner,
          color: Colors.white,
          size: 30,
        ),
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'iContact',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          DropDownWidget(
            onChange: (value) async {
              if (value == 'logout') {
                await FirebaseService.logout();
                if (context.mounted) {
                  context.goNamed('home');
                }
              } else {
                context.goNamed('establismentProfle');
              }
            },
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton(
                onPressed: () async {
                  final date = await datePicker(
                    context,
                  );
                  if (context.mounted) {
                    if (date != null) {
                      context.goNamed(
                        'establishmentData',
                        queryParams: {
                          'date': DateFormat('yyyy-MM-dd').format(date)
                        },
                      );
                    }
                  }
                },
                child: const Text(
                  'Filter data',
                  style: btnTxtStyle,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
