import 'package:contact_tracing/view/widgets/elevated_btn.dart';
import 'package:flutter/material.dart';
import 'package:contact_tracing/constant/style.dart';
import 'package:go_router/go_router.dart';
import 'package:contact_tracing/view/widgets/outline_btn.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width - 100;
    return Scaffold(
      backgroundColor: whiteColor,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(40.0),
          decoration: backgroundCover,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "iContact",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  spacer(10),
                  Text(
                    "A contact tracking app for students of\nMobile Application Development 2",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  spacer(30),
                  Image.asset('assets/images/img-home1.png'),
                  spacer(10),
                  Text(
                    "Welcome! Please login or sign up.",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  spacer(20),
                  ElevatedButtonWidget(
                    onPressed: () {
                      context.go('/login');
                    },
                    label: 'Login',
                  ),
                  spacer(20),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        height: 3,
                        color: const Color.fromRGBO(0, 0, 0, .15),
                        width: screenWidth / 3,
                      ),
                      const Text(
                        'OR',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Color.fromRGBO(0, 0, 0, .7),
                        ),
                      ),
                      Container(
                        height: 3,
                        color: const Color.fromRGBO(0, 0, 0, .15),
                        width: screenWidth / 3,
                      ),
                    ],
                  ),
                  spacer(20),
                  OutlineBtnWidget(
                    label: 'Sign up as Client',
                    onPressed: () {
                      context.go('/registerClient');
                    },
                  ),
                  spacer(12),
                  OutlineBtnWidget(
                    label: 'Sign up as Establishement',
                    onPressed: () {
                      context.go('/registerEstablisment');
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
