bool isEmail(String value) {
  // Use regex to validate email format
  return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value);
}