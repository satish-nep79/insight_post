class Validators {
  static String? checkFieldEmpty(String? fieldContent) {
    if (fieldContent!.isEmpty) {
      return 'This field is required';
    }
    return null;
  }

  static String? checkEmailField(String? fieldContent) {
    // Regular expression for email validation
    final RegExp emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    if (fieldContent == null || fieldContent.isEmpty) {
      return 'Email is required';
    } else if (!emailRegex.hasMatch(fieldContent)) {
      return 'Enter a valid email address';
    }
    return null; // Returns null if the email is valid
  }
}
