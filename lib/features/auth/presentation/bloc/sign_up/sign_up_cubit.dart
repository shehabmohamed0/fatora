import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fatora/core/form_inputs/confirmed_password.dart';
import 'package:fatora/core/form_inputs/email.dart';
import 'package:fatora/core/form_inputs/optional_name.dart';
import 'package:fatora/core/form_inputs/password.dart';
import 'package:fatora/core/form_inputs/phone_number.dart';
import 'package:fatora/core/params/auth/sign_up_params.dart';
import 'package:fatora/features/auth/domain/usecases/sign_up.dart';
import 'package:formz/formz.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/errors/failures/auth/sign_up_with_email_and_password_exception.dart';
import '../../../../../core/form_inputs/name.dart';

part 'sign_up_state.dart';

@injectable
class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit(this._signUpWithEmailAndPassword) : super(const SignUpState());

  final SignUp _signUpWithEmailAndPassword;

  void emailChanged(String value) {
    final email = Email.dirty(value);
    emit(
      state.copyWith(
        email: email,
        status: _validateWithNew(email: email),
      ),
    );
  }

  void phoneChanged(String value) {
    final phoneNumber = PhoneNumber.dirty(value);
    emit(
      state.copyWith(
        phoneNumber: phoneNumber,
        status: _validateWithNew(phoneNumber: phoneNumber),
      ),
    );
  }

  void firstNameChanged(String value) {
    final firstName = Name.dirty(value);
    emit(
      state.copyWith(
        firstName: firstName,
        status: _validateWithNew(firstName: firstName),
      ),
    );
  }

  void lastNameChanged(String value) {
    final lastName = OptionalName.dirty(value);
    emit(
      state.copyWith(lastName: lastName),
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
    Name? firstName,
    OptionalName? lastName,
    PhoneNumber? phoneNumber,
  }) {
    return Formz.validate([
      email ?? state.email,
      password ?? state.password,
      firstName ?? state.firstName,
      lastName ?? state.lastName,
      phoneNumber ?? state.phoneNumber,
    ]);
  }

  Future<void> signUpFormSubmitted() async {
    if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));

    final either = await _signUpWithEmailAndPassword(
        params: SignUpParams(
            email: state.email.value,
            password: state.password.value,
            name: state.firstName.value,
            phoneNumber: state.phoneNumber.value));

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
