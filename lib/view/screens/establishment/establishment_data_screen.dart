import 'package:contact_tracing/services/firebase_services.dart';
import 'package:contact_tracing/view/widgets/drop_down.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class EstablishmentDataScreen extends StatelessWidget {
  const EstablishmentDataScreen({super.key, required this.date});
  final String date;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          DateFormat.yMMMMd().format(DateTime.parse(date)),
          style: const TextStyle(
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
      body: Padding(
        padding: const EdgeInsets.all(14.00),
        child: FutureBuilder(
          future: FirebaseService.getLogs(date),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.data!.isEmpty) {
              return const Center(
                child: Text(
                  'No data',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              );
            }
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text(
                      snapshot.data![index]['client_name'],
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Text(
                      snapshot.data![index]['user_uid'],
                    ),
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
