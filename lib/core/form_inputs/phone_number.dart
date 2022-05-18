import 'package:formz/formz.dart';

/// Validation errors for the [Phone Number] [FormzInput].
enum PhoneValidationError {
  /// Generic invalid error.
  invalid,
}

/// {@template phone}
/// Form input for an phone input.
/// {@endtemplate}
class PhoneNumber extends FormzInput<String, PhoneValidationError> {
  /// {@macro phone}
  const PhoneNumber.pure() : super.pure('');

  /// {@macro phone}
  const PhoneNumber.dirty([String value = '']) : super.dirty(value);

  static final RegExp _phoneRegExp = RegExp(
    r"^[+][0-9]+$",
  );
  @override
  PhoneValidationError? validator(String? value) {
    value ??= '';

    if (_phoneRegExp.hasMatch(value)) {
      if (value.startsWith('+201') && value.length == 13) {
        return null;
      }
    }
    return PhoneValidationError.invalid;
  }
}

extension ValidationError on PhoneNumber {
  String? validationMessage() {
    if (invalid) {
      if (error == PhoneValidationError.invalid) {
        return 'Invalid phone number.';
      }
    }
    return null;
  }

  String? validationMessageWithOldPhone(String oldPHoneNumber) {
    if (invalid) {
      if (error == PhoneValidationError.invalid) {
        return 'Invalid phone number.';
      }
    } else if (value == oldPHoneNumber) {
      return 'This phone number already linked';
    }
    return null;
  }
}
