part of 'add_email_cubit.dart';

class AddEmailState extends Equatable {
  const AddEmailState({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.status = FormzStatus.pure,
    this.errorMessage,
  });
  final Email email;
  final Password password;
  final FormzStatus status;
  final String? errorMessage;
  AddEmailState copyWith({
    Email? email,
    Password? password,
    FormzStatus? status,
    String? errorMessage,
  }) {
    return AddEmailState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props => [email, password, status];
}
