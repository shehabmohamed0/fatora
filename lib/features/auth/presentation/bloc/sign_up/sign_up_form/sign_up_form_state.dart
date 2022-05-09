part of 'sign_up_form_cubit.dart';

enum ConfirmPasswordValidationError { invalid }

class SignUpFormState extends Equatable {
  const SignUpFormState({
    this.name = const Name.pure(),
    this.phoneNumber = const PhoneNumber.pure(),
    this.phoneAuth,
    this.status = FormzStatus.pure,
    this.errorMessage,
  });

  final Name name;
  final PhoneNumber phoneNumber;
  final FormzStatus status;
  final AuthCredential? phoneAuth;
  final String? errorMessage;

  @override
  List<Object> get props => [name, phoneNumber, status];

  SignUpFormState copyWith(
      {Email? email,
      Password? password,
      ConfirmedPassword? confirmedPassword,
      Name? name,
      int? step,
      PhoneNumber? phoneNumber,
      FormzStatus? status,
      String? errorMessage,
      AuthCredential? phoneAuth}) {
    return SignUpFormState(
      phoneNumber: phoneNumber ?? this.phoneNumber,
      name: name ?? this.name,
      phoneAuth: phoneAuth ?? this.phoneAuth,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
