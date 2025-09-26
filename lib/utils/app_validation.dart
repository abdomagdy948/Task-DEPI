class AppValidation {
  static String? validation({
    String? email,
    String? password,
    String? phone,
    String? username,
    AppValidationType? type,
  }) {
    if (type == AppValidationType.email) {
      if (email == null || email.isEmpty) {
        return 'Email is required';
      } else if (!emailRegExp.hasMatch(email)) {
        return 'Enter a valid email address';
      }
    } else if (type == AppValidationType.password) {
      if (password == null || password.isEmpty) {
        return 'Password is required';
      } else if (!passwordRegExp.hasMatch(password)) {
        return 'Invalid password';
      }
    } else if (type == AppValidationType.phone) {
      if (phone == null || phone.isEmpty) {
        return 'Phone number is required';
      } else if (!phoneRegExp.hasMatch(phone)) {
        return 'Invalid phone number';
      }
    } else if (type == AppValidationType.username) {
      if (username == null || username.isEmpty) {
        return 'Username is required';
      } else if (!usernameRegExp.hasMatch(username)) {
        return 'Invalid username';
      }
    }
    return null;
  }
}

RegExp emailRegExp = RegExp(
  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
);
RegExp passwordRegExp = RegExp(
  r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$',
);
RegExp phoneRegExp = RegExp(r'^\d+$');

RegExp usernameRegExp = RegExp(r'^[a-zA-Z0-9_]{3,}$');

enum AppValidationType { email, password, username, phone }
