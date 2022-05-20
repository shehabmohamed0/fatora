import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fatora/core/errors/failures/auth/link_email_and_password_failure.dart';
import 'package:fatora/core/errors/failures/failures.dart';
import 'package:fatora/core/errors/failures/reauthenticate_user_failure.dart';
import 'package:fatora/core/form_inputs/email.dart';
import 'package:fatora/core/form_inputs/password.dart';
import 'package:fatora/core/params/auth/link_email_and_password_params.dart';
import 'package:fatora/features/auth/domain/usecases/link_email_and_password.dart';
import 'package:formz/formz.dart';
import 'package:injectable/injectable.dart';

part 'add_email_state.dart';

@injectable
class AddEmailCubit extends Cubit<AddEmailState> {
  AddEmailCubit(this._linkEmailAndPassword) : super(const AddEmailState());
  final LinkEmailAndPassword _linkEmailAndPassword;
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

  Future<void> submit() async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    final either = await _linkEmailAndPassword(
      params: LinkEmailAndPasswordParams(
          email: state.email.value, password: state.password.value),
    );
    either.fold((failure) {
      if (failure is LinkEmailAndPasswordFailure) {
        emit(state.copyWith(
            errorMessage: failure.message,
            status: FormzStatus.submissionFailure));
      } else if (failure is ReAuthenticateUserFailure) {
        emit(state.copyWith(
            errorMessage: failure.message,
            status: FormzStatus.submissionCanceled));
      } else if (failure is ServerFailure) {
        emit(state.copyWith(
            errorMessage: failure.message,
            status: FormzStatus.submissionFailure));
      }
    }, (success) {
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    });
  }
}
