import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fatora/core/form_inputs/confirmed_password.dart';
import 'package:fatora/core/form_inputs/email.dart';
import 'package:fatora/core/form_inputs/password.dart';
import 'package:fatora/core/params/auth/sign_up_params.dart';
import 'package:fatora/features/auth/domain/usecases/sign_up_with_email_and_password.dart';
import 'package:formz/formz.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/errors/failures/auth/sign_up_with_email_and_password_exception.dart';

part 'sign_up_state.dart';

@injectable
class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit(this._signUpWithEmailAndPassword) : super(const SignUpState());

  final SignUpWithEmailAndPassword _signUpWithEmailAndPassword;

  void emailChanged(String value) {
    final email = Email.dirty(value);
    emit(
      state.copyWith(
        email: email,
        status: Formz.validate([
          email,
          state.password,
          state.confirmedPassword,
        ]),
      ),
    );
  }

  void passwordChanged(String value) {
    final password = Password.dirty(value);
    final confirmedPassword = ConfirmedPassword.dirty(
      password: password.value,
      value: state.confirmedPassword.value,
    );
    emit(
      state.copyWith(
        password: password,
        confirmedPassword: confirmedPassword,
        status: Formz.validate([
          state.email,
          password,
          confirmedPassword,
        ]),
      ),
    );
  }

  void confirmedPasswordChanged(String value) {
    final confirmedPassword = ConfirmedPassword.dirty(
      password: state.password.value,
      value: value,
    );
    emit(
      state.copyWith(
        confirmedPassword: confirmedPassword,
        status: Formz.validate([
          state.email,
          state.password,
          confirmedPassword,
        ]),
      ),
    );
  }

  Future<void> signUpFormSubmitted() async {
    if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));

    final either = await _signUpWithEmailAndPassword(
        params: SignUpParams(
            email: state.email.value, password: state.password.value));

    either.fold(
      (failure) {
        if (failure is SignUpWithEmailAndPasswordFailure) {
          emit(
            state.copyWith(
                errorMessage: failure.message,
                status: FormzStatus.submissionFailure),
          );
        } else {
          emit(state.copyWith(status: FormzStatus.submissionFailure));
        }
      },
      (success) {
        emit(state.copyWith(status: FormzStatus.submissionSuccess));
      },
    );
  }
}
