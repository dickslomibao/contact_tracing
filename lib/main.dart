import 'package:contact_tracing/firebase_options.dart';
import 'package:contact_tracing/view/screens/home.dart';
import 'package:contact_tracing/view/screens/user_login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: GoogleFonts.montserrat().fontFamily,
        primarySwatch: Colors.deepPurple,
        textTheme: const TextTheme(
          titleMedium: TextStyle(
            fontSize: 35,
            fontWeight: FontWeight.w900,
            color: Colors.deepPurple,
          ),
          titleSmall: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: Colors.black45,
          ),
          displayMedium: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Colors.black45,
          ),
        ),
        appBarTheme: AppBarTheme(),
      ),
      home: HomeScreen(),
      builder: EasyLoading.init(),
    );
  }
}
