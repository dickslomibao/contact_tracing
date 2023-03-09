import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Contact Trace",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text(
                "A contact tracking app for students of Mobile app",
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(
                height: 12.0,
              ),
              Text(
                "Welcome! Please login or sign up.",
                style: Theme.of(context).textTheme.displayMedium,
              ),
              const SizedBox(
                height: 20.0,
              ),
              ElevatedButton(
                onPressed: () {},
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text("Login"),
                ),
              ),
              const SizedBox(
                height: 12.0,
              ),
              ElevatedButton(
                onPressed: () {},
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text("Sign up"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
