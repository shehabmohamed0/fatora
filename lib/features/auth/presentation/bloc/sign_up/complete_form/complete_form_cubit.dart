import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fatora/core/form_inputs/email.dart';
import 'package:fatora/core/form_inputs/password.dart';
import 'package:formz/formz.dart';
import 'package:injectable/injectable.dart';

part 'complete_form_state.dart';
@injectable
class CompleteFormCubit extends Cubit<CompleteFormState> {
  CompleteFormCubit() : super(const CompleteFormState());

  void emailChanged(String value) {
    final email = Email.dirty(value);
    emit(
      state.copyWith(
        email: email,
        status: _validateWithNew(email: email),
      ),
    );
  }

  void passwordChanged(String value) {
    final password = Password.dirty(value);

    emit(
      state.copyWith(
        password: password,
        status: _validateWithNew(
          password: password,
        ),
      ),
    );
  }

  FormzStatus _validateWithNew({
    Email? email,
    Password? password,
  }) {
    return Formz.validate([
      email ?? state.email,
      password ?? state.password,
    ]);
  }
}
