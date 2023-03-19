import 'package:contact_tracing/constant/style.dart';
import 'package:contact_tracing/view/widgets/elevated_btn.dart';
import 'package:contact_tracing/view/widgets/txt_form_field.dart';
import 'package:contact_tracing/view/widgets/txt_form_field_password.dart';
import 'package:contact_tracing/view_model/validator.dart';
import 'package:email_validator/email_validator.dart';
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
  TextEditingController comfirmPasswordController = TextEditingController();

  void rigesterClient() async {
    if (_formKey.currentState!.validate()) {
      EasyLoading.show(status: 'Processing');
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        emailController.text = "";
        passwordController.text = "";
        comfirmPasswordController.text = "";
        EasyLoading.showSuccess('User account Created');
      } on FirebaseAuthException catch (e) {
        EasyLoading.dismiss();
        if (e.code == "email-already-in-use") {
          EasyLoading.showError("Email already used");
        }
        if (e.code == "weak-password") {
          EasyLoading.showError("Please enter a secure password");
        }
      }
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
      body: Container(
        decoration: backgroundCover,
        child: Center(
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
                        return Validator.validateEmail(value);
                      },
                      label: 'Email Addresss',
                    ),
                    spacer(10),
                    TxtFormPasswordWidget(
                      controller: passwordController,
                      label: 'Password',
                      obscure: showPassword,
                      suffixOnpressed: () {
                        setState(() {
                          showPassword = !showPassword;
                        });
                      },
                      validator: (value) {
                        return Validator.validatePassword(value);
                      },
                    ),
                    spacer(10),
                    TxtFormPasswordWidget(
                      controller: comfirmPasswordController,
                      label: 'Re-type password',
                      suffixOnpressed: () {},
                      validator: (value) {
                        return Validator.validateComfirmPassword(
                            value, passwordController.text);
                      },
                    ),
                    spacer(20),
                    ElevatedButtonWidget(
                      onPressed: () {
                        rigesterClient();
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
