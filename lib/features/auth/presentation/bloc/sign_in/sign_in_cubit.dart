import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fatora/core/errors/failures/auth/sign_in_with_email_and_password_exception.dart';
import 'package:fatora/core/form_inputs/email.dart';
import 'package:fatora/core/form_inputs/password.dart';
import 'package:fatora/core/params/auth/sign_in_params.dart';
import 'package:fatora/features/auth/domain/usecases/sign_in_with_email_and_password.dart';
import 'package:formz/formz.dart';
import 'package:injectable/injectable.dart';

part 'sign_in_state.dart';

@injectable
class SignInCubit extends Cubit<SignInState> {
  final SignInWithEmailAndPassword _signInWithEmailAndPassword;
  SignInCubit(this._signInWithEmailAndPassword) : super(const SignInState());

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

  Future<void> signInWithCredentials() async {
    if (!state.status.isValidated) return;

    final either = await _signInWithEmailAndPassword(
        params: SignInParams(
            email: state.email.value, password: state.password.value));

    either.fold(
      (failure) {
        if (failure is SignInWithEmailAndPasswordFailure) {
          emit(
            state.copyWith(
              errorMessage: failure.message,
              status: FormzStatus.submissionFailure,
            ),
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