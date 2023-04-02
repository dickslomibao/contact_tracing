import 'package:contact_tracing/constant/style.dart';
import 'package:contact_tracing/model/client.dart';
import 'package:contact_tracing/utils/show_dialog_process.dart';
import 'package:contact_tracing/view/widgets/comfirm_alert.dart';
import 'package:contact_tracing/view/widgets/date_picker_field.dart';
import 'package:contact_tracing/view/widgets/elevated_btn.dart';
import 'package:contact_tracing/view/widgets/txt_form_field.dart';
import 'package:contact_tracing/view/widgets/txt_form_field_password.dart';
import 'package:contact_tracing/view_model/client_vmodel.dart';
import 'package:contact_tracing/view_model/validator.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class RegisterClient extends StatefulWidget {
  const RegisterClient({super.key});

  @override
  State<RegisterClient> createState() => _RegisterClientState();
}

class _RegisterClientState extends State<RegisterClient> {
  final _formKey = GlobalKey<FormState>();
  bool showPassword = true;
  TextEditingController firstnameController = TextEditingController();
  TextEditingController middlenameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController birthdateController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController comfirmPasswordController = TextEditingController();

  void rigesterClient() {
    if (_formKey.currentState!.validate()) {
      showDialog(
        context: context,
        builder: (_) {
          return ComfirmAlert(
            onCancel: () {},
            onYes: () async {
              Navigator.of(context).pop();
              dialogProccess(
                context: context,
                label: 'Creating account...',
                dismissible: false,
              );
              String status = await ClientViewModel.createAccount(
                Client(
                  firstname: firstnameController.text,
                  middlename: middlenameController.text,
                  lastname: lastnameController.text,
                  address: addressController.text,
                  birthdate: birthdateController.text,
                  email: emailController.text,
                  password: passwordController.text,
                ),
              );
              if (context.mounted) {
                Navigator.of(context).pop();
                if (status == 'success') {
                  context.go('/');
                } else {
                  dialogProccess(
                    context: context,
                    label: status,
                    dismissible: false,
                  );
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
        title: const Text(
          'iContact',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
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
                    const Text(
                      "Create an account",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 27,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    spacer(30),
                    const Text(
                      'Peronal Information',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: txtColor,
                      ),
                    ),
                    spacer(20),
                    TextFormFieldWidget(
                      controller: firstnameController,
                      validator: (value) {
                        return Validator.validateName(
                            value, 'Firstname is required');
                      },
                      label: 'Firstname',
                    ),
                    spacer(10),
                    TextFormFieldWidget(
                      controller: middlenameController,
                      validator: (value) {
                        return Validator.validateName(
                            value, 'Middlename is required');
                      },
                      label: 'Middlename',
                    ),
                    spacer(10),
                    TextFormFieldWidget(
                      controller: lastnameController,
                      validator: (value) {
                        return Validator.validateName(
                            value, 'Lastname is required');
                      },
                      label: 'Lastname',
                    ),
                    spacer(10),
                    TextFormFieldWidget(
                      controller: addressController,
                      validator: (value) {
                        return Validator.validateAddress(value);
                      },
                      label: 'Address',
                    ),
                    spacer(10),
                    DateField(
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2101));
                        if (pickedDate != null) {
                          setState(() {
                            birthdateController.text =
                                DateFormat('yyyy-MM-dd').format(pickedDate);
                          });
                        }
                      },
                      label: 'Birthdate',
                      controller: birthdateController,
                    ),
                    spacer(20),
                    const Text(
                      'Account Credentials',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: txtColor,
                      ),
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
                      isPassword: false,
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
                      label: 'Sign up',
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
