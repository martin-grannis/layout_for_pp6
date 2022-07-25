extension ExtString on String {
  bool get isValidEmail {
    final emailRegExp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return emailRegExp.hasMatch(this);
  }

  bool get isValidName {
    final nameRegExp =
        RegExp(r"^\s*([A-Za-z]{1,}([\.,] |[-']| ))+[A-Za-z]+\.?\s*$");
    return nameRegExp.hasMatch(this);
  }

  bool get isValidPassword {
    return isNotEmpty;
    
    // final passwordRegExp = RegExp(
    //     r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\><*~]).{8,}/pre>');
    // return passwordRegExp.hasMatch(this);
  }

   bool get isRequired {
    // ignore: unnecessary_null_comparison
    return this.isNotEmpty;
  }

  bool get isNotNull {
    // ignore: unnecessary_null_comparison
    return this != null;
  }

    bool get isNotNumeric {
        final phoneRegExp = RegExp(r"^[0-9]+$");
    return phoneRegExp.hasMatch(this);
  }

  bool get isValidPhone {
    final phoneRegExp = RegExp(r"^\+?0[0-9]{10}$");
    return phoneRegExp.hasMatch(this);
  }

  bool get isValidIP {
    final IP_RegExp = RegExp(r"(((0|1)?[0-9][0-9]?|2[0-4][0-9]|25[0-5])[.]){3}((0|1)?[0-9][0-9]?|2[0-4][0-9]|25[0-5])$");
    return IP_RegExp.hasMatch(this);
  }
}
