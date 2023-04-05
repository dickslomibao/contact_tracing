import 'package:contact_tracing/model/client.dart';
import 'package:contact_tracing/services/firebase_services.dart';
import 'package:flutter/material.dart';

class ClientProvider extends ChangeNotifier {
  Map<String, dynamic> data = {};
  static Future<String> createAccount(Client client) async {
    return FirebaseService.createAccount(client);
  }

  Future<void> fetchData() async {
    data = (await FirebaseService.getClientData())!;
  }

  Future<void> udpateData(Map<String, dynamic> data) async {
    await FirebaseService.updateIformation(data);
    notifyListeners();
  }

  Map<String, dynamic> get clientData => data;
}
