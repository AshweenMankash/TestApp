class Validator {
  static String validateMobile(String value) {
    String pattern = r'(^[0-9]*$)';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return "Enter Phone Number";
    } else if (!regExp.hasMatch(value)) {
      return "Phone Number can only be digits";
    } else if (value.length != 10) {
      return "Phone Number Must be of 10 Digits";
    }

    return null;
  }
}
