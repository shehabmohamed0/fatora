import 'package:equatable/equatable.dart';
import 'package:fatora/core/form_inputs/confirmed_password.dart';
import 'package:fatora/core/form_inputs/email.dart';
import 'package:fatora/core/form_inputs/password.dart';
import 'package:fatora/core/form_inputs/phone_number.dart';
import 'package:fatora/core/params/auth/phone_sign_up_params.dart';
import 'package:fatora/features/auth/domain/usecases/full_sign_up.dart';
import 'package:fatora/features/auth/domain/usecases/phone_sign_up.dart';
import 'package:fatora/features/auth/presentation/bloc/sign_up/flow_cubit/sign_up_flow_cubit.dart';
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
  SignUpFormCubit(this._fullSignUp, this._phoneSignUp)
      : super(const SignUpFormState());

  final FullSignUp _fullSignUp;
  final PhoneSignUp _phoneSignUp;

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

  Future<void> phoneVerified(AuthCredential authCredential) async {
    final either = await _phoneSignUp(
      params: PhoneSignUpParams(
        name: state.name.value,
        phoneNumber: state.phoneNumber.value,
        phoneCredential: authCredential,
      ),
    );

    either.fold((failure) {}, (success) {
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    });
  }

  Future<void> signUpWithPhone() async {
    await _phoneSignUp(
        params: PhoneSignUpParams(
            name: state.name.value,
            phoneNumber: state.phoneNumber.value,
            phoneCredential: state.phoneAuth!));
  }

  Future<void> signUpFormSubmitted(BuildContext context) async {
    if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));

   await Future.delayed(const Duration(seconds: 2));
    await context
        .read<OTPCubit>()
        .verifyPhoneNumber(state.phoneNumber.value, context);

    emit(state.copyWith(status: FormzStatus.submissionSuccess));
    //context.read<SignUpFlowCubit>().nextStep();

    // final either = await _signUp(
    //   params: SignUpParams(
    //     email: state.email.value,
    //     password: state.password.value,
    //     name: state.name.value,
    //     phoneNumber: state.phoneNumber.value,
    //   ),
    // );
    // either.fold(
    //   (failure) {
    //     if (failure is SignUpWithEmailAndPasswordFailure) {
    //       emit(
    //         state.copyWith(
    //             errorMessage: failure.message,
    //             status: FormzStatus.submissionFailure),
    //       );
    //     } else {
    //       emit(state.copyWith(status: FormzStatus.submissionFailure));
    //     }
    //   },
    //   (success) {
    //     emit(state.copyWith(status: FormzStatus.submissionSuccess));
    //   },
    // );
  }

  void resetSubmissition() {
    emit(state.copyWith(status: FormzStatus.valid));
  }
}
