import 'package:contact_tracing/constant/style.dart';
import 'package:contact_tracing/utils/show_dialog_process.dart';
import 'package:contact_tracing/view/widgets/date_picker_field.dart';
import 'package:contact_tracing/view/widgets/elevated_btn.dart';
import 'package:contact_tracing/view/widgets/txt_form_field.dart';
import 'package:contact_tracing/view_model/client_vmodel.dart';
import 'package:contact_tracing/view_model/validator.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ClientUpdateInfoScreen extends StatefulWidget {
  const ClientUpdateInfoScreen({super.key, required this.client});
  final Map<String, dynamic> client;
  @override
  State<ClientUpdateInfoScreen> createState() => _ClientUpdateInfoScreenState();
}

class _ClientUpdateInfoScreenState extends State<ClientUpdateInfoScreen> {
  final _formKey = GlobalKey<FormState>();
  bool showPassword = true;
  TextEditingController firstnameController = TextEditingController();
  TextEditingController middlenameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController birthdateController = TextEditingController();

  @override
  void initState() {
    
    super.initState();
    firstnameController.text = widget.client['firstname'];
    middlenameController.text = widget.client['middlename'];
    lastnameController.text = widget.client['lastname'];
    addressController.text = widget.client['address'];
    birthdateController.text = widget.client['birthdate'];
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ClientProvider>(context);

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
                      "Update Information",
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
                            firstDate: DateTime(1900),
                            lastDate: DateTime(DateTime.now().year + 1));
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
                    ElevatedButtonWidget(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          dialogProccess(
                            context: context,
                            label: 'Updating...',
                            dismissible: false,
                          );
                          provider.udpateData({
                            'firstname': firstnameController.text,
                            'middlename': middlenameController.text,
                            'lastname': lastnameController.text,
                            'address': addressController.text,
                            'birthdate': birthdateController.text,
                          });
                          if (context.mounted) {
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                          }
                        }
                      },
                      label: 'Save',
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
