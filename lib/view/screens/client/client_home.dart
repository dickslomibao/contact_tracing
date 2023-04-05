import 'package:contact_tracing/constant/style.dart';
import 'package:contact_tracing/services/firebase_services.dart';
import 'package:contact_tracing/view/widgets/drop_down.dart';
import 'package:contact_tracing/view_model/client_vmodel.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:provider/provider.dart';

class ClientHome extends StatelessWidget {
  const ClientHome({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                context.goNamed('clientProfile');
              }
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Consumer<ClientProvider>(
          builder: (context, value, child) {
            return FutureBuilder(
              future: value.fetchData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    children: [
                      Text(
                        "Hi, ${value.data['firstname']} ${value.data['lastname']}",
                        style: const TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      spacer(20),
                      QrImage(
                        data: value.data['uid'],
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
