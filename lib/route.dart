import 'package:contact_tracing/services/firebase_services.dart';
import 'package:contact_tracing/view/screens/client/client_home.dart';
import 'package:contact_tracing/view/screens/client/client_profile.dart';
import 'package:contact_tracing/view/screens/client/client_update_info.dart';
import 'package:contact_tracing/view/screens/establishment/establishment_data_screen.dart';
import 'package:contact_tracing/view/screens/establishment/establishment_home.dart';
import 'package:contact_tracing/view/screens/establishment/establishment_profile.dart';
import 'package:contact_tracing/view/screens/establishment/establishment_update_info.dart';
import 'package:contact_tracing/view/screens/home.dart';
import 'package:contact_tracing/view/screens/client/register_client.dart';
import 'package:contact_tracing/view/screens/establishment/register_establishment.dart';
import 'package:contact_tracing/view/screens/user_login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      name: 'home',
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return StreamBuilder<User?>(
          stream: FirebaseService.authChange(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
            if (snapshot.data?.uid == null) {
              return const HomeScreen();
            }

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
                }
                return const EstablishmentHome();
              },
            );
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
          routes: [
            GoRoute(
              path: 'profile',
              name: 'clientProfile',
              builder: (BuildContext context, GoRouterState state) {
                return const ClientProfile();
              },
              routes: [
                GoRoute(
                  path: 'update',
                  name: 'clientUpdate',
                  builder: (BuildContext context, GoRouterState state) {
                    return ClientUpdateInfoScreen(
                      client: state.queryParams,
                    );
                  },
                ),
              ],
            ),
          ],
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
          routes: [
            GoRoute(
              path: 'profile',
              name: 'establismentProfle',
              builder: (BuildContext context, GoRouterState state) {
                return const EstablishmentProfile();
              },
              routes: [
                GoRoute(
                  path: 'update',
                  name: 'establishmentUpdate',
                  builder: (BuildContext context, GoRouterState state) {
                    return EstablishmentUpadteInfoScreen(
                      establishment: state.queryParams,
                    );
                  },
                ),
              ],
            ),
            GoRoute(
              name: 'establishmentData',
              path: 'datascreen',
              builder: (BuildContext context, GoRouterState state) {
                return EstablishmentDataScreen(
                    date: state.queryParams['date'] ?? "");
              },
            ),
          ],
        ),
      ],
    ),
  ],
);
