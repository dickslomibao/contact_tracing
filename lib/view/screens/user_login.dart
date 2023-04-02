import 'package:contact_tracing/constant/style.dart';
import 'package:contact_tracing/services/firebase_services.dart';
import 'package:contact_tracing/utils/show_dialog_process.dart';
import 'package:contact_tracing/view/widgets/elevated_btn.dart';
import 'package:contact_tracing/view/widgets/txt_form_field.dart';
import 'package:contact_tracing/view/widgets/txt_form_field_password.dart';
import 'package:contact_tracing/view_model/validator.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginScren extends StatefulWidget {
  const LoginScren({super.key});

  @override
  State<LoginScren> createState() => _LoginScrenState();
}

class _LoginScrenState extends State<LoginScren> {
  final _formKey = GlobalKey<FormState>();
  bool showPassword = true;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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
                    spacer(20),
                    Text(
                      "iContact",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Image.asset('assets/images/img-home1.png'),
                    Text(
                      "Sign in",
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
                      suffixOnpressed: () {
                        setState(() {
                          showPassword = !showPassword;
                        });
                      },
                      controller: passwordController,
                      label: 'Password',
                      validator: (value) {
                        return Validator.validatePassword(value);
                      },
                      obscure: showPassword,
                    ),
                    spacer(20),
                    ElevatedButtonWidget(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          dialogProccess(
                            context: context,
                            label: 'Processing...',
                            dismissible: false,
                          );
                          String status = await FirebaseService.loginAccount(
                              email: emailController.text,
                              password: passwordController.text);

                          if (context.mounted) {
                            Navigator.pop(context);
                            if (status == "success") {
                              context.go('/');
                              return;
                            }
                            dialogProccess(
                              context: context,
                              label: status,
                            );
                          }
                        }
                      },
                      label: 'Login',
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
