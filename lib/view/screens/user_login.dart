import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UserLogin extends StatelessWidget {
  const UserLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: SafeArea(
        child: Column(
          children: [
            Text(
              "Login",
              style: GoogleFonts.poppins(
                fontSize: 23,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
