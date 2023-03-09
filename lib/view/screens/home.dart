import 'package:contact_tracing/view/screens/register_client.dart';
import 'package:contact_tracing/view/screens/register_establishment.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final roundedBtn = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(20),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(40.0),
          // decoration: BoxDecoration(
          //   image: DecorationImage(
          //     image: AssetImage('assets/images/bg1.jpg'),
          //   ),
          // ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Contact Trace",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(
                height: 5.0,
              ),
              Text(
                "A contact tracking app for students of Mobile Application Development 2",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(
                height: 30.0,
              ),
              Text(
                "Welcome! Please login or sign up.",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.displayMedium,
              ),
              const SizedBox(
                height: 20.0,
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  shape: roundedBtn,
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text("Login"),
                ),
              ),
              const SizedBox(
                height: 12.0,
              ),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  shape: roundedBtn,
                ),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => RegisterUser(),
                    ),
                  );
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text("Sign up as Client"),
                ),
              ),
              const SizedBox(
                height: 12.0,
              ),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  shape: roundedBtn,
                ),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => RegisterEstablishment(),
                    ),
                  );
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text("Sign up as Establishment"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
