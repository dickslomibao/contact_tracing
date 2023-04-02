import 'package:contact_tracing/services/firebase_services.dart';
import 'package:contact_tracing/view/screens/client/client_home.dart';
import 'package:contact_tracing/view/screens/establishment/establishment_home.dart';
import 'package:contact_tracing/view/screens/home.dart';
import 'package:contact_tracing/view/screens/client/register_client.dart';
import 'package:contact_tracing/view/screens/establishment/register_establishment.dart';
import 'package:contact_tracing/view/screens/user_login.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return StreamBuilder(
          stream: FirebaseService.authChange(),
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return const HomeScreen();
            } else {
              return FutureBuilder(
                future: FirebaseService.getClientData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Scaffold(
                      body: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  if (snapshot.data!['type'] == 'client') {
                    return const ClientHome();
                  } else {
                    return const EstablishmentHome();
                  }
                },
              );
            }
          },
        );
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
        GoRoute(
          path: 'clientHome',
          builder: (BuildContext context, GoRouterState state) {
            return const ClientHome();
          },
        ),
        GoRoute(
          path: 'registerEstablisment',
          builder: (BuildContext context, GoRouterState state) {
            return const RegistersEstablishment();
          },
        ),
        GoRoute(
          path: 'establishmentHome',
          builder: (BuildContext context, GoRouterState state) {
            return const EstablishmentHome();
          },
        ),
      ],
    ),
  ],
);
