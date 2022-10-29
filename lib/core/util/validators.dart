import '../index.dart';

class Validator {
  static bool isValidPassword(String password) => password.length > 3;

  static String? validateTestName(String? val) {
    if (val!.trim().isEmpty) {
      return Strings.message.kEnterTestName;
    } else {
      return null;
    }
  }
}
