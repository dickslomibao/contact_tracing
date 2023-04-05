import 'package:contact_tracing/constant/style.dart';
import 'package:contact_tracing/services/firebase_services.dart';
import 'package:contact_tracing/view/widgets/drop_down.dart';
import 'package:contact_tracing/view/widgets/elevated_btn.dart';
import 'package:contact_tracing/view_model/client_vmodel.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ClientProfile extends StatelessWidget {
  const ClientProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile',
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
      body: Padding(
        padding: const EdgeInsets.all(12.0),
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
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                'Personal Iformation',
                                textAlign: TextAlign.center,
                                style:
                                    Theme.of(context).textTheme.displayMedium,
                              ),
                              spacer(20),
                              Text(
                                'Firstname: ${value.data['firstname']}',
                                style:
                                    Theme.of(context).textTheme.displayMedium,
                              ),
                              spacer(10),
                              Text(
                                'Middlename: ${value.data['middlename']}',
                                style:
                                    Theme.of(context).textTheme.displayMedium,
                              ),
                              spacer(10),
                              Text(
                                'Lastname: ${value.data['lastname']}',
                                style:
                                    Theme.of(context).textTheme.displayMedium,
                              ),
                              spacer(10),
                              Text(
                                'Address: ${value.data['address']}',
                                style:
                                    Theme.of(context).textTheme.displayMedium,
                              ),
                              spacer(10),
                              Text(
                                'Birthdate: ${DateFormat.yMMMMd().format(DateTime.parse(value.data['birthdate']))}',
                                style:
                                    Theme.of(context).textTheme.displayMedium,
                              ),
                              spacer(10),
                            ],
                          ),
                        ),
                      ),
                      spacer(20),
                      ElevatedButtonWidget(
                        onPressed: () {
                          context.goNamed('clientUpdate',
                              queryParams: value.data);
                        },
                        label: 'Update information',
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
