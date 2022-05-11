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
    r"^[0-9]+$",
  );
  @override
  PhoneValidationError? validator(String? value) {
    value ??= '';

    if (_phoneRegExp.hasMatch(value) &&
        value.startsWith('01') &&
        value.length == 11) {
      return null;
    }
    return PhoneValidationError.invalid;
  }
}
