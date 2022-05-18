import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fatora/core/form_inputs/email.dart';
import 'package:fatora/core/form_inputs/password.dart';
import 'package:formz/formz.dart';
import 'package:injectable/injectable.dart';

part 'add_email_state.dart';

@injectable
class AddEmailCubit extends Cubit<AddEmailState> {
  AddEmailCubit() : super(const AddEmailState());

  void emailChanged(String value) {
    final email = Email.dirty(value);
    emit(
      state.copyWith(
        email: email,
        status: Formz.validate([email, state.password]),
      ),
    );
  }

  void passwordChanged(String value) {
    final password = Password.dirty(value);
    emit(
      state.copyWith(
        password: password,
        status: Formz.validate([state.email, password]),
      ),
    );
  }
}
