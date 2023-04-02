import 'package:contact_tracing/constant/style.dart';
import 'package:contact_tracing/view_model/client_vmodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

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
          DropdownButtonHideUnderline(
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
              onChanged: (value) {
                if (value == "logout") {
                  FirebaseAuth.instance.signOut();
                }
              },
            ),
          )
        ],
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: ClientViewModel.getData(),
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
                    "Hi, ${snapshot.data!['firstname']} ${snapshot.data!['lastname']}",
                    style: const TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  spacer(20),
                  QrImage(
                    data: snapshot.data!['uid'],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
