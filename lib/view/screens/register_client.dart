import 'package:contact_tracing/constant/style.dart';
import 'package:contact_tracing/view/widgets/elevated_btn.dart';
import 'package:contact_tracing/view/widgets/txt_form_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class RegisterClient extends StatefulWidget {
  const RegisterClient({super.key});

  @override
  State<RegisterClient> createState() => _RegisterClientState();
}

class _RegisterClientState extends State<RegisterClient> {
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
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Color.fromRGBO(0, 0, 0, .7),
          size: 30,
        ),
      ),
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: backgroundCover,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      "iContact",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Image.asset('assets/images/img-home1.png'),
                    Text(
                      "Create an account",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                    spacer(20),
                    TextFormFieldWidget(
                      controller: emailController,
                      validator: (value) {
                        print(value);
                        if (value == null || value.isEmpty) {
                          return "Email address is required";
                        }
                        return null;
                      },
                      label: 'Email Addresss',
                    ),
                    spacer(10),
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
                          icon: Icon(showPassword
                              ? Icons.visibility
                              : Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              showPassword = !showPassword;
                            });
                          },
                        ),
                        border: const OutlineInputBorder(),
                      ),
                    ),
                    spacer(10),
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
                    spacer(20),
                    ElevatedButtonWidget(
                      onPressed: () {
                        _formKey.currentState!.validate();
                      },
                      label: 'Sign up as client',
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
