import 'package:contact_tracing/constant/style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class RegisterUser extends StatefulWidget {
  RegisterUser({super.key});

  @override
  State<RegisterUser> createState() => _RegisterUserState();
}

class _RegisterUserState extends State<RegisterUser> {
  final _formKey = GlobalKey<FormState>();
  bool showPassword = true;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void rigesterClient() async {
    // if(_formKey.currentState!.validate()){

    // }
    return;
    EasyLoading.show(status: 'Processing');
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: 'a25@gmail.com', password: '123456');
      print("registeed");
      EasyLoading.showSuccess('User account Created');
    } on FirebaseAuthException catch (e) {
      EasyLoading.dismiss();
      if (e.code == "email-already-in-use") {
        EasyLoading.showError("Email already used");
      }
      if (e.code == "weak-password") {
        EasyLoading.showError("Please enter a secure password");
      }
      print(e.code);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign up'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text("Register an account"),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: emailController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Email address is required";
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  labelText: "Email address",
                  border: OutlineInputBorder(),
                ),
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: passwordController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Password is required";
                  }
                  return null;
                },
                obscureText: showPassword,
                style: const TextStyle(
                  fontSize: 16,
                ),
                decoration: InputDecoration(
                  labelText: "Password",
                  suffixIcon: IconButton(
                    icon: Icon(
                        showPassword ? Icons.visibility : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        showPassword = !showPassword;
                      });
                    },
                  ),
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                obscureText: showPassword,
                style: const TextStyle(
                  fontSize: 16,
                ),
                decoration: const InputDecoration(
                  labelText: "Re-type Password",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  _formKey.currentState!.validate();
                },
                style: ElevatedButton.styleFrom(
                  shape: roundedBtn,
                ),
                child: const Padding(
                  padding: EdgeInsets.all(13.0),
                  child: Text("Register as client"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
