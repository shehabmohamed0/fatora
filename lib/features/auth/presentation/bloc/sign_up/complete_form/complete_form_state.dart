part of 'complete_form_cubit.dart';

class CompleteFormState extends Equatable {
  const CompleteFormState(
      {this.email = const Email.pure(),
      this.password = const Password.pure(),
      this.status = FormzStatus.pure});
  final Email email;
  final Password password;
  final FormzStatus status;
  @override
  List<Object> get props => [email, password, status];

  CompleteFormState copyWith({
    Email? email,
    Password? password,
    FormzStatus? status,
  }) {
    return CompleteFormState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
    );
  }
}
