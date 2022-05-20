import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fatora/core/errors/failures/failures.dart';
import 'package:fatora/core/errors/failures/firestore_failure.dart';
import 'package:fatora/core/errors/failures/settings/update_email_failure.dart';
import 'package:fatora/core/form_inputs/email.dart';
import 'package:fatora/core/form_inputs/password.dart';
import 'package:fatora/core/params/settings/update_email.dart';
import 'package:fatora/features/settings/domain/usecases/update_email.dart';
import 'package:formz/formz.dart';
import 'package:injectable/injectable.dart';

part 'update_email_state.dart';

@injectable
class UpdateEmailCubit extends Cubit<UpdateEmailState> {
  UpdateEmailCubit(this._updateEmail) : super(const UpdateEmailState());
  final UpdateEmail _updateEmail;

  void emailChanged(String val) {
    final email = Email.dirty(val);
    emit(state.copyWith(
      email: email,
      status: Formz.validate([email, state.password]),
    ));
  }

  void passwordChanged(String val) {
    final password = Password.dirty(val);
    emit(
      state.copyWith(
        password: password,
        status: Formz.validate([state.email, password]),
      ),
    );
  }

  Future<void> submit(String currentEmail) async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    final either = await _updateEmail(
      params: UpdateEmailParams(
        newEmail: state.email.value,
        currentEmail: currentEmail,
        currentPassword: state.password.value,
      ),
    );

    either.fold((failure) {
      if (failure is UpdateEmailFailure) {
        emit(state.copyWith(
          errorMessage: failure.message,
          status: FormzStatus.submissionFailure,
        ));
      } else if (failure is FirestoreFailure) {
        emit(state.copyWith(
          errorMessage: 'Firestore error',
          status: FormzStatus.submissionFailure,
        ));
      } else if (failure is ServerFailure) {
        emit(state.copyWith(
          errorMessage: failure.message,
          status: FormzStatus.submissionFailure,
        ));
      }
    }, (success) {
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    });
  }
}
