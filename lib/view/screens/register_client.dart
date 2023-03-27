import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contact_tracing/constant/style.dart';
import 'package:contact_tracing/view/widgets/comfirm_alert.dart';
import 'package:contact_tracing/view/widgets/elevated_btn.dart';
import 'package:contact_tracing/view/widgets/outline_btn.dart';
import 'package:contact_tracing/view/widgets/txt_form_field.dart';
import 'package:contact_tracing/view/widgets/txt_form_field_password.dart';
import 'package:contact_tracing/view_model/validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:roundcheckbox/roundcheckbox.dart';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:quickalert/quickalert.dart';

class RegisterClient extends StatefulWidget {
  const RegisterClient({super.key});

  @override
  State<RegisterClient> createState() => _RegisterClientState();
}

class _RegisterClientState extends State<RegisterClient> {
  final _formKey = GlobalKey<FormState>();
  bool showPassword = true;
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController comfirmPasswordController = TextEditingController();
  final collectionPath = "users";
  @override
  void rigesterClient() async {
    if (_formKey.currentState!.validate()) {
      showDialog(
        context: context,
        builder: (_) {
          return ComfirmAlert(
            onCancel: () {},
            onYes: () async {
              Navigator.of(context).pop();
              showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context) => const AlertDialog(
                  content: Text('Creating...'),
                ),
              );
              try {
                UserCredential userCredential =
                    await FirebaseAuth.instance.createUserWithEmailAndPassword(
                  email: emailController.text,
                  password: passwordController.text,
                );
                if (userCredential.user == null) {
                  throw FirebaseAuthException(code: 'null-user-credential');
                }
                String uid = userCredential.user!.uid;
                await FirebaseFirestore.instance
                    .collection(collectionPath)
                    .doc(uid)
                    .set(
                  {
                    'name': nameController.text,
                    'address': addressController.text,
                    'type': 'client',
                  },
                );
                nameController.text = "";
                addressController.text = "";
                emailController.text = "";
                passwordController.text = "";
                comfirmPasswordController.text = "";
                if (context.mounted) {
                  Navigator.of(context).pop();
                  showDialog(
                    context: context,
                    builder: (context) => const AlertDialog(
                      content: Text('Success'),
                    ),
                  );
                }
              } on FirebaseAuthException catch (e) {
                EasyLoading.dismiss();
                if (e.code == "email-already-in-use") {
                  EasyLoading.showError("Email already used");
                  return;
                }
                if (e.code == "weak-password") {
                  EasyLoading.showError("Please enter a secure password");
                  return;
                }
                if (e.code == 'null-user-credential') {
                  EasyLoading.showError(
                      'An error occured while creating your account. Please try again');
                  return;
                }
              }
            },
          );
        },
      );
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
              padding: const EdgeInsets.all(24.0),
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
                    spacer(40),
                    Text(
                      "Create an account",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                    spacer(20),
                    TextFormFieldWidget(
                      icon: const Icon(Icons.person_2_outlined),
                      controller: nameController,
                      validator: (value) {
                        return Validator.validateName(value);
                      },
                      label: 'Name',
                    ),
                    spacer(10),
                    TextFormFieldWidget(
                      icon: const Icon(Icons.location_on_outlined),
                      controller: addressController,
                      validator: (value) {
                        return Validator.validateAddress(value);
                      },
                      label: 'Address',
                    ),
                    spacer(10),
                    TextFormFieldWidget(
                      icon: const Icon(Icons.email_outlined),
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
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: RoundCheckBox(
                              checkedWidget: const Icon(
                                Icons.check_outlined,
                                color: Colors.white,
                                size: 18,
                              ),
                              size: 20,
                              onTap: (selected) {},
                            ),
                          ),
                          const Text(
                            'I agree with the terms of conditons.',
                            style: TextStyle(
                              fontSize: 15,
                              color: txtColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
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
