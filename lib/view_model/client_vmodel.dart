import 'package:contact_tracing/model/client.dart';
import 'package:contact_tracing/services/firebase_services.dart';

class ClientViewModel {

  static Future<String> createAccount(Client client) async {
    return FirebaseService.createAccount(client);
  }

  static Future<Map<String, dynamic>?> getData() async {
    return FirebaseService.getClientData();
  }
}
