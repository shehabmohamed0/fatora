import 'package:equatable/equatable.dart';
import 'package:fatora/core/errors/failures/auth/sign_in_with_credential_failure.dart';
import 'package:fatora/core/errors/failures/failures.dart';
import 'package:fatora/core/form_inputs/confirmed_password.dart';
import 'package:fatora/core/form_inputs/email.dart';
import 'package:fatora/core/form_inputs/password.dart';
import 'package:fatora/core/form_inputs/phone_number.dart';
import 'package:fatora/core/params/auth/phone_sign_up_params.dart';
import 'package:fatora/features/auth/domain/usecases/phone_sign_up.dart';
import 'package:fatora/features/auth/presentation/bloc/sign_up/otp_cubit/otp_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../core/form_inputs/name.dart';

part 'sign_up_form_state.dart';

@injectable
class SignUpFormCubit extends Cubit<SignUpFormState> {
  SignUpFormCubit() : super(const SignUpFormState());

  void nameChanged(String value) {
    final name = Name.dirty(value);
    emit(
      state.copyWith(
        name: name,
        status: _validateWithNew(name: name),
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

  FormzStatus _validateWithNew({
    Name? name,
    PhoneNumber? phoneNumber,
  }) {
    return Formz.validate(
        [name ?? state.name, phoneNumber ?? state.phoneNumber]);
  }

  Future<void> signUpFormSubmitted(BuildContext context) async {
    if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));

    await context
        .read<OTPCubit>()
        .verifyPhoneNumber(state.phoneNumber.value, context);
  }

  void resetSubmissition() {
    emit(state.copyWith(status: _validateWithNew()));
  }

  void submissionFailure(Failure failure) {
    if (failure is ServerFailure) {
      emit(
        state.copyWith(
          status: FormzStatus.submissionFailure,
          errorMessage: failure.message,
        ),
      );
    } else if (failure is SignInWithCredentialFailure) {
      emit(
        state.copyWith(
          status: FormzStatus.submissionFailure,
          errorMessage: failure.message,
        ),
      );
    }
  }
}
