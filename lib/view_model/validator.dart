import 'package:email_validator/email_validator.dart';

class Validator {
  static dynamic validateEmail(value) {
    if (value == null || value.isEmpty) {
      return "Email address is required";
    }
    if (!EmailValidator.validate(value)) {
      return "Please enter a valid email address";
    }
    return null;
  }

  static dynamic validatePassword(value) {
    if (value == null || value.isEmpty) {
      return "Password is required";
    }
    if (value.length < 6) {
      return "Password should be more than 6 characters";
    }
    return null;
  }

  static dynamic validateComfirmPassword(value, password) {
    if (value == null || value.isEmpty) {
      return "Re-type password is required";
    }
    if (value != password) {
      return "Password didn't match";
    }
    return null;
  }
}
