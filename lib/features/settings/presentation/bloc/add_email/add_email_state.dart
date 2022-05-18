part of 'add_email_cubit.dart';

class AddEmailState extends Equatable {
  const AddEmailState({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.status = FormzStatus.pure,
  });
  final Email email;
  final Password password;
  final FormzStatus status;

  AddEmailState copyWith({
    Email? email,
    Password? password,
    FormzStatus? status,
  }) {
    return AddEmailState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [email, password, status];
}
