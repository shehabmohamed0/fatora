import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fatora/core/errors/failures/auth/link_email_and_password_failure.dart';
import 'package:fatora/core/form_inputs/email.dart';
import 'package:fatora/core/form_inputs/password.dart';
import 'package:fatora/core/params/auth/link_email_and_password_params.dart';
import 'package:fatora/features/auth/domain/usecases/link_email_and_password.dart';
import 'package:formz/formz.dart';
import 'package:injectable/injectable.dart';

part 'complete_form_state.dart';

@injectable
class CompleteFormCubit extends Cubit<CompleteFormState> {
  final LinkEmailAndPassword _linkEmailAndPassword;
  CompleteFormCubit(this._linkEmailAndPassword)
      : super(const CompleteFormState());

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

  void reset() {
    emit(const CompleteFormState());
  }

  Future<void> submit() async {
    if (state.status.isInvalid) return;
    final either = await _linkEmailAndPassword(
      params: LinkEmailAndPasswordParams(
        email: state.email.value,
        password: state.password.value,
      ),
    );
    either.fold((failure) {
      if (failure is LinkEmailAndPasswordFailure) {
        emit(state.copyWith(
            status: FormzStatus.submissionFailure,
            errorMessage: failure.message));
        emit(state.copyWith(status: FormzStatus.valid));
      }
    }, (success) {
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    });
  }
}
