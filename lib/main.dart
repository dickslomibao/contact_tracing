import 'package:contact_tracing/constant/style.dart';
import 'package:contact_tracing/firebase_options.dart';
import 'package:contact_tracing/view/screens/home.dart';
import 'package:contact_tracing/view/screens/register_client.dart';
import 'package:contact_tracing/view/screens/user_login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:go_router/go_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final GoRouter _router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return HomeScreen();
        },
        routes: <RouteBase>[
           GoRoute(
            path: 'login',
            builder: (BuildContext context, GoRouterState state) {
              return const LoginScren();
            },
          ),
          GoRoute(
            path: 'registerClient',
            builder: (BuildContext context, GoRouterState state) {
              return const RegisterClient();
            },
          ),
        ],
      ),
    ],
  );
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: GoogleFonts.montserrat().fontFamily,
        primarySwatch: primaryColor,
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            fontSize: 35,
            fontWeight: FontWeight.w900,
            color: mainColor,
          ),
          titleSmall: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: Color.fromRGBO(0, 0, 0, .7),
          ),
          displayMedium: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Color.fromRGBO(0, 0, 0, .6),
          ),
        ),
        appBarTheme: const AppBarTheme(),
      ),
      routerConfig: _router,
      builder: EasyLoading.init(),
    );
  }
}
