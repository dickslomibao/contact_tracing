import 'package:contact_tracing/constant/style.dart';
import 'package:contact_tracing/services/firebase_services.dart';
import 'package:contact_tracing/view/widgets/drop_down.dart';
import 'package:contact_tracing/view/widgets/elevated_btn.dart';
import 'package:contact_tracing/view_model/establishment_vmode.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class EstablishmentProfile extends StatelessWidget {
  const EstablishmentProfile({super.key});

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
                context.goNamed('establismentProfle');
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Consumer<EstablishmentProvider>(
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
                                'Establishment Iformation',
                                textAlign: TextAlign.center,
                                style:
                                    Theme.of(context).textTheme.displayMedium,
                              ),
                              spacer(20),
                              Text(
                                'Name: ${value.data['name']}',
                                style:
                                    Theme.of(context).textTheme.displayMedium,
                              ),
                              spacer(10),
                              Text(
                                'Contact Person: ${value.data['contactPerson']}',
                                style:
                                    Theme.of(context).textTheme.displayMedium,
                              ),
                              spacer(10),
                              Text(
                                'Addess: ${value.data['address']}',
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
                          context.goNamed('establishmentUpdate',
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
