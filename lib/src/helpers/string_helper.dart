
bool isValidEmail(String email) {
  final regex =RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  return regex.hasMatch(email);
}

bool isValidPassword(String password) {
  if (password.length <= 8) {
    return false;
  }
  final regex = RegExp(r'^[a-zA-Z0-9]+$');
  if (!regex.hasMatch(password)) {
    return false;
  }
  return true;
}
