import 'package:contact_tracing/model/establishment.dart';
import 'package:contact_tracing/services/firebase_services.dart';

class EstablishmentViewModel {
  static Future<String> createAccount(Establishment esta) async {
    return FirebaseService.createAccount(esta);
  }
  static Future<Map<String, dynamic>?> getData() async {
    return FirebaseService.getClientData();
  }
}